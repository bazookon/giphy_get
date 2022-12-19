import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/type.dart';

import 'giphy_tab_detail.dart';

class GiphyTabView extends StatelessWidget {
  final ScrollController scrollController;
  final TabController tabController;

  const GiphyTabView({
    Key? key,
    required this.scrollController,
    required this.tabController,
    this.showEmojis = true,
    this.showGIFs = true,
    this.showStickers = true,
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
            scrollController: scrollController,
            key: null,
          ),
        if (showStickers)
          GiphyTabDetail(
            type: GiphyType.stickers,
            scrollController: scrollController,
          ),
        if (showEmojis)
          GiphyTabDetail(
            type: GiphyType.emoji,
            scrollController: scrollController,
          )
      ],
    );
  }
}
