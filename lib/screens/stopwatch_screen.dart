import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:in_time/components/custom_button.dart';
import 'package:in_time/constants.dart';
import 'package:in_time/services/dependencies.dart';
import 'package:in_time/components/build_stopwatch.dart';
import 'package:in_time/components/lap_list_tile.dart';
import 'settings_screen.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  static final String id = 'stopwatch_screen';

  StopWatch({this.key, this.dependencies});

  final Key key;
  final Dependencies dependencies;

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Stopwatch lapStopwatch = Stopwatch();
  String leftButtonText;
  String rightButtonText;
  Color leftButtonColor;
  Color rightButtonColor;

  Timer timer;

  List<int> values;
  int forcedNumber = 9999;
  int selectedLaps = 9999;
  int lapsCompleted = 0;
  bool isNextStopFake = false;
  bool fakeStop = false;

  updateTime(Timer timer) {
    if (widget.dependencies.stopwatch.isRunning) {
      setState(() {});
    } else {
      timer.cancel();
    }
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (widget.dependencies.stopwatch.isRunning) {
      timer = new Timer.periodic(new Duration(milliseconds: 5), updateTime);
      leftButtonText = 'Lap';
      leftButtonColor = CupertinoColors.darkBackgroundGray;
      rightButtonText = 'Stop';
      rightButtonColor = Color(0xFF351916);
    } else {
      leftButtonText = 'Reset';
      leftButtonColor = CupertinoColors.darkBackgroundGray;
      rightButtonText = 'Start';
      rightButtonColor = Color(0xFF1c381f);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
      timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (context) {
        return CupertinoPageScaffold(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onDoubleTap: () async {
                          values = await Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Settings(),
                            ),
                          );
                          forcedNumber = values[0];
                          selectedLaps = values[1];
                          lapsCompleted = 0;
                          isNextStopFake = false;
                          fakeStop = false;
                        },
                        child: createStopwatch(),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: CustomButton(
                              actionTitle: Text(
                                leftButtonText,
                                style: kButtonTextStyle.copyWith(
                                    color: CupertinoColors.inactiveGray),
                              ),
                              onTapAction: saveOrResetWatch,
                              buttonColor: leftButtonColor,
                              borderColor: CupertinoColors.black,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: CustomButton(
                              actionTitle: Text(
                                rightButtonText,
                                style: kButtonTextStyle.copyWith(
                                    color: rightButtonColor == Color(0xFF351916)
                                        ? CupertinoColors.destructiveRed
                                        : CupertinoColors.activeGreen),
                              ),
                              onTapAction: startOrStopWatch,
                              buttonColor: rightButtonColor,
                              borderColor: CupertinoColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'Lap NO.',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Helvetica Light',
                                        color: Color(0xFF3E3E3E),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'SPLIT',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Helvetica Light',
                                        color: Color(0xFF3E3E3E),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'TOTAL',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Helvetica Light',
                                        color: Color(0xFF3E3E3E),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            height: 1,
                            color: CupertinoColors.darkBackgroundGray,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: widget.dependencies.savedTimeList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              child: createListItemText(
                                  widget.dependencies.savedTimeList.length,
                                  index,
                                  widget.dependencies.savedTimeList
                                      .elementAt(index),
                                  widget.dependencies.totalTimeList
                                      .elementAt(index)),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  startOrStopWatch() {
    if (widget.dependencies.stopwatch.isRunning) {
      if (!isNextStopFake) {
        setState(() {
          leftButtonText = 'Reset';
          leftButtonColor = CupertinoColors.darkBackgroundGray;
          rightButtonText = 'Start';
          rightButtonColor = Color(0xFF1c381f);
          lapStopwatch.stop();
          widget.dependencies.stopwatch.stop();
        });
      } else {
        setState(() {
          leftButtonText = 'Reset';
          leftButtonColor = CupertinoColors.darkBackgroundGray;
          rightButtonText = 'Start';
          rightButtonColor = Color(0xFF1c381f);
          fakeStop = true;
          lapStopwatch.stop();
          widget.dependencies.stopwatch.stop();
        });
      }
    } else {
      leftButtonText = 'Lap';
      leftButtonColor = CupertinoColors.darkBackgroundGray;
      rightButtonText = 'Stop';
      rightButtonColor = Color(0xFF351916);
      lapStopwatch.start();
      widget.dependencies.stopwatch.start();
      timer = new Timer.periodic(new Duration(milliseconds: 5), updateTime);
    }
  }

  saveOrResetWatch() {
    if (widget.dependencies.stopwatch.isRunning) {
      setState(() {
        widget.dependencies.savedTimeList.insert(
            0,
            widget.dependencies.transformMilliSecondsToString(
                lapStopwatch.elapsedMilliseconds));
        widget.dependencies.totalTimeList.insert(
            0,
            widget.dependencies.transformMilliSecondsToString(
                widget.dependencies.stopwatch.elapsedMilliseconds));
        lapStopwatch.reset();
      });
    } else {
      setState(() {
        lapStopwatch.reset();
        widget.dependencies.stopwatch.reset();
        widget.dependencies.clearAndReset();
      });
      if (isNextStopFake) {
        isNextStopFake = false;
      } else if (lapsCompleted < (selectedLaps - 2)) {
        lapsCompleted++;
        fakeStop = false;
        print(lapsCompleted);
      } else if (lapsCompleted == (selectedLaps - 2)) {
        lapsCompleted = 0;
        isNextStopFake = true;
        print(lapsCompleted);
      }
    }
  }

  Widget createListItemText(
      int listSize, int index, String lapTime, String totalTime) {
    index = listSize - index;
    return LapListTile(
      index: index,
      lapTime: lapTime,
      totalTime: totalTime,
    );
  }

  Widget createStopwatch() {
    if (fakeStop) {
      fakeStop = false;
      return BuildStopwatch(
        dependencies: widget.dependencies,
        fakeStop: (!fakeStop),
        forcedNumber: forcedNumber,
      );
    } else {
      return BuildStopwatch(
        dependencies: widget.dependencies,
        fakeStop: fakeStop,
        forcedNumber: forcedNumber,
      );
    }
  }
}
