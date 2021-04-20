import 'package:flutter/cupertino.dart';

class BedTime extends StatelessWidget {
  static final String id = 'bedtime_screen';

  BedTime({this.key});

  final Key key;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Screen 3'),
    );
  }
}
