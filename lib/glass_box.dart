import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

final _borderRadius = BorderRadius.circular(15);

class GlassBox extends StatelessWidget {
  final height;
  final width;
  final child;
  final color;
  final blur;

  const GlassBox({
    this.height,
    this.width,
    required this.child,
    required this.color,
    required this.blur,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            //Blur Part
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blur,
                sigmaY: blur,
              ),
              child: Container(),
            ),

            //Gradient Part
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color.withOpacity(0.5),
                ),
                borderRadius: _borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.4), color.withOpacity(0.3)],
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
