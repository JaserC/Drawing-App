import 'package:flutter/material.dart';

import '../models/draw_actions/draw_actions.dart';
import '../models/drawing.dart';
import '../models/tools.dart';

class DrawingProvider extends ChangeNotifier {
  Drawing?
      _drawing; // used to create a cached drawing via replay of past actions
  DrawAction _pendingAction = NullAction();
  Tools _toolSelected = Tools.none;
  Color _colorSelected = Colors.blue;

  final List<DrawAction> _pastActions;
  final List<DrawAction> _futureActions;

  final double width;
  final double height;

  DrawingProvider({required this.width, required this.height})
      : _pastActions = [],
        _futureActions = [];

  Drawing get drawing {
    if (_drawing == null) {
      _createCachedDrawing();
    }
    return _drawing!;
  }

  // TODO(required): This method will set the action so we know what component (line, oval, stroke, etc.) to draw and what information that component needs
  set pendingAction(DrawAction action) {
    _pendingAction = action;
    _invalidateAndNotify();
  }

  DrawAction get pendingAction => _pendingAction;

  // TODO(required): Will set the tool we want to use to actually draw the component
  set toolSelected(Tools aTool) {
    _toolSelected = aTool;
    _invalidateAndNotify();
  }

  Tools get toolSelected => _toolSelected;

  // TODO(required): This will specify a color to draw in when a user selects one from a color palette
  set colorSelected(Color color) {
    _colorSelected = color;
    _invalidateAndNotify();
  }

  Color get colorSelected => _colorSelected;

  // TODO(required): Implement and document this method.
  //   Your implementation should make _drawing be a
  //   new Drawing using either all the pastActions or the pastActions
  //   since the last ClearAction.
  _createCachedDrawing() {
    //lastIndexOf(ClearAction())
    //If one exists, redraw from that index forward
    //If one does not exist, then start from beginning of past actions
    int found = _pastActions.lastIndexOf(ClearAction());
    int startIndex = found == -1 ? 0 : found + 1;

    //If the last element is a clear, just refer to an empty last, same thing
    List<DrawAction> actionsPastClear = startIndex < _pastActions.length
        ? _pastActions.sublist(startIndex)
        : [];

    _drawing = Drawing(actionsPastClear, width: width, height: height);
  }

  // TODO(required): This will nullify the drawing, forcing a refetch which will show an updated drawing object
  // This method is crucial after a mutation call (like undo, redo, etc.) show that the canvas reflects changes immediately
  _invalidateAndNotify() {
    _drawing = null;
    notifyListeners();
  }

  // TODO(required): This will add an action to the history of events and clear the redo stack (divergent branches)
  add(DrawAction action) {
    _pastActions.add(action);
    _futureActions.clear();
    _invalidateAndNotify();
  }

  // TODO(required): Implement and document this method
  //   your implementation must be able to undo a clear by
  //   restoring the drawing to how it looked prior to being cleared
  // Moves an action from the current history to the redo stack so that the user can replay that action in the future
  undo() {
    if (_pastActions.isNotEmpty) {
      DrawAction action = _pastActions.removeLast();
      _futureActions.add(action);
      _invalidateAndNotify();
    }
  }

  // TODO(required): Takes an action from the redo list and adds it back onto the current history to be drawn
  redo() {
    if (_futureActions.isNotEmpty) {
      DrawAction action = _futureActions.removeLast();
      _pastActions.add(action);
      _invalidateAndNotify();
    }
  }

  // TODO(required); Implement this and document it
  //   Your implementation must be undo()able
  // Adds a clear action as a sort of demarcator between states of the drawing
  // Adding it as an object rather than mutating our data structures lets us work around it while maintaining our data (valuable information)
  clear() {
    add(ClearAction());
    _invalidateAndNotify();
  }
}
