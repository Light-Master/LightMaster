import 'package:flutter/material.dart';

class AutoDetectLightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Auto detect!');
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Auto Detect'),
        ),
      ),
    );
  }
}
class ManualAddLightButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Manual Add!');
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.lightGreen[500],
        ),
        child: Center(
          child: Text('Manual Add'),
        ),
      ),
    );
  }
}

class AddLight2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        alignment: Alignment.bottomCenter,
        widthFactor: 1,
        heightFactor: 0.5,
        child: Container(
            color: Colors.white,
            child: Column(
                children: [AutoDetectLightButton(), ManualAddLightButton()])));
  }
}

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
  int _counter = 0;
  ButtonStyle _buttonStyle = ButtonStyle(
                                minimumSize: MaterialStateProperty.all(Size.fromHeight(1))
                              );

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework
      // that something has changed in this State, which
      // causes it to rerun the build method below so that
      // the display can reflect the updated values. If you
      // change _counter without calling setState(), then
      // the build method won't be called again, and so
      // nothing would appear to happen.
      _counter++;
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
        child:Container(
            color: Colors.white,
            width: double.infinity,
            child:Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: _buttonStyle,
                  onPressed: _increment,
                  child: Text('Auto Detect')
                ),
                ElevatedButton(
                  style: _buttonStyle,
                  onPressed: _increment,
                  child: Text('Manual Add'),
                ),
                Text('Count: $_counter'),
      ],
    )));
  }
}
