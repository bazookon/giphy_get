import 'package:flutter/material.dart';
import 'package:giphy_client/giphy_client.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class GiphyTabBar extends StatefulWidget {
  const GiphyTabBar({Key key}) : super(key: key);

  @override
  _GiphyTabBarState createState() => _GiphyTabBarState();
}

class _GiphyTabBarState extends State<GiphyTabBar> {
  TabProvider _tabProvider;

  @override
  void initState() {
    super.initState();
    _tabProvider = Provider.of<TabProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setTabType(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    _tabProvider = Provider.of<TabProvider>(context);

    return TabBar(
      unselectedLabelColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black54
          : Colors.white54,
      labelColor: _tabProvider.tabColor ?? Theme.of(context).accentColor,
      indicatorColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        Tab(
          text: "GIFs",
        ),
        Tab(
          text: "Stickers",
        ),
        Tab(
          text: "Emoji",
        ),
      ],
      onTap: _setTabType,
    );
  }

  _setTabType(int pos) {
    String _tabType;
    // set Tab Type to provider
    switch (pos) {
      case 0:
        _tabType = GiphyType.gifs;
        break;
      case 1:
        _tabType = GiphyType.stickers;
        break;
      default:
        _tabType = GiphyType.emoji;
    }
    _tabProvider.tabType = _tabType;
  }
}
