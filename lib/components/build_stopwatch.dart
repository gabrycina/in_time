import 'package:flutter/cupertino.dart';
import 'package:in_time/constants.dart' show CurrentTime;
import 'package:in_time/services/dependencies.dart';

class BuildStopwatch extends StatefulWidget {
  BuildStopwatch({this.dependencies, this.fakeStop, this.forcedNumber});

  final Dependencies dependencies;
  final bool fakeStop;
  final int forcedNumber;

  BuildStopwatchState createState() => BuildStopwatchState();
}

class BuildStopwatchState extends State<BuildStopwatch> {
  CurrentTime currentTime;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fakeStop) {
      return Center(
        child: Text(
          '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${widget.forcedNumber.toString().padLeft(3, '0')}',
        ),
      );
    } else {
      currentTime = widget.dependencies.transformMilliSecondsToTime(
          widget.dependencies.stopwatch.elapsedMilliseconds);

      return Center(
        child: Text(
          '${currentTime.minutes.toString().padLeft(2, '0')}:${currentTime.seconds.toString().padLeft(2, '0')},${currentTime.milliseconds.toString().padLeft(3, '0')}',
        ),
      );
    }
  }
}
