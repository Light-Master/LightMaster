import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:light_master_app/modules/dashboard/bloc/light_settings_sheet_bloc.dart';

import 'light_settings_sheet.dart';

class LightSettingsSheetNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _lightSettingsBloc = BlocProvider.of<LightSettingsSheetBloc>(context);
    final double buttonWidth = 150;
    final selectedTabStyle =
        TextStyle(color: Colors.black, decoration: TextDecoration.underline);
    final unselectedTabStyle = TextStyle(color: Colors.grey);
    return BlocBuilder<LightSettingsSheetBloc, LightSettingsSheetEvent>(
    builder: (BuildContext context, LightSettingsSheetEvent state){
      return Container(
          height: 35,
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: buttonWidth,
                  child: TextButton(
                      onPressed: () =>
                          _lightSettingsBloc.add(LightSettingsSheetEvent.mono),
                      child: Text("Mono",
                          style: state == LightSettingsSheetEvent.mono
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
                        onPressed: () => _lightSettingsBloc.add(LightSettingsSheetEvent.effect),
                        child: Text("Effects",
                            style: state == LightSettingsSheetEvent.effect
                                ? selectedTabStyle
                                : unselectedTabStyle)))
              ]));
    });
  }
}
