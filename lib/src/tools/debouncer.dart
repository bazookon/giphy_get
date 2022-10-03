import 'dart:async';

// https://gist.github.com/venkatd/7125882a8e86d80000ea4c2da2c2a8ad?permalink_comment_id=3934061#gistcomment-3934061
class Debouncer {
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  final Duration delay;
  Timer? _timer;

  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
