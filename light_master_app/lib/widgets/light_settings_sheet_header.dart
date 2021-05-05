import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  Widget build(BuildContext context) {
    this.lightSourceNameController.text = this.widget.lightSource.name;

    return Container(
        height: 65,
        child: Stack(children: [
          Container(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
                child: Text(editing ? "Save" : "Edit"),
                onPressed: () {
                  setState(() => editing = !editing);
                  if (editing) {
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
                          controller: this.lightSourceNameController,
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
