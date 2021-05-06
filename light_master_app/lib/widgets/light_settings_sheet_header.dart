import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';
import 'package:provider/provider.dart';

class LightSettingsSheetHeader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LightSettingsSheetHeaderState();
}

class _LightSettingsSheetHeaderState extends State<LightSettingsSheetHeader> {
  bool editing = false;
  final lightSourceNameController = TextEditingController();

  @override
  void dispose() {
    this.lightSourceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LightSource>(builder: (context, lightSource, child) {
      print("building header with name ${lightSource.name}");

      this.lightSourceNameController.text = lightSource.name;

      Color backgroundColor;
      if (lightSource.light is SolidLight) {
        var solidLight = lightSource.light as SolidLight;
        backgroundColor = solidLight.color;
      } else {
        backgroundColor = Colors.grey[300];
      }

      // based on colorpicker logic
      Color fontColor =
          backgroundColor.red + backgroundColor.blue + backgroundColor.green >=
                  370
              ? Colors.black
              : Colors.white;
      TextStyle lightSourceNameStyle = TextStyle(
          fontWeight: FontWeight.bold, fontSize: 25, color: fontColor);

      return Container(
          height: 65,
          padding: EdgeInsets.only(bottom: 5),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(35),
                      topRight: const Radius.circular(35))),
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                  child: Text(editing ? "Save" : "Edit",
                      style: TextStyle(color: fontColor)),
                  onPressed: () {
                    setState(() => editing = !editing);
                    if (!editing) {
                      lightSource.name = this.lightSourceNameController.text;
                    }
                  }),
            ),
            Container(
                alignment: AlignmentDirectional.center,
                child: editing
                    ? Container(
                        width: 250,
                        child: CupertinoTextField(
                            controller: lightSourceNameController,
                            textAlign: TextAlign.center,
                            style: lightSourceNameStyle))
                    : Text(lightSource.name,
                        overflow: TextOverflow.fade,
                        style: lightSourceNameStyle))
          ]));
    });
  }
}
