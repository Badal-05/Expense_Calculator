import 'package:flutter/material.dart';

class PlusButton extends StatelessWidget {
  final function;
  final bool cond;
  final bool bgcolor;

  const PlusButton(
      {super.key,
      required this.function,
      required this.cond,
      required this.bgcolor});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: function,
      backgroundColor: cond == true ? Colors.indigo : Colors.black,
      child: Icon(
        Icons.add,
        color: cond == true ? Colors.white : Colors.black,
        size: 32,
      ),
    );
  }
}
