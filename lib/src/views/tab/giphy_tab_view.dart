import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/type.dart';

import 'giphy_tab_detail.dart';

class GiphyTabView extends StatelessWidget {
  final ScrollController? scrollController;
  final TabController tabController;

  /// Optional custom widget to show while loading
  final Widget? loadingWidget;

  /// Optional custom widget to show on load failure
  final Widget? failedWidget;

  const GiphyTabView({
    Key? key,
    required this.scrollController,
    required this.tabController,
    this.showEmojis = true,
    this.showGIFs = true,
    this.showStickers = true,
    this.loadingWidget,
    this.failedWidget,
  }) : super(key: key);

  final bool showGIFs;
  final bool showStickers;
  final bool showEmojis;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        if (showGIFs)
          GiphyTabDetail(
            type: GiphyType.gifs,
            scrollController: scrollController ?? ScrollController(),
            key: null,
            loadingWidget: loadingWidget,
            failedWidget: failedWidget,
          ),
        if (showStickers)
          GiphyTabDetail(
            type: GiphyType.stickers,
            scrollController: scrollController ?? ScrollController(),
            loadingWidget: loadingWidget,
            failedWidget: failedWidget,
          ),
        if (showEmojis)
          GiphyTabDetail(
            type: GiphyType.emoji,
            scrollController: scrollController ?? ScrollController(),
            loadingWidget: loadingWidget,
            failedWidget: failedWidget,
          )
      ],
    );
  }
}
