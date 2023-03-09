import 'package:flutter/material.dart';

class GiphyTabBottom extends StatelessWidget {
  const GiphyTabBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      child: Center(
        child: _giphyLogo(context),
      ),
    );
  }

  Widget _giphyLogo(BuildContext context) {
    const basePath = "assets/img/";
    String logoPath = Theme.of(context).brightness == Brightness.light
        ? "poweredby_dark.png"
        : "poweredby_light.png";

    return Container(
      width: double.maxFinite,
      height: 15,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage(
            "$basePath$logoPath",
            package: 'giphy_get',
          ),
        ),
      ),
    );
  }
}
