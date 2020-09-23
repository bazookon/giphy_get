import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:giphy_get/giphy_get.dart';

void main() {
  const MethodChannel channel = MethodChannel('giphy_get');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
