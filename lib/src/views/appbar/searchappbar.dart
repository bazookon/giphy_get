import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/type.dart';
import 'package:giphy_get/src/providers/app_bar_provider.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatefulWidget {
  // Scroll Controller
  final ScrollController scrollController;

  SearchAppBar({Key? key, required this.scrollController}) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  // Tab Provider
  late TabProvider _tabProvider;

  // AppBar Provider
  late AppBarProvider _appBarProvider;

  // Sheet Provider
  late SheetProvider _sheetProvider;

  // Input controller
  final TextEditingController _textEditingController =
      new TextEditingController();
  // Input Focus
  final FocusNode _focus = new FocusNode();

  //Colors
  late Color _canvasColor;
  late Color _searchBackgroundColor;

  //Is DarkMode
  late bool _isDarkMode;

  @override
  void initState() {
    // Focus
    _focus.addListener(_focusListener);

    // Listener TextField
    _textEditingController.addListener(() {
      if (_textEditingController.text.isNotEmpty) {
        _appBarProvider.queryText = _textEditingController.text;
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //Colors
    _canvasColor = Theme.of(context).canvasColor;
    _searchBackgroundColor = Theme.of(context).textTheme.bodyText1!.color!;

    //Is DarkMode
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
      backgroundColor: _canvasColor,
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
            color: _searchBackgroundColor,
          ),
          _tabProvider.tabType == GiphyType.emoji
              ? Container(height: 40.0, child: _giphyLogo())
              : Container(
                  height: 40.0,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextField(
                        autofocus: _sheetProvider.initialExtent ==
                            SheetProvider.maxExtent,
                        focusNode: _focus,
                        controller: _textEditingController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: _searchIcon(),
                            hintStyle: TextStyle(color: Colors.black45),
                            hintText: _tabProvider.searchText,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 10.5, top: 10.5, right: 15),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none),
                        autocorrect: false,
                      ),
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
      width: 100.0,
      package: 'giphy_get',
    ));
  }

  Widget _searchIcon() {
    if (kIsWeb) {
      return Icon(Icons.search);
    } else {
      return ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFFF6666),
              Color(0xFF9933FF),
            ]).createShader(bounds),
        child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Icon(
              Icons.search,
              color: Colors.white,
            )),
      );
    }
  }

  void _focusListener() {
    // Set to max extent height if Textfield has focus
    if (_focus.hasFocus &&
        _sheetProvider.initialExtent == SheetProvider.minExtent) {
      _sheetProvider.initialExtent = SheetProvider.maxExtent;
    }
    print("Focus : ${_focus.hasFocus}");
  }
}
