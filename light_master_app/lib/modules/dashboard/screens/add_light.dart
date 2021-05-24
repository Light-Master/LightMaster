import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';
import 'package:light_master_app/modules/dashboard/bloc/add_light_bloc.dart';

class AddLight extends StatelessWidget {
  ButtonStyle _buttonStyle =
      ButtonStyle(minimumSize: MaterialStateProperty.all(Size.fromHeight(40)));

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
    final _addLightBloc = BlocProvider.of<AddLightBloc>(context);

    return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
        heightFactor: 0.5,
        child: Container(
            color: Colors.white,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoTextField(
                  textAlign: TextAlign.center,
                  placeholder: 'Name',
                ),
                ElevatedButton(
                    style: _buttonStyle,
                    onPressed: (){
                      _addLightBloc.add(AddLightEvent.auto_detect);
                      },
                    child: Text('Auto Detect')),
                ElevatedButton(
                  style: _buttonStyle,
                  onPressed: (){
                    _addLightBloc.add(AddLightEvent.manual_add);
                  },
                  child: Text('Manual Add'),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 0,
                ),
                //Spacer(),
                BlocBuilder<AddLightBloc, Container>(
                  builder: (BuildContext context, Container state){
                    return state;
                  },
                ),
                //Spacer(),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 0,
                ),
                Spacer(),
                ElevatedButton(
                    style: _buttonStyle,
                    onPressed: () => Navigator.pop(context),
                    child: Text('Save'))
              ],
            )));
  }
}
