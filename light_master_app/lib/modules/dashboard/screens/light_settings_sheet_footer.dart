import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightSettingsSheetFooter extends StatelessWidget {
  final VoidCallback cancelCallback;

  LightSettingsSheetFooter(this.cancelCallback);

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 150;
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
            child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 7.5),
                width: buttonWidth,
                child: TextButton(
                    child: Text("Cancel"),
                    style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.grey[300]),
                    onPressed: () {
                      Navigator.pop(context);
                      this.cancelCallback();
                    }))),
        Expanded(
            child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 7.5, right: 15),
                width: buttonWidth,
                child: TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Color.fromARGB(255, 116, 128, 255)))))
      ])
    ]);
  }
}
