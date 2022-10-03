import 'package:flutter/widgets.dart';

class AppBarProvider with ChangeNotifier {
  String _queryText = "";
  String get queryText => _queryText;

  int _debounceTimeInMilliseconds = 0;
  int get debounceTimeInMilliseconds => _debounceTimeInMilliseconds;

  set queryText(String queryText) {
    _queryText = queryText;
    notifyListeners();
  }

  AppBarProvider(String queryText, int debounceTimeInMilliseconds) {
    this._queryText = queryText;
    this._debounceTimeInMilliseconds = debounceTimeInMilliseconds;
  }

  @override
  // ignore: must_call_super
  void dispose() {
    print("Dispose AppBarProvider");
  }
}
