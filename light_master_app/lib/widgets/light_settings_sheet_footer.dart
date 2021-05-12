import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class LightSettingsSheetFooter extends StatefulWidget {
  final VoidCallback cancelCallback;

  LightSettingsSheetFooter(this.cancelCallback);

  @override
  _LightSettingsSheetFooterState createState() =>
      _LightSettingsSheetFooterState();
}

class _LightSettingsSheetFooterState extends State<LightSettingsSheetFooter> {
  double _brightnessValue = 100;
  double _speedValue = 100;
  double _intensityValue = 100;

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 150;

    final sliderTrackBar = FlutterSliderTrackBar(
        activeTrackBar: BoxDecoration(
          color: CupertinoColors.activeBlue,
        ),
        inactiveTrackBar:
            BoxDecoration(color: CupertinoColors.lightBackgroundGray));

    return Column(children: [
      // FlutterSlider(
      //   values: [_speedValue],
      //   max: 255,
      //   min: 0,
      //   onDragging: (handlerIndex, lowerValue, upperValue) =>
      //       setState(() => _speedValue = lowerValue),
      //   trackBar: sliderTrackBar,
      //   handler: FlutterSliderHandler(
      //     child: Icon(
      //       CupertinoIcons.speedometer,
      //       color: CupertinoColors.darkBackgroundGray,
      //       size: 24,
      //     ),
      //   ),
      // ),
      // FlutterSlider(
      //   values: [_intensityValue],
      //   max: 255,
      //   min: 0,
      //   onDragging: (handlerIndex, lowerValue, upperValue) =>
      //       setState(() => _intensityValue = lowerValue),
      //   trackBar: sliderTrackBar,
      //   handler: FlutterSliderHandler(
      //     child: Icon(
      //       CupertinoIcons.flame,
      //       color: CupertinoColors.darkBackgroundGray,
      //       size: 24,
      //     ),
      //   ),
      // ),
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
                  this.widget.cancelCallback();
                })),
        Container(
            padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
            width: buttonWidth,
            child: TextButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Color.fromARGB(255, 116, 128, 255))))
      ])
    ]);
  }
}
