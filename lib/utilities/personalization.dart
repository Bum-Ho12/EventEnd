import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Color backgroundColor = Colors.white;
Color backgroundColor2 = const Color.fromARGB(255, 17, 58, 78);
Color navBar = const Color(0xFF81B4FF);
Color primaryShadow = const Color.fromARGB(255, 83, 98, 105);

TextStyle headline1 = TextStyle(
  color: backgroundColor2,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
TextStyle headlineForTile = TextStyle(
  color: backgroundColor2,
  fontSize: 15,
  fontWeight: FontWeight.w400,
);
TextStyle headlineTile = TextStyle(
  color: backgroundColor2,
  fontSize: 16,
  fontWeight: FontWeight.w200,
);
TextStyle commonText = const TextStyle(
  color: Colors.black54,
  fontSize: 12,
);

class RiveUtils {
  static StateMachineController getRController(Artboard artboard,
      {stateMachineName = 'Sate Machine 1'}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}
