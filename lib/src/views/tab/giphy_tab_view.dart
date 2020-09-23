import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/type.dart';

import 'giphy_tab_detail.dart';

class GiphyTabView extends StatelessWidget {
  final ScrollController scrollController;

  const GiphyTabView({Key key, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        GiphyTabDetail(
          type: GiphyType.gifs,
          scrollController: scrollController,
        ),
        GiphyTabDetail(
          type: GiphyType.stickers,
          scrollController: scrollController,
        ),
        GiphyTabDetail(
          type: GiphyType.emoji,
          scrollController: scrollController,
        )
      ],
    );
  }
}
