 import 'package:flutter/material.dart';

Widget animated({
    required Animation<double> fade,
    required Animation<Offset> slide,
    required Widget child,
  }) =>
      FadeTransition(
        opacity: fade,
        child: SlideTransition(position: slide, child: child),
      );
