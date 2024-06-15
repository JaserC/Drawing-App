// TODO(required): Define a class, OvalAction, that extends DrawAction.
//   You can use LineAction as a template... this one will be very similar.
import 'package:flutter/material.dart';

import '../draw_actions.dart';

// Used to represent a line segment drawn by the user
class OvalAction extends DrawAction {
  Offset p1;
  Offset p2;
  final Color color;

  // TODO(optional): Add support for different thicknesses

  OvalAction(this.p1, this.p2, this.color);
}
