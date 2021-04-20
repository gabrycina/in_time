import 'package:flutter/cupertino.dart';

class TimerScreen extends StatelessWidget {
  static final String id = 'timer_screen';

  TimerScreen({this.key});
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 5'),
    );
  }
}
