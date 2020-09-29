import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/type.dart';
import 'package:giphy_get/src/providers/app_bar_provider.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatefulWidget {
  // Scroll Controller
  final ScrollController scrollController;

  SearchAppBar({Key key, this.scrollController}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  // Tab Provider
  TabProvider _tabProvider;

  // AppBar Provider
  AppBarProvider _appBarProvider;

  // Sheet Provider
  SheetProvider _sheetProvider;

  // Input controller
  TextEditingController _textEditingController = new TextEditingController();
  // Input Focus
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();

    _focus..addListener(_focusListener);

    // Listener TextField
    _textEditingController.addListener(() {
      _appBarProvider.queryText = _textEditingController.text;
    });
  }

  @override
  void didChangeDependencies() {
    // Providers
    _tabProvider = Provider.of<TabProvider>(context);

    _sheetProvider = Provider.of<SheetProvider>(context);

    // AppBar Provider
    _appBarProvider = Provider.of<AppBarProvider>(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0.0,
      titleSpacing: 10.0,
      automaticallyImplyLeading: false,
      title: _searchWidget(),
      actions: [],
    );
  }

  Widget _searchWidget() => Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            width: 50,
            height: 2,
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
          _tabProvider.tabType == GiphyType.emoji
              ? Container(
                height: 40.0,
                child: _giphyLogo())
              : Container(
                  decoration: BoxDecoration(
                      color: (Theme.of(context).brightness == Brightness.light)
                          ? Colors.grey[300]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(8.0)),
                  height: 40.0,
                  child: Center(
                    child: TextField(
                      autofocus: _sheetProvider.initialExtent ==
                          SheetProvider.maxExtent,
                      focusNode: _focus,
                      controller: _textEditingController,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          prefixIcon: _searchIcon(),
                          hintStyle: TextStyle(color: Colors.black45),
                          hintText: _tabProvider.searchText,
                          border: InputBorder.none),
                      autocorrect: false,
                    ),
                  ),
                ),
        ],
      );

  Widget _giphyLogo() {
    const basePath = "assets/img/";
    String logoPath = Theme.of(context).brightness == Brightness.light
        ? "GIPHY_light.png"
        : "GIPHY_dark.png";

    return Center(
        child: Image.asset(
      "$basePath$logoPath",
      package: 'giphy_get',
    ));
  }

  Widget _searchIcon() => ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pinkAccent,
              Colors.purple[700],
            ]).createShader(bounds),
        child: Icon(Icons.search),
      );

  void _focusListener() {
    // Set to max extent height if Textfield has focus
    if (_focus.hasFocus &&
        _sheetProvider.initialExtent == SheetProvider.minExtent) {
      _sheetProvider.initialExtent = SheetProvider.maxExtent;
    }
    print("Focus : ${_focus.hasFocus}");
  }
}
