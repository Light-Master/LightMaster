import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

typedef void OnSliderValueChanged(double);

class LMSlider extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final Icon sliderIcon;
  final OnSliderValueChanged onSliderValueChanged;

  LMSlider(this.initialValue, this.minValue, this.maxValue, this.sliderIcon,
      this.onSliderValueChanged);

  @override
  State<StatefulWidget> createState() => _LMSliderState();
}

class _LMSliderState extends State<LMSlider> {
  final sliderTrackBar = FlutterSliderTrackBar(
      activeTrackBar: BoxDecoration(
        color: CupertinoColors.activeBlue,
      ),
      inactiveTrackBar:
          BoxDecoration(color: CupertinoColors.lightBackgroundGray));

  bool firstBuild = true;
  double sliderValue;

  @override
  Widget build(BuildContext context) {
    if (firstBuild) {
      sliderValue = (this.widget.maxValue - this.widget.minValue) / 2;
      firstBuild = false;
    }

    return ConstrainedBox(
        constraints: BoxConstraints.tightForFinite(height: 45),
        child: FlutterSlider(
          values: [sliderValue],
          min: this.widget.minValue,
          max: this.widget.maxValue,
          onDragging: (handlerIndex, lowerValue, upperValue) {
            setState(() => sliderValue = lowerValue);
            this.widget.onSliderValueChanged(lowerValue);
          },
          trackBar: sliderTrackBar,
          handler: FlutterSliderHandler(
            child: this.widget.sliderIcon,
          ),
        ));
  }
}
