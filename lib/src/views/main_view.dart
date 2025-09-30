import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/views/appbar/searchappbar.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_bar.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_bottom.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_top.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_view.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  MainView({
    Key? key,
    this.showEmojis = true,
    this.showGIFs = true,
    this.showStickers = true,
    this.tabTopBuilder,
    this.tabBottomBuilder,
    this.searchAppBarBuilder,
    required this.loadingWidget,
    required this.failedWidget,
  }) : super(key: key);

  final bool showGIFs;
  final bool showStickers;
  final bool showEmojis;
  final TabTopBuilder? tabTopBuilder;
  final TabBottomBuilder? tabBottomBuilder;
  final SearchAppBarBuilder? searchAppBarBuilder;

  /// Optional custom widget to show while loading
  final Widget? loadingWidget;

  /// Optional custom widget to show on load failure
  final Widget? failedWidget;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView>
    with SingleTickerProviderStateMixin {
  // Scroll Controller
  late ScrollController _scrollController;

  // Sheet Provider
  late SheetProvider _sheetProvider;

  // Tab Controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      length: [
        widget.showGIFs,
        widget.showEmojis,
        widget.showStickers,
      ].where((isShown) => isShown).length,
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    _sheetProvider = Provider.of<SheetProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _draggableScrollableSheet();
  }

  Widget _draggableScrollableSheet() => DraggableScrollableSheet(
      expand: _sheetProvider.isExpanded,
      minChildSize: SheetProvider.minExtent,
      maxChildSize: SheetProvider.maxExtent,
      initialChildSize: _sheetProvider.initialExtent,
      builder: (ctx, scrollController) {
        // Set ScrollController

        this._scrollController = scrollController;
        return _bottomSheetBody();
      });

  Widget _bottomSheetBody() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.tabTopBuilder?.call(context) ?? GiphyTabTop(),
          GiphyTabBar(
            tabController: _tabController,
            showGIFs: widget.showGIFs,
            showStickers: widget.showStickers,
            showEmojis: widget.showEmojis,
          ),
          SearchAppBar(
            scrollController: this._scrollController,
            searchAppBarBuilder: widget.searchAppBarBuilder,
          ),
          Expanded(
            child: GiphyTabView(
              tabController: _tabController,
              scrollController: this._scrollController,
              showGIFs: widget.showGIFs,
              showStickers: widget.showStickers,
              showEmojis: widget.showEmojis,
              loadingWidget: widget.loadingWidget,
              failedWidget: widget.failedWidget,
            ),
          ),
          widget.tabBottomBuilder?.call(context) ?? GiphyTabBottom(),
        ],
      );
}
