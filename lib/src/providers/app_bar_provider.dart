import 'package:flutter/widgets.dart';

class AppBarProvider with ChangeNotifier {
  String _queryText = "";
  String get queryText => _queryText;
  set queryText(String queryText) {
    _queryText = queryText;
    notifyListeners();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    print("Dispose AppBarProvider");
  }
}
