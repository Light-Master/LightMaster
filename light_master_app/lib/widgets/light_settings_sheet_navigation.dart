import 'package:flutter/material.dart';

import 'light_settings_sheet.dart';

class LightSettingsSheetNavigation extends StatelessWidget {
  final LightSourceMode mode;
  final VoidCallback onMonoButtonPressed;
  final VoidCallback onEffectButtonPressed;

  LightSettingsSheetNavigation(
      this.mode, this.onMonoButtonPressed, this.onEffectButtonPressed);

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 150;
    final selectedTabStyle =
        TextStyle(color: Colors.black, decoration: TextDecoration.underline);
    final unselectedTabStyle = TextStyle(color: Colors.grey);

    return Container(
        height: 35,
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: buttonWidth,
                child: TextButton(
                    onPressed: onMonoButtonPressed,
                    child: Text("Mono",
                        style: mode == LightSourceMode.mono_colour
                            ? selectedTabStyle
                            : unselectedTabStyle)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.grey,
                  )),
              Container(
                  width: buttonWidth,
                  child: TextButton(
                      onPressed: onEffectButtonPressed,
                      child: Text("Effects",
                          style: mode == LightSourceMode.effect_coloring
                              ? selectedTabStyle
                              : unselectedTabStyle)))
            ]));
  }
}
