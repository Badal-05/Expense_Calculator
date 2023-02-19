import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Container(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }
}
