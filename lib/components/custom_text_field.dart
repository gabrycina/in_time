import 'package:flutter/cupertino.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.customIcon, this.placeholderText, this.maxLength, this.onChangedFunction, this.controller});

  final IconData customIcon;
  final String placeholderText;
  final int maxLength;
  final Function onChangedFunction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: CupertinoTextField(
        controller: controller,
        prefix: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            customIcon,
          ),
        ),
        style: TextStyle(
          fontSize: 30,
        ),
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        maxLines: 1,
        maxLengthEnforced: true,
        placeholder: placeholderText,
        onChanged: onChangedFunction,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            color: CupertinoColors.inactiveGray,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );
  }
}
