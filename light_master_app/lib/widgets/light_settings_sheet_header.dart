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
      this.lightSourceNameController.text = lightSource.name;

      Color backgroundColor;
      if (lightSource.light is SolidLight) {
        var solidLight = lightSource.light as SolidLight;
        backgroundColor = solidLight.color;
      } else {
        backgroundColor = Colors.grey[300];
      }

      bool darkColor =
          backgroundColor.red + backgroundColor.blue + backgroundColor.green >=
              370;
      var fontColor = darkColor ? Colors.black : Colors.white;
      TextStyle lightSourceNameStyle = TextStyle(
          fontWeight: FontWeight.bold, fontSize: 25, color: fontColor);
      var lightSourceNameTextFieldStyle =
          TextStyle(fontWeight: FontWeight.bold, fontSize: 25);

      return Container(
          height: 65,
          padding: EdgeInsets.only(bottom: 30),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(35),
                      topRight: const Radius.circular(35))),
              alignment: AlignmentDirectional.centerEnd,
              padding: EdgeInsets.only(right: 15),
              child: TextButton(
                  style: ButtonStyle(),
                  child: Icon(
                      editing
                          ? CupertinoIcons.checkmark_alt
                          : CupertinoIcons.pencil,
                      color: fontColor),
                  onPressed: () {
                    if (editing) {
                      print(
                          "new lightsource name: ${this.lightSourceNameController.text}");
                      lightSource.name = this.lightSourceNameController.text;
                    }
                    setState(() => editing = !editing);
                  }),
            ),
            Container(
                alignment: AlignmentDirectional.center,
                child: Container(
                    width: 150,
                    child: editing
                        ? CupertinoTextField(
                            controller: lightSourceNameController,
                            textAlign: TextAlign.center,
                            placeholder: "Light name",
                            style: lightSourceNameTextFieldStyle)
                        : Text(lightSource.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            style: lightSourceNameStyle)))
          ]));
    });
  }
}
