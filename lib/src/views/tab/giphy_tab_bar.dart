import 'package:flutter/material.dart';
import 'package:giphy_get/l10n.dart';
import 'package:giphy_get/src/client/models/type.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:provider/provider.dart';

class GiphyTabBar extends StatefulWidget {
  final TabController tabController;
  const GiphyTabBar({
    Key? key,
    required this.tabController,
    this.showEmojis = true,
    this.showGIFs = true,
    this.showStickers = true,
  }) : super(key: key);

  final bool showGIFs;
  final bool showStickers;
  final bool showEmojis;

  @override
  _GiphyTabBarState createState() => _GiphyTabBarState();
}

class _GiphyTabBarState extends State<GiphyTabBar> {
  late TabProvider _tabProvider;
  late List<Tab> _tabs;

  @override
  void initState() {
    super.initState();

    // TabProvider
    _tabProvider = Provider.of<TabProvider>(context, listen: false);

    //  Listen Tab Controller
    widget.tabController.addListener(() {
      _setTabType(widget.tabController.index);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setTabType(0);
    });
  }

  @override
  void didChangeDependencies() {
    // Set TabList
    final l = GiphyGetUILocalizations.labelsOf(context);
    _tabs = [
      if (widget.showGIFs) Tab(text: l.gifsLabel),
      if (widget.showStickers) Tab(text: l.stickersLabel),
      if (widget.showEmojis) Tab(text: l.emojisLabel),
    ];

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //Dispose tabController
    widget.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabProvider = Provider.of<TabProvider>(context);

    if (_tabs.length == 1) return SizedBox();

    return TabBar(
      unselectedLabelColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black54
          : Colors.white54,
      labelColor:
          _tabProvider.tabColor ?? Theme.of(context).colorScheme.secondary,
      indicatorColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      controller: widget.tabController,
      tabs: _tabs,
      onTap: _setTabType,
    );
  }

  _setTabType(int pos) {
    String _tabType;
    // set Tab Type to provider
    switch (widget.tabController.index) {
      case 0:
        _tabType = GiphyType.gifs;
        break;
      case 1:
        _tabType = GiphyType.stickers;
        break;
      default:
        _tabType = GiphyType.emoji;
        break;
    }
    _tabProvider.tabType = _tabType;
  }
}
