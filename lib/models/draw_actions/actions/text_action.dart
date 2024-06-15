import 'package:flutter/material.dart';

import '../draw_actions.dart';

// This is used to represent the user choosing to add text to their drawing.
class TextAction extends DrawAction {
  final String text;
  final Offset position;
  final Color color;
  // TODO(optional): Add support for different fonts, sizes, styles, etc.

  TextAction(this.text, this.position, this.color);
}
