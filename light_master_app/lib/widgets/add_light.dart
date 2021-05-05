import 'package:flutter/material.dart';

class AddLight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
        heightFactor: 0.5,
        child: Container(
            color: Colors.white,
            child: new Center(child: Text("Add Lights here please."))));
  }
}
