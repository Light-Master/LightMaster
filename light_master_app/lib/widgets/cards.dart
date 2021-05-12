import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';

// callback
typedef void TurnedOnCallback(bool state);

// father
class Cards extends StatefulWidget {
  int idx;
  Color selectedColor;
  bool isTurnedOn;
  Cards(int idx, Color selectedColor, bool isTurnedOn) {
    this.idx = idx;
    this.selectedColor = selectedColor;
    this.isTurnedOn = isTurnedOn;
  }

  @override
  State<StatefulWidget> createState() => _CardsState();
}

// son
class Card extends StatelessWidget {
  TurnedOnCallback setStateColor;
  Card({@required this.setStateColor});

  @override
  Widget build(BuildContext context) {
    double elevation = 12;
    final double childPadding = 45;
    Color cardColor;
    Color shadowColor;

    setStateColor(false);
    return ImageCard(
      elevation: elevation,
      childPadding: childPadding,
      color: cardColor,
      shadowColor: shadowColor,
      image: Image.network(
        'https://miro.medium.com/max/85/1*ilC2Aqp5sZd1wi0CopD1Hw.png',
      ),
    );
  }
}

class _CardsState extends State<Cards> {
  double elevation = 12;
  final double childPadding = 45;
  Color cardColor;
  Color shadowColor;

  void setStateColor() {
    if (widget.isTurnedOn) {
      cardColor = widget.selectedColor;
      shadowColor = widget.selectedColor;
      elevation = 12;
    } else {
      cardColor = Colors.grey;
      shadowColor = Colors.transparent;
      elevation = 0;
    }
    print(
        "changing state color\ncolor=$cardColor\nshadow=$shadowColor\nelevation=$elevation");
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Card(
      setStateColor: (bool state) {
        widget.isTurnedOn = state;
        print("inside son with state $state");
      },
    ));
  }
}
