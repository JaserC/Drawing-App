import 'dart:js_interop';

import 'package:drawing_with_undo/models/draw_actions/draw_actions.dart';
import 'package:drawing_with_undo/models/tools.dart';
import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'drawing_painter.dart';

class DrawArea extends StatelessWidget {
  const DrawArea({super.key, required this.width, required this.height});

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) {
        return CustomPaint(
          size: Size(width, height),
          painter: DrawingPainter(drawingProvider),
          child: GestureDetector(
              onPanStart: (details) => _panStart(details, drawingProvider),
              onPanUpdate: (details) => _panUpdate(details, drawingProvider),
              onPanEnd: (details) => _panEnd(details, drawingProvider),
              child: Container(
                  width: width,
                  height: height,
                  color: Colors.transparent,
                  child: unchangingChild)),
        );
      },
    );
  }

  // TODO(required): Finish the implenentation of this method and document it.
  //   Your implementation should explicitly handle *at least* all
  //   of the possible values of the Tool enum. (You can add more tools if you want).

  // When contact is first made with the screen, this function is invoked
  void _panStart(DragStartDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        drawingProvider.pendingAction = NullAction();
        break;
      case Tools
            .line: //If the current tool is a line, create a 0-length segment that starts at the point of origin
        drawingProvider.pendingAction = LineAction(
          details.localPosition,
          details.localPosition,
          drawingProvider.colorSelected,
        );
        break;
      case Tools
            .oval: //If the current tool is an oval, store 2 points, both of which are the point of origin
        drawingProvider.pendingAction = OvalAction(details.localPosition,
            details.localPosition, drawingProvider.colorSelected);
        break;
      case Tools
            .stroke: //If the current tool is a stroke, add the point of origin to the points list
        List<Offset> newPoints = [details.localPosition];
        drawingProvider.pendingAction =
            StrokeAction(newPoints, drawingProvider.colorSelected);
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  // TODO(required): Finish the implenentation of this method and document it.
  //   Your implementation should explicitly handle *at least* all
  //   of the possible values of the Tool enum. (You can add more tools if you want).

  // When still in contact with the screen and moving around, this function is invoked
  void _panUpdate(DragUpdateDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;

    switch (currentTool) {
      case Tools.none:
        break;
      case Tools
            .line: //If the current tool is a line, update the second point of the line to reflect the point of origin to current finger point
        final pendingAction = drawingProvider.pendingAction as LineAction;
        drawingProvider.pendingAction = LineAction(
          pendingAction.point1,
          details.localPosition,
          pendingAction.color,
        );
        break;
      case Tools
            .oval: //If the current tool is an oval, update the second point to figure out the oval corners as they change
        final pendingAction = drawingProvider.pendingAction as OvalAction;
        drawingProvider.pendingAction = OvalAction(
          //Because the rect was instantiated as a single point, topLeft, bottomRight, all fields are the same
          pendingAction.p1, details.localPosition,
          pendingAction.color,
        );
      case Tools
            .stroke: //If the current tool is a stroke, keep adding points to the points list
        final newPendingAction = drawingProvider.pendingAction as StrokeAction;
        newPendingAction.points.add(details.localPosition);
        drawingProvider.pendingAction = newPendingAction;
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }

  // TODO(required): Implement and document this method

  //When finger is lifted off, this function is invoked
  //Should add the action to the _pastactions list at the end across the board
  //Should set pending action to NullAction() across the board
  void _panEnd(DragEndDetails details, DrawingProvider drawingProvider) {
    final currentTool = drawingProvider.toolSelected;
    switch (currentTool) {
      case Tools.none:
        break;
      case Tools.line:
        final endAction = drawingProvider.pendingAction as LineAction;
        drawingProvider.add(
            LineAction(endAction.point1, endAction.point2, endAction.color));
        drawingProvider.pendingAction = NullAction();
        break;
      case Tools.oval:
        final endAction = drawingProvider.pendingAction as OvalAction;
        drawingProvider.add(endAction);
        drawingProvider.pendingAction = NullAction();
      case Tools.stroke:
        final endAction = drawingProvider.pendingAction as StrokeAction;
        drawingProvider.add(endAction);
        drawingProvider.pendingAction = NullAction();
      default:
        throw UnimplementedError('Tool not implemented: $currentTool');
    }
  }
}
