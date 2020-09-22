import 'package:property_change_notifier/property_change_notifier.dart';

class AppBarProvider with PropertyChangeNotifier<String> {
  String _queryText = "";
  String get queryText => _queryText;
  set queryText(String queryText) {
    _queryText = queryText;
    notifyListeners('query');
  }

  @override
  // ignore: must_call_super
  void dispose() {
    print("Dispose AppBarProvider");
  }
}
