import 'package:flutter/material.dart';

class BottomTextWidget extends StatelessWidget {
  final Function onTap;
  final String sent;
  final String click;

  const BottomTextWidget({Key key, this.onTap, this.sent, this.click,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return      GestureDetector(
      onTap: onTap,
      child: RichText(text: TextSpan(children:
      [
        TextSpan(text: sent, style: TextStyle(color: Colors.black)),
        TextSpan(text: " $click", style: TextStyle(color: Colors.yellowAccent)),

      ])),
    );
  }
}
