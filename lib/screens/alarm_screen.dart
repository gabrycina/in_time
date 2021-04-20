import 'package:flutter/cupertino.dart';

class Alarm extends StatelessWidget {
  static final String id = 'alarm_screen';

  Alarm({this.key});

  final Key key;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 2'),
    );
  }
}
