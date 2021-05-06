import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light_master_app/core/models/light.dart';
import 'package:light_master_app/core/models/light_source.dart';

class LightSettingsSheetHeader extends StatefulWidget {
  final LightSource lightSource;

  LightSettingsSheetHeader({Key key, this.lightSource}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LightSettingsSheetHeaderState();
}

class _LightSettingsSheetHeaderState extends State<LightSettingsSheetHeader> {
  bool editing = false;
  final lightSourceNameController = TextEditingController();
  final lightSourceNameStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 25);

  @override
  void dispose() {
    this.lightSourceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.lightSourceNameController.text = this.widget.lightSource.name;

    Color backgroundColor;
    if (this.widget.lightSource.light is SolidLight) {
      var solidLight = this.widget.lightSource.light as SolidLight;
      backgroundColor = solidLight.color;
    } else {
      backgroundColor = Colors.grey[300];
    }

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
                child: Text(editing ? "Save" : "Edit"),
                onPressed: () {
                  setState(() => editing = !editing);
                  if (!editing) {
                    this.setLightSourceName();
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
                          style: this.lightSourceNameStyle))
                  : Text(this.widget.lightSource.name,
                      overflow: TextOverflow.fade,
                      style: this.lightSourceNameStyle))
        ]));
  }

  void setLightSourceName() {
    setState(() =>
        this.widget.lightSource.name = this.lightSourceNameController.text);
  }
}
