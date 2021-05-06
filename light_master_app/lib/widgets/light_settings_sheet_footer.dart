import 'package:flutter/material.dart';

class LightSettingsSheetFooter extends StatelessWidget {
  final VoidCallback saveCallback;

  LightSettingsSheetFooter(this.saveCallback);

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 150;

    return Container(
        padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
              width: buttonWidth,
              child: TextButton(
                  child: Text("Cancel"),
                  style: TextButton.styleFrom(
                      primary: Colors.black, backgroundColor: Colors.grey[300]),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          Container(
              width: buttonWidth,
              child: TextButton(
                  child: Text("Save"),
                  onPressed: () {
                    this.saveCallback();
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromARGB(255, 116, 128, 255))))
        ]));
  }
}
