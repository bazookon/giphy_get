import 'package:flutter/widgets.dart';
import 'package:giphy_client/giphy_client.dart';

class TabProvider with ChangeNotifier {
  String apiKey;
  Color tabColor;
  String searchText;
  String rating = GiphyRating.g;
  String lang = GiphyLanguage.english;
  String randomID = "";


  // TabType
  String _tabType;
  String get tabType => _tabType;
  set tabType(String tabType) {
    _tabType = tabType;
    notifyListeners();
  }

  // Constructor
  TabProvider(
      {this.apiKey, this.tabColor, this.searchText, this.rating, this.randomID,this.lang});
  void setTabColor(Color tabColor) {
    tabColor = tabColor;
    notifyListeners();
  }
}
