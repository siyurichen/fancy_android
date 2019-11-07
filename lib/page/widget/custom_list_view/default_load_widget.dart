import 'package:flutter/material.dart';

class DefaultLoadWidget extends StatefulWidget {
  @override
  _DefaultLoadWidgetState createState() => new _DefaultLoadWidgetState();
}

class _DefaultLoadWidgetState extends State<DefaultLoadWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
