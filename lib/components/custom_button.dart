import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.actionTitle, this.onTapAction, this.buttonColor, this.borderColor});

  final Text actionTitle;
  final Function onTapAction;
  final Color buttonColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapAction,
      child: Container(
        height: 200,
        width: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Container(
              child: Center(
                child: actionTitle,
              ),
              height: 95,
              width: 95,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(100.0),
                border: Border.all(width: 2.0, color: borderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
