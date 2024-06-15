import 'package:drawing_with_undo/models/tools.dart';
import 'package:drawing_with_undo/providers/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gradient_borders/gradient_borders.dart';

class Palette extends StatelessWidget {
  const Palette(BuildContext context, {super.key});

  // TODO(required): Finish the implementation of this method and document it.
  //   This method should return a ListView widget that contains a list of
  //   Clickable elements to use to choose the tool and color to draw with.
  //   Add more colors so that your users can be expressive

  //Builds a pallette and passes a provider down to its internal components
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          const DrawerHeader(
            child: Text('Tools and Colors'),
          ),
          //Row of Tools to be selected, widgets are constructed in separate method
          _buildToolButton(
              name: 'Line',
              icon: Icons.timeline_sharp,
              tool: Tools.line,
              provider: drawingProvider),
          _buildToolButton(
              name: 'Stroke',
              icon: Icons.brush,
              tool: Tools.stroke,
              provider: drawingProvider),
          // Add missing tools here
          _buildToolButton(
              name: "Oval",
              icon: Icons.circle_outlined,
              tool: Tools.oval,
              provider: drawingProvider),
          const Divider(),
          //Row of Colors to be selected, widgets are constructed in separate method
          Row(
            children: [
              _buildColorButton('Red', Colors.red, drawingProvider),
              _buildColorButton('Blue', Colors.blue, drawingProvider),
              _buildColorButton('Green', Colors.green, drawingProvider),
              _buildColorButton('Yellow', Colors.yellow, drawingProvider),
            ],
          ),
          //Row of Tools to be selected, widgets are constructed in separate method
          Row(
            children: [
              _buildColorButton('Orange', Colors.orange, drawingProvider),
              _buildColorButton('Purple', Colors.purple, drawingProvider),
              _buildColorButton('Pink', Colors.pink, drawingProvider),
              _buildColorButton('Black', Colors.black, drawingProvider),
            ],
          ),
        ],
      ),
    );
  }

  // TODO(required): Implement and document this method
  //  This method should return an InkWell widget that, when tapped, sets the
  //  toolSelected property of the provider to the given tool.
  //  If the tool is already selected, it should set the toolSelected property to Tools.none.
  //  If a tool is currently selected, that should be visible and denoted via Semantics
  //  Make sure that you make your tap targets big enough for someone to reliably hit with their finger.

  //Constructs buttons that allow a user to swicth between drawing tools
  Widget _buildToolButton(
      {required String name,
      required IconData icon,
      required Tools tool,
      required DrawingProvider provider}) {
    String label = tool == provider.toolSelected
        ? name
        : '${name} currently selected'; //Label for semantic purposes
    Color bgColor = provider.toolSelected == tool
        ? const Color.fromARGB(255, 0, 0, 0)
        : Color.fromARGB(255, 255, 255,
            255); //Set the bg color for the button based on its selection

    Color txtColor = provider.toolSelected == tool
        ? Color.fromARGB(255, 255, 255, 255)
        : Color.fromARGB(255, 0, 0,
            0); //Set the text color for the button based on its selection

    //Border border = tool == provider.toolSelected ? : Border
    return Semantics(
      label: label,
      child: Container(
        height: 45,
        width: 90,
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(10.0),
        //     border: Border.all(color: Colors.black, width: 3.0)),
        // duration: const Duration(seconds: 1),
        // curve: Curves.easeIn,
        child: Material(
          color: bgColor,
          //borderRadius: BorderRadius.circular(10.0),
          //borderOnForeground: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(color: Colors.black, width: 3.0)),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: txtColor,
                  size: 25.0, // Adjust the icon color on state
                ),
                SizedBox(width: 8),
                Text(
                  name,
                  style: TextStyle(
                      color: txtColor,
                      fontSize: 24.0 // Adjust the text color on state
                      ),
                ),
              ],
            ),
            onTap: () {
              //When clicked, if the button is not already selected, then it will be the new current (otherwise deselects)
              provider.toolSelected =
                  provider.toolSelected != tool ? tool : Tools.none;
            },
          ),
        ),
      ),
    );
  }

  // TODO(required): Implement and document this method
  //  This method should return an InkWell widget that, when tapped, sets the
  //  colorSelected property of the provider to the given color.
  //  If a color is currently selected, that should be visible and denoted via Semantics
  //  Make sure that you make your tap targets big enough for someone to reliably hit with their finger.

  //Provides the user with an array of colors to draw with
  //By default, blue is pre-selected and a color must be selected at all times (not possible w/ current implementation to be null)
  Widget _buildColorButton(String name, Color color, DrawingProvider provider) {
    String label =
        color == provider.colorSelected ? '${name} currently selected' : name;
    var border = color == provider.colorSelected
        ? color ==
                Colors
                    .black //If selected and black (black border won't work), uses a gradient border
            ? GradientBoxBorder(
                gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 0, 38, 188), Colors.red]),
                width: 8,
              )
            : Border.all(
                color: Colors.black,
                width: 5.0) //If color is selected, give it a black border
        : Border.all(
            color: Colors.transparent); //If not selected, transparent border

    return Semantics(
      label:
          '${label}', //Uses custom label with name and selection status for semantics
      child: Container(
        height: 60,
        width: 60,
        margin: EdgeInsets.only(left: 7.5, right: 7.5, top: 15.0),
        decoration:
            BoxDecoration(shape: BoxShape.circle, border: border, color: color),
        child: InkWell(
          onTap: () {
            provider.colorSelected =
                color; //On tap will call on the provider to change the current color
          },
        ),
      ),
    );
  }
}
