library giphy_get;

// Imports
import 'package:flutter/material.dart';
import 'package:giphy_get/src/client/models/gif.dart';
import 'package:giphy_get/src/client/models/languages.dart';
import 'package:giphy_get/src/client/models/rating.dart';
import 'package:giphy_get/src/providers/app_bar_provider.dart';
import 'package:giphy_get/src/providers/sheet_provider.dart';
import 'package:giphy_get/src/views/main_view.dart';
import 'package:giphy_get/src/providers/tab_provider.dart';
import 'package:provider/provider.dart';

// Giphy Client Export
export 'package:giphy_get/src/client/client.dart';
export 'package:giphy_get/src/client/models/collection.dart';
export 'package:giphy_get/src/client/models/gif.dart';
export 'package:giphy_get/src/client/models/image.dart';
export 'package:giphy_get/src/client/models/images.dart';
export 'package:giphy_get/src/client/models/languages.dart';
export 'package:giphy_get/src/client/models/rating.dart';
export 'package:giphy_get/src/client/models/user.dart';
export 'package:giphy_get/src/client/models/type.dart';

class GiphyGet {
  // Show Bottom Sheet
  static Future<GiphyGif?> getGif({
    required BuildContext context,
    required String apiKey,
    String rating = GiphyRating.g,
    String lang = GiphyLanguage.english,
    String randomID = "",
    String searchText = "Search GIPHY",
    bool modal = true,
    Color? tabColor,
  }) =>
      showModalBottomSheet<GiphyGif>(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
          isScrollControlled: true,
          context: context,
          builder: (ctx) => MultiProvider(providers: [
                ChangeNotifierProvider(
                  create: (ctx) => AppBarProvider(),
                ),
                ChangeNotifierProvider(
                  create: (ctx) => SheetProvider(),
                ),
                ChangeNotifierProvider(
                    create: (ctx) => TabProvider(
                        apiKey: apiKey,
                        randomID: randomID,
                        tabColor: tabColor ?? Theme.of(context).accentColor,
                        searchText: searchText,
                        rating: rating,
                        lang: lang))
              ], child: MainView()));
}
