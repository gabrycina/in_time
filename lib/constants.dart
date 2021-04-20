import 'package:flutter/cupertino.dart';

const kNavTitleTextStyle = TextStyle(
color: CupertinoColors.white,
fontSize: 18.5,
fontWeight: FontWeight.bold
);

const kTextStyle = TextStyle(
  color: CupertinoColors.white,
  fontSize: 80,
  fontFamily: 'Helvetica Ultra Light',
);

const kButtonTextStyle = TextStyle(
  fontSize: 18,
  fontFamily: 'Helvetica',
);

const kErrorTextStyle = TextStyle(
    color: CupertinoColors.destructiveRed,
    fontSize: 13,
    fontFamily: 'Helvetica-Light');

class CurrentTime {
  final int milliseconds;
  final int seconds;
  final int minutes;

  CurrentTime({this.milliseconds, this.seconds, this.minutes});
}
