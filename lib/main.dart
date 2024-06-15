import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:drawing_with_undo/views/draw_area.dart';
import 'package:drawing_with_undo/views/palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  const drawAreaWidth = 400.0;
  const drawAreaHeight = 400.00;
  runApp(ChangeNotifierProvider(
      create: (context) =>
          DrawingProvider(width: drawAreaWidth, height: drawAreaHeight),
      child: const MainApp(width: drawAreaWidth, height: drawAreaHeight)));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<DrawingProvider>(builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Drawing App'), actions: <Widget>[
            // TODO(required): Add a button to the AppBar that clears the drawing.
            //   It should call a method on this object called _clear. You must make it.
            Semantics(
              label: "Clear",
              child: IconButton(
                  onPressed: () {
                    final provider = Provider.of<DrawingProvider>(context,
                        listen: false); //Non-listening reference
                    provider.clear();
                  },
                  icon: Icon(Icons.clear)),
            ),
            // TODO(required): Add a button to the AppBar that undoes the last action
            //   It should call a method on this object called _undo. You must make it.
            Semantics(
              label: "Undo",
              child: IconButton(
                  onPressed: () {
                    final provider = Provider.of<DrawingProvider>(context,
                        listen: false); //Non-listening reference
                    provider.undo();
                  },
                  icon: Icon(Icons.undo)),
            ),
            // TODO(required): Add a button to the AppBar that redoes the last undone action
            //   It should call a method on this object called _redo. You must make it.
            Semantics(
                label: "Redo",
                child: IconButton(
                    onPressed: () {
                      final provider = Provider.of<DrawingProvider>(context,
                          listen: false); //Non-listening reference
                      provider.redo();
                    },
                    icon: Icon(Icons.redo)))
            // See https://api.flutter.dev/flutter/material/AppBar-class.html
            // TODO(optional): Make the undo and redo buttons be "greyed out" (disabled) when undo/redo isn't possible
          ]),
          drawer: Drawer(
            child: Palette(context),
          ),
          body: Center(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: DrawArea(width: width, height: height),
            ),
          ),
        );
      }),
    );
  }
}
