import 'package:flutter/material.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/views/appbar/searchappbar.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_bar.dart';
import 'package:giphy_get/src/views/tab/giphy_tab_view.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  // Scroll Controller
  ScrollController _scrollController;

  // Sheet Provider
  SheetProvider _sheetProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _sheetProvider = Provider.of<SheetProvider>(context);
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
      key: Key("${_sheetProvider.initialExtent}"),
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
          SearchAppBar(scrollController: this._scrollController),
          Expanded(child: _defaultTabController())
        ],
      );

  Widget _defaultTabController() => DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GiphyTabBar(),
            Expanded(
                child: GiphyTabView(
              scrollController: this._scrollController,
            ))
          ],
        ),
      );
}
