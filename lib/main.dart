import 'package:flutter/cupertino.dart';
import 'screens/home_screen.dart';
import 'screens/worldclock_screen.dart';
import 'screens/alarm_screen.dart';
import 'screens/bedtime_screen.dart';
import 'screens/stopwatch_screen.dart';
import 'screens/timer_screen.dart';
import 'constants.dart';

void main() => runApp(InTimeApp());

class InTimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CupertinoColors.activeOrange,
        barBackgroundColor: CupertinoColors.darkBackgroundGray,
        scaffoldBackgroundColor: CupertinoColors.black,
        textTheme: CupertinoTextThemeData(
          textStyle: kTextStyle,
          navTitleTextStyle: kNavTitleTextStyle,
        ),
      ),

      home: HomeScreen(),
      routes: {
        HomeScreen.id : (context) => HomeScreen(),
        WorldClock.id : (context) => WorldClock(),
        Alarm.id : (context) => Alarm(),
        BedTime.id : (context) => BedTime(),
        StopWatch.id : (context) => StopWatch(),
        TimerScreen.id : (context) => TimerScreen(),
      },
    );
  }
}

