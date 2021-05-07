import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class LightSettingsSheetFooter extends StatefulWidget {
  final VoidCallback saveCallback;

  LightSettingsSheetFooter(this.saveCallback);

  @override
  _LightSettingsSheetFooterState createState() =>
      _LightSettingsSheetFooterState();
}

class _LightSettingsSheetFooterState extends State<LightSettingsSheetFooter> {
  double _brightnessValue = 100;
  double _speedValue = 100;
  double _intensityValue = 100;
  bool _hidden = true;
  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 150;

    return Column(children: [
      Material(
          child: IconButton(
        iconSize: 50,
        icon: Icon(
          _hidden ? Icons.expand_less : Icons.expand_more,
        ),
        onPressed: () => setState(() => _hidden = !_hidden),
      )),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
            padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
            width: buttonWidth,
            child: TextButton(
                child: Text("Cancel"),
                style: TextButton.styleFrom(
                    primary: Colors.black, backgroundColor: Colors.grey[300]),
                onPressed: () {
                  Navigator.pop(context);
                })),
        Container(
            padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
            width: buttonWidth,
            child: TextButton(
                child: Text("Save"),
                onPressed: () {
                  this.widget.saveCallback();
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color.fromARGB(255, 116, 128, 255))))
      ]),
      FlutterSlider(
        values: [_brightnessValue],
        max: 255,
        min: 0,
        onDragging: (handlerIndex, lowerValue, upperValue) {
          _brightnessValue = lowerValue;
          setState(() {});
        },
        trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(
              color: CupertinoColors.activeBlue,
            ),
            inactiveTrackBar:
                BoxDecoration(color: CupertinoColors.lightBackgroundGray)),
        handler: FlutterSliderHandler(
          child: Icon(
            CupertinoIcons.brightness,
            color: CupertinoColors.darkBackgroundGray,
            size: 24,
          ),
        ),
      ),
      Container(
          child: (_hidden)
              ? null
              : Column(children: [
                  FlutterSlider(
                    values: [_speedValue],
                    max: 255,
                    min: 0,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      _speedValue = lowerValue;
                      setState(() {});
                    },
                    trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(
                          color: CupertinoColors.activeBlue,
                        ),
                        inactiveTrackBar: BoxDecoration(
                            color: CupertinoColors.lightBackgroundGray)),
                    handler: FlutterSliderHandler(
                      child: Icon(
                        CupertinoIcons.speedometer,
                        color: CupertinoColors.darkBackgroundGray,
                        size: 24,
                      ),
                    ),
                  ),
                  FlutterSlider(
                    values: [_intensityValue],
                    max: 255,
                    min: 0,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      _intensityValue = lowerValue;
                      setState(() {});
                    },
                    trackBar: FlutterSliderTrackBar(
                        activeTrackBar: BoxDecoration(
                          color: CupertinoColors.activeBlue,
                        ),
                        inactiveTrackBar: BoxDecoration(
                            color: CupertinoColors.lightBackgroundGray)),
                    handler: FlutterSliderHandler(
                      child: Icon(
                        CupertinoIcons.flame,
                        color: CupertinoColors.darkBackgroundGray,
                        size: 24,
                      ),
                    ),
                  ),
                ])),
    ]);
  }
}
