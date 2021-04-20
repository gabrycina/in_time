import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:in_time/components/custom_text_field.dart';
import 'package:in_time/constants.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<int> values = [0, 0];
  Text lapsHint = Text('');
  Text forcedNumberHint = Text('');

  TextEditingController forcedNumberField = TextEditingController();
  TextEditingController lapsField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(
            controller: forcedNumberField,
            maxLength: 3,
            placeholderText: 'Forced Number',
            customIcon: Ionicons.getIconData('ios-calculator'),
            onChangedFunction: (value) {
              setState(() {
                values[0] = int.parse(value);
              });
            },
          ),
          CustomTextField(
            controller: lapsField,
            maxLength: 2,
            placeholderText: 'Number of Laps',
            customIcon: Ionicons.getIconData('ios-stopwatch'),
            onChangedFunction: (value) {
              setState(() {
                values[1] = int.parse(value);
              });
            },
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: CupertinoButton(
                color: CupertinoColors.activeGreen,
                child: Text(
                  'SAVE AND EXIT',
                  style: TextStyle(
                      color: CupertinoColors.white,
                      fontFamily: 'Helvetica',
                      fontSize: 15),
                ),
                onPressed: () {
                  if (forcedNumberField.text.contains(RegExp("[0-9]{3}")) &&
                      lapsField.text.contains(RegExp("[0-9]{1,2}"))) {
                    Navigator.pop(context, values);
                  } else if (!forcedNumberField.text
                      .contains(RegExp("[0-9]{3}"))) {
                    setState(() {
                      forcedNumberHint = Text(
                          'The forced number must be 3 numbers long',
                          style: kErrorTextStyle);
                    });
                  } else {
                    forcedNumberHint = Text('');
                  }
                  if (!lapsField.text.contains(RegExp("[0-9]{1,2}"))) {
                    setState(() {
                      lapsHint = Text(
                        'The laps number must be between 1 and 2 numbers long',
                        style: kErrorTextStyle,
                      );
                    });
                  } else {
                    lapsHint = Text('');
                  }
                  FocusScope.of(context).unfocus();
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[lapsHint, forcedNumberHint],
            ),
          )
        ],
      ),
    );
  }
}
