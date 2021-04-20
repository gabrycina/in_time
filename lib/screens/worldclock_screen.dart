import 'package:flutter/cupertino.dart';

class WorldClock extends StatelessWidget {
  static final String id = 'worldclock_screen';

  WorldClock({this.key});
  final Key key;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 1'),
    );
  }
}
