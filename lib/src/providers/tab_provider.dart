import 'package:flutter/widgets.dart';
import 'package:giphy_get/src/client/models/languages.dart';
import 'package:giphy_get/src/client/models/rating.dart';

class TabProvider with ChangeNotifier {
  String apiKey;
  Color? tabColor;
  String? searchText;
  String rating = GiphyRating.g;
  String lang = GiphyLanguage.english;
  String randomID = "";

  // TabType
  String? _tabType;
  String get tabType => _tabType ?? '';
  set tabType(String tabType) {
    _tabType = tabType;
    notifyListeners();
  }

  // Constructor
  TabProvider(
      {required this.apiKey,
      this.tabColor,
      this.searchText,
      required this.rating,
      required this.randomID,
      required this.lang});
  void setTabColor(Color tabColor) {
    tabColor = tabColor;
    notifyListeners();
  }
}
