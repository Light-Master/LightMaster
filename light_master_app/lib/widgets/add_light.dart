import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_radio_button_group/flutter_radio_button_group.dart';

class AddLight extends StatefulWidget {
  // This class is the configuration for the state.
  // It holds the values (in this case nothing) provided
  // by the parent and used by the build  method of the
  // State. Fields in a Widget subclass are always marked
  // "final".

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<AddLight> {
  ButtonStyle _buttonStyle =
      ButtonStyle(minimumSize: MaterialStateProperty.all(Size.fromHeight(40)));
  Container _container = Container();
  bool first = true;

  void _manualAdd() {
    setState(() {
      _container = Container(
          child: CupertinoTextField(
        textAlign: TextAlign.center,
        placeholder: 'IP',
      ));
    });
  }

  void _autoDetect() {
    setState(() {
      if (first == true) {
        _container = Container(child: CircularProgressIndicator());
        first = false;
      } else {
        _container = Container(
            child: Expanded(
                flex: 20,
                child: SingleChildScrollView(
                    child: FlutterRadioButtonGroup(
                  items: [
                    /*put your items here*/
                    "192.168.1.10",
                    "192.168.1.11",
                    "192.168.1.12",
                    "192.168.1.13",
                    "192.168.1.14",
                    "192.168.1.15",
                    "192.168.1.16",
                    "192.168.1.17",
                    "192.168.1.18",
                    "192.168.1.19",
                    "192.168.1.20",
                    "192.168.1.21",
                    "192.168.1.22",
                    "192.168.1.23",
                    "192.168.1.24",
                    "192.168.1.25",
                    "192.168.1.26",
                    "192.168.1.27",
                    "192.168.1.28",
                    "192.168.1.29",
                    "192.168.1.30",
                  ],
                ))));
        first = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called,
    // for instance, as done by the _increment method above.
    // The Flutter framework has been optimized to make
    // rerunning build methods fast, so that you can just
    // rebuild anything that needs updating rather than
    // having to individually changes instances of widgets.
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
                    onPressed: _autoDetect,
                    child: Text('Auto Detect')),
                ElevatedButton(
                  style: _buttonStyle,
                  onPressed: _manualAdd,
                  child: Text('Manual Add'),
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 0,
                ),
                //Spacer(),
                _container,
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
