import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:giphy_get/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class GiphyGifWidget extends StatefulWidget {
  final GiphyGif gif;
  final GiphyGetWrapper giphyGetWrapper;
  final bool showGiphyLabel;
  final BorderRadius? borderRadius;
  final Alignment imageAlignment;
  const GiphyGifWidget(
      {Key? key,
      required this.gif,
      required this.giphyGetWrapper,
      this.borderRadius,
      this.imageAlignment = Alignment.center,
      this.showGiphyLabel = true})
      : super(key: key);

  @override
  State<GiphyGifWidget> createState() => _GiphyGifWidgetState();
}

class _GiphyGifWidgetState extends State<GiphyGifWidget> {
  bool _showMenu = false;
  Timer? _timerMenu;

  @override
  void dispose() {
    _timerMenu?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = GiphyGetUILocalizations.labelsOf(context);
    const TextStyle buttonsTextStyle = TextStyle(
      fontSize: 12,
      color: Colors.white,
    );

    return Container(
      child: Stack(
        alignment: widget.imageAlignment,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onLongPress: () {
                    _triggerShowHideMenu();
                  },
                  onTap: () {
                    setState(() {
                      _timerMenu?.cancel();
                      _showMenu = false;
                    });
                  },
                  child: Container(
                    width: double.parse(widget.gif.images!.fixedWidth.width),
                    height: double.parse(widget.gif.images!.fixedWidth.height),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius,
                    ),
                    child: ExtendedImage.network(
                      widget.gif.images!.fixedWidth.url,
                    ),
                  )),
              widget.showGiphyLabel
                  ? FittedBox(
                      child: Text(
                      l.poweredByGiphy,
                      style: TextStyle(fontSize: 12),
                    ))
                  : Container()
            ],
          ),
          IgnorePointer(
            ignoring: !_showMenu,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: _showMenu ? 1 : 0,
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          launchUrl(Uri.parse(widget.gif.url!));
                        },
                        child: Text(
                          l.viewOnGiphy,
                          style: buttonsTextStyle,
                        )),
                    Container(
                      height: 15,
                      child: VerticalDivider(
                        color: Colors.white54,
                        thickness: 1,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          widget.giphyGetWrapper
                              .getGif('@${widget.gif.username}', context);
                        },
                        child: Text('${l.moreBy} @${widget.gif.username}',
                            style: buttonsTextStyle))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _triggerShowHideMenu() {
    // Cancel Timer
    _timerMenu?.cancel();

    // Show menu
    setState(() {
      _showMenu = true;
    });

    // Triger Timer
    _timerMenu = Timer(Duration(seconds: 5), () {
      setState(() {
        _showMenu = !_showMenu;
      });
    });
  }
}
