import 'package:flutter/material.dart';

class ScreenWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Screen Wrap',
      home: _InputChip(),
    );
  }
}

class _InputChip extends StatefulWidget {
  @override
  _InputChipState createState() => new _InputChipState();
}

class _InputChipState extends State<_InputChip> {
  TextEditingController _textEditingController = new TextEditingController();
  List<String> _values = [];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  Widget buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _values.length; i++) {
      InputChip actionChip = InputChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        label: Text(
          _values[i],
          style: TextStyle(
            color: Color.fromRGBO(65,105,225, 0.5),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 10,
        backgroundColor: Color.fromRGBO(204, 229, 255, 0.5),
        pressElevation: 5,
        padding: EdgeInsets.all(13),
        shadowColor: Colors.black26,
        onPressed: () {},
        onDeleted: () {
          _values.removeAt(i);
          setState(() {
            _values = _values;
          });
        },
      );

      chips.add(actionChip);
    }

    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 4.0,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Screen Wrap'),
        ),
        body: Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0,
          children: <Widget>[
            Container(
              child: buildChips(),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 48),
              child: IntrinsicWidth(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                    minLines: 5,
                    maxLines: 5,
                  )),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  _values.add(_textEditingController.text);
                  _textEditingController.clear();

                  setState(() {
                    _values = _values;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      'Add Skill',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
