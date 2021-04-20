import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'stopwatch_screen.dart';
import 'package:in_time/services/dependencies.dart';
import 'worldclock_screen.dart';
import 'alarm_screen.dart';
import 'bedtime_screen.dart';
import 'timer_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> pages = [
    WorldClock(
      key: PageStorageKey('worldclock_screen'),
    ),
    Alarm(
      key: PageStorageKey('alarm_screen'),
    ),
    BedTime(
      key: PageStorageKey('bedtime_screen'),
    ),
    StopWatch(
      key: PageStorageKey('stopwatch_screen'),
      dependencies: Dependencies(),
    ),
    TimerScreen(
      key: PageStorageKey('timer_screen'),
    ),
  ];

  PageStorageBucket bucket = PageStorageBucket();

  CupertinoTabController controller = CupertinoTabController(
    initialIndex: 3,
  );

  String chooseMiddle(int i) {
    if (i == 0) return 'World Clock';
    if (i == 1) return 'Alarm';
    if (i == 2) return 'Bedtime';
    if (i == 3) return 'Stopwatch';
    if (i == 4)
      return 'Timer';
    else
      return 'Error';
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: controller,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.getIconData('ios-globe'),
            ),
            title: Text('World Clock'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.getIconData('ios-alarm'),
            ),
            title: Text('Alarm'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.getIconData('ios-bed'),
            ),
            title: Text('Bedtime'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.getIconData('ios-stopwatch'),
            ),
            title: Text('Stopwatch'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.getIconData('ios-timer'),
            ),
            title: Text('Timer'),
          ),
        ],
      ),
      tabBuilder: (context, i) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(
                  chooseMiddle(i),
                ),
              ),
              child: PageStorage(
                child: pages[i],
                bucket: bucket,
              ),
            );
          },
        );
      },
    );
  }
}
