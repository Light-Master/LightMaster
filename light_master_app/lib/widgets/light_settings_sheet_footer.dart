import 'package:flutter/material.dart';

class LightSettingsSheetFooter extends StatelessWidget {
  final VoidCallback saveCallback;

  LightSettingsSheetFooter(this.saveCallback);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
              onPressed: () {
                this.saveCallback();
                Navigator.pop(context);
              },
              child: Text("Save")),
        ]));
  }
}
