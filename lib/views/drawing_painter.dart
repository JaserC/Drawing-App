import 'dart:ui';

import 'package:drawing_with_undo/models/draw_actions/draw_actions.dart';
import 'package:drawing_with_undo/models/drawing.dart';
import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final Drawing _drawing;
  final DrawingProvider _provider;

  DrawingPainter(DrawingProvider provider)
      : _drawing = provider.drawing,
        _provider = provider;

  // TODO(required): Finish implementing and document this method
  // TODO(optional): Make this painter proportionately scale
  //  how it draws when the size passed is not the same as the Drawing's size

  //Creates a canvas to a specific size, sets it up, and then paints the current state of our app (replays past drawing actions and keeps track of pending ones)
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    canvas.clipRect(rect); // make sure we don't scribble outside the lines.

    final erasePaint = Paint()..blendMode = BlendMode.clear;
    canvas.drawRect(rect, erasePaint);

    //Iterates through past drawing actions and then calls function to put them on screen
    for (final action in _provider.drawing.drawActions) {
      _paintAction(canvas, action, size);
    }

    //Takes the pending action and draws it on the canvas
    if (_provider.pendingAction != NullAction()) {
      _paintAction(canvas, _provider.pendingAction, size);
    }
    // TODO(required): Add a couple lines of code here so that users get to see what they're
    //  drawing live, as they draw it
  }

  // TODO(required): Finish implementing and document this method.
  //   Your implementation should handle all of the subclasses of DrawAction
  //   that are defined in models/draw_actions/actions.
  //   TextAction, however, is optional.
  // TODO(optional): Make this painter proportionately scale
  //  how it draws when the size passed is not the same as the Drawing's size

  //Takes drawing actions and translates them into flutter methods that result in changes to the UI
  void _paintAction(Canvas canvas, DrawAction action, Size size) {
    final Rect rect = Offset.zero & size;
    final erasePaint = Paint()..blendMode = BlendMode.clear;

    //Based on drawing action, call asscoiated process of drawing
    switch (action) {
      case NullAction _: //If null, do nothing
        break;
      case ClearAction _:
        canvas.drawRect(rect,
            erasePaint); //If clear, draw a rectangle of erase paint to "clear" canvas
        break;
      case LineAction
        lineAction: //If line, set paint details and draw a line between 2 given points within the class
        final paint = Paint()
          ..color = lineAction.color
          ..strokeWidth = 2;
        canvas.drawLine(lineAction.point1, lineAction.point2, paint);
        break;
      case OvalAction
        ovalAction: //If oval, set paint details and construct an oval with a rectangle constructor using 2 previously saved points for the corners
        final paint = Paint()
          ..color = ovalAction.color
          ..strokeWidth = 2;
        canvas.drawOval(Rect.fromPoints(ovalAction.p1, ovalAction.p2), paint);
      case StrokeAction
        strokeAction: //If stroke, set paint details and draw line segments between consecutive offsets (points) to simulate continuous brush strokes
        final paint = Paint()
          ..color = strokeAction.color
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5;
        if (strokeAction.points.length >= 2) {
          // Loop through each pair of consecutive points
          for (int i = 0; i < strokeAction.points.length - 1; i++) {
            Offset startPoint = strokeAction.points[i];
            Offset endPoint = strokeAction.points[i + 1];

            // Draw a line between the current point and the next point
            canvas.drawLine(startPoint, endPoint, paint);
          }
        } else {
          canvas.drawPoints(PointMode.points, strokeAction.points,
              paint); //If only 1 point, just put a dot on screen
        }
      default:
        throw UnimplementedError(
            'Action not implemented: $action'); //Default in case of error
    }
  }

  // TODO(required): Add documentation for this method
  // TODO(required): In your own words, in the README, explain what the
  //   covariant keyword means, why this @override is legal, and what the logic
  //   behind this implementation is.
  //   We have not gone over covariants in lecture, so you will need to
  //   look up the covariant keyword in the Dart language documentation.

  //If the drawing needs to be repainted (something has changed, leading to different oldDelegate and new), then it will return true, false otherwise
  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return oldDelegate._drawing != _drawing;
  }
}
