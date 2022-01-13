import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/gif.dart';

class GiphyGifWidget extends StatefulWidget {
  final GiphyGif gif;
  final BorderRadius? borderRadius;
  const GiphyGifWidget({Key? key, required this.gif, this.borderRadius})
      : super(key: key);

  @override
  State<GiphyGifWidget> createState() => _GiphyGifWidgetState();
}

class _GiphyGifWidgetState extends State<GiphyGifWidget> {
  bool _showMenu = false;
  Timer? _timerMenu;

  @override
  Widget build(BuildContext context) {
    const TextStyle buttonsTextStyle = TextStyle(
      fontSize: 12,
      color: Colors.white,
    );

   

    @override
    void dispose() {
      _timerMenu?.cancel();
      super.dispose();
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                child: ExtendedImage.network(
                  widget.gif.images!.fixedWidth.url,
                  clipBehavior: Clip.hardEdge,
                  fit: BoxFit.fill,
                  borderRadius: widget.borderRadius,
                )),
            FittedBox(
                child: Text(
              'Powered by GIPHY',
              style: TextStyle(fontSize: 12),
            ))
          ],
        ),
        AnimatedOpacity(
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
                      print(widget.gif.url);
                    },
                    child: Text(
                      'View on Giphy',
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
                    onPressed: () {},
                    child: Text('More by @${widget.gif.username}',
                        style: buttonsTextStyle))
              ],
            ),
          ),
        )
      ],
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
