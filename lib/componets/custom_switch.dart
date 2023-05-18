import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {

  final Function onChange;
  final bool switchControl;
  final StateSetter setStateT;

  const CustomSwitch({this.onChange, this.setStateT, this.switchControl});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(right: size.width * 0.03),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            height: 29,
            width: 53,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          Transform.scale(
            scale: 1.2,
            child: Switch(
              value: widget.switchControl,
              activeColor: Colors.white,
              activeTrackColor: Colors.grey[200],
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[200],
              activeThumbImage: AssetImage('assets/sun.png'),
              inactiveThumbImage: AssetImage('assets/moon-phase-outline.png'),
              onChanged: (value){
                widget.onChange(value, widget.setStateT);
              },
            ),
          ),
        ],
      )
    );
  }
}