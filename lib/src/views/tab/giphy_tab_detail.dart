import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:giphy_get/src/client/client.dart';
import 'package:giphy_get/src/client/models/collection.dart';
import 'package:giphy_get/src/client/models/gif.dart';
import 'package:giphy_get/src/client/models/type.dart';
import 'package:giphy_get/src/providers/app_bar_provider.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class GiphyTabDetail extends StatefulWidget {
  final String type;
  final ScrollController scrollController;
  GiphyTabDetail({Key key, @required this.type, this.scrollController})
      : super(key: key);

  @override
  _GiphyTabDetailState createState() => _GiphyTabDetailState();
}

class _GiphyTabDetailState extends State<GiphyTabDetail> {
  // Tab Provider
  TabProvider _tabProvider;

  // AppBar Provider
  AppBarProvider _appBarProvider;

  // Collection
  GiphyCollection _collection;

  // List of gifs
  List<GiphyGif> _list = [];

  // Direction
  Axis _scrollDirection;

  // Axis count
  int _crossAxisCount;

  // Spacing between gifs in grid
  double _spacing = 8.0;

  // Default gif with
  double _gifWidth;

  // Limit of query
  int _limit;

  // is Loading gifs
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Tab Provider
    _tabProvider = Provider.of<TabProvider>(context, listen: false);

    // AppBar Provider
    _appBarProvider = Provider.of<AppBarProvider>(context, listen: false);

    // GridOptions
    _scrollDirection = Axis.vertical;

    // Gif WIDTH
    switch (widget.type) {
      case GiphyType.gifs:
        _gifWidth = 200.0;
        break;
      case GiphyType.stickers:
        _gifWidth = 150.0;
        break;
      case GiphyType.emoji:
        _gifWidth = 80.0;
        break;
      default:
        break;
    }

    // ScrollController
    widget.scrollController..addListener(_scrollListener);

    // Listen query
    _appBarProvider.addListener(_listenerQuery);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Set items count responsive
    _crossAxisCount = (MediaQuery.of(context).size.width / _gifWidth).round();

    // Set vertical max items count
    int _mainAxisCount =
        ((MediaQuery.of(context).size.height - 20) / _gifWidth).round();

    _limit = _crossAxisCount * _mainAxisCount;

    // Load Initial Data
    _loadMore();
  }

  @override
  void dispose() {
    // dispose listener
    // Important
    widget.scrollController.removeListener(_scrollListener);
    _appBarProvider.removeListener(_listenerQuery);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_list.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StaggeredGridView.countBuilder(
          scrollDirection: _scrollDirection,
          controller: widget.scrollController,
          itemCount: _list.length,
          crossAxisCount: _crossAxisCount,
          mainAxisSpacing: _spacing,
          crossAxisSpacing: _spacing,
          itemBuilder: (ctx, idx) {
            GiphyGif _gif = _list[idx];
            if (_gif == null) return Container();

            return _item(_gif);
          },
          staggeredTileBuilder: (idx) => StaggeredTile.fit(1)),
    );
  }

  Widget _item(GiphyGif gif) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: InkWell(
            onTap: () => _selectedGif(gif),
            child: ExtendedImage.network(gif.images.fixedWidth.webp,
                cache: true,
                fit: BoxFit.fill,
                headers: {'accept': 'image/*'}, loadStateChanged: (state) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: case2(
                    state.extendedImageLoadState,
                    {
                      LoadState.loading: Container(
                        color: Theme.of(context).cardColor,
                        width: _gifWidth,
                        height: double.parse(gif.images.fixedWidth.height) *
                            (_gifWidth /
                                double.parse(gif.images.fixedWidth.width)),
                      ),
                      LoadState.completed: ExtendedRawImage(
                        image: state.extendedImageInfo?.image,
                        width: _gifWidth,
                        height: double.parse(gif.images.fixedWidth.height) *
                            (_gifWidth /
                                double.parse(gif.images.fixedWidth.width)),
                        fit: widget.type == GiphyType.gifs
                            ? BoxFit.fill
                            : BoxFit.fitWidth,
                      ),
                      LoadState.failed: Container(
                        color: Theme.of(context).cardColor,
                        width: _gifWidth,
                        height: double.parse(gif.images.fixedWidth.height) *
                            (_gifWidth /
                                double.parse(gif.images.fixedWidth.width)),
                      ),
                    },
                    Container(
                      color: Theme.of(context).cardColor,
                      width: _gifWidth,
                      height: double.parse(gif.images.fixedWidth.height) *
                          (_gifWidth /
                              double.parse(gif.images.fixedWidth.width)),
                    )),
              );
            })));
  }

  Future<void> _loadMore() async {
    //Return if is loading or no more gifs
    if (_isLoading || _collection?.pagination?.totalCount == _list.length)
      return;

    _isLoading = true;

    // Giphy Client from library
    GiphyClient client = GiphyClient(
        apiKey: _tabProvider.apiKey, randomId: _tabProvider.randomID);

    // Offset pagination for query
    int offset = _collection == null
        ? 0
        : _collection.pagination.offset + _collection.pagination.count;

    // Get Gif or Emoji
    if (widget.type == GiphyType.emoji) {
      _collection = await client.emojis(offset: offset, limit: _limit);
    } else {
      // If query text is not null search gif else trendings
      if (_appBarProvider.queryText.isNotEmpty &&
          widget.type != GiphyType.emoji) {
        _collection = await client.search(_appBarProvider.queryText,
            lang: _tabProvider.lang,
            offset: offset,
            rating: _tabProvider.rating,
            type: widget.type,
            limit: _limit);
      } else {
        _collection = await client.trending(
            lang: _tabProvider.lang,
            offset: offset,
            rating: _tabProvider.rating,
            type: widget.type,
            limit: _limit);
      }
    }

    // Set result to list
    if (_collection.data.isNotEmpty && mounted) {
      setState(() {
        _list.addAll(_collection.data);
      });
    }

    _isLoading = false;
  }

  // Scroll listener. if scroll end load more gifs
  void _scrollListener() {
    if ((widget.scrollController.position.extentAfter < 500) && !_isLoading) {
      _loadMore();
    }
  }

  // Return selected gif
  void _selectedGif(GiphyGif gif) {
    Navigator.pop(context, gif);
  }

  // listener query
  void _listenerQuery() {
    // Reset pagination
    _collection = null;

    // Reset list
    _list = [];

    // Load data
    _loadMore();
  }

  TValue case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue defaultValue = null,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }

    return branches[selectedOption];
  }
}
