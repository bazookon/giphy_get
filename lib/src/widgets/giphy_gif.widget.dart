import 'dart:async';
import 'dart:ui'; // For ImageFilter.blur

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

  /// Optional custom widget to show while loading
  final Widget? loadingWidget;

  /// Optional custom widget to show on load failure

  /// GiphyGifWidget displays a single GIF with progressive loading.
  ///
  /// - Shows a blurred static thumbnail (if available) while the full GIF loads.
  /// - Swaps in the full GIF when ready, keeping the user visually engaged.
  /// - Used throughout the plugin for consistent, user-friendly loading feedback.
  final Widget? failedWidget;
  const GiphyGifWidget({
    Key? key,
    required this.gif,
    required this.giphyGetWrapper,
    this.borderRadius,
    this.imageAlignment = Alignment.center,
    this.showGiphyLabel = true,
    this.loadingWidget,
    this.failedWidget,
  }) : super(key: key);

  @override
  State<GiphyGifWidget> createState() => _GiphyGifWidgetState();
}

class _GiphyGifWidgetState extends State<GiphyGifWidget> {
  /// Utility function for switch-like mapping (copied from giphy_tab_detail.dart)
  TValue? case2<TOptionType, TValue>(
    TOptionType selectedOption,
    Map<TOptionType, TValue> branches, [
    TValue? defaultValue = null,
  ]) {
    if (!branches.containsKey(selectedOption)) {
      return defaultValue;
    }
    return branches[selectedOption];
  }

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

    // Progressive loading: use blurred thumbnail as placeholder
    final String? placeholderUrl = widget.gif.images?.fixedWidthStill?.url ??
        widget.gif.images?.previewWebp?.url ??
        widget.gif.images?.downsizedStill?.url;

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
                    fit: BoxFit.fill,
                    cache: true,
                    gaplessPlayback: true,
                    headers: {'accept': 'image/*'},
                    // Show blurred placeholder while loading
                    loadStateChanged: (state) {
                      final aspectRatio = double.parse(
                              widget.gif.images!.fixedWidth.width) /
                          double.parse(widget.gif.images!.fixedWidth.height);
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: case2(
                          state.extendedImageLoadState,
                          {
                            LoadState.loading: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: placeholderUrl != null
                                  ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                              sigmaX: 8, sigmaY: 8),
                                          child: Image.network(
                                            placeholderUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: widget.loadingWidget ??
                                              CircularProgressIndicator(
                                                  strokeWidth: 2),
                                        ),
                                      ],
                                    )
                                  : widget.loadingWidget ??
                                      Container(
                                        color: Theme.of(context).cardColor,
                                      ),
                            ),
                            LoadState.completed: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: ExtendedRawImage(
                                fit: BoxFit.fill,
                                image: state.extendedImageInfo?.image,
                              ),
                            ),
                            LoadState.failed: AspectRatio(
                              aspectRatio: aspectRatio,
                              child: widget.failedWidget ??
                                  Container(
                                    color: Theme.of(context).cardColor,
                                  ),
                            ),
                          },
                          AspectRatio(
                            aspectRatio: aspectRatio,
                            child: Container(
                              color: Theme.of(context).cardColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
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
                    color: Colors.black.withAlpha(180)),
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
                        widget.giphyGetWrapper.getGif(
                          '@${widget.gif.username}',
                          context,
                          loadingWidget: widget.loadingWidget,
                          failedWidget: widget.failedWidget,
                        );
                      },
                      child: Text(
                        '${l.moreBy} @${widget.gif.username}',
                        style: buttonsTextStyle,
                      ),
                    )
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
