// import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../utilities/personalization.dart';
import '../utilities/rive_nav_bat.dart';

class WorldLoader extends StatefulWidget {
  const WorldLoader({super.key});

  @override
  State<WorldLoader> createState() => _WorldLoaderState();
}

class _WorldLoaderState extends State<WorldLoader> {
  RiveAsset loader = RiveAsset(
      src: 'assets/viro_splash.riv',
      artboard: "Loading Final",
      stateMachineName: "State Machine 1",
      title: 'Loader');
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 15), () {
      loader.input!.change(false);
    });
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      child: RiveAnimation.asset(
        loader.src,
        artboard: loader.artboard,
        onInit: (artBoard) {
          StateMachineController controller = RiveUtils.getRController(artBoard,
              stateMachineName: loader.stateMachineName);
          loader.input = controller.findSMI("active") as SMIBool;
        },
      ),
    );
  }
}
