import 'package:flutter/material.dart';

class SheetProvider extends ChangeNotifier {
  bool isExpanded = false;
  static const double minExtent = 0.7;
  static const double maxExtent = 0.9;
  double _initialExtent = minExtent;

  double get initialExtent => _initialExtent;
  set initialExtent(double iExtent) {
    this._initialExtent = iExtent;
    notifyListeners();
  }
}
