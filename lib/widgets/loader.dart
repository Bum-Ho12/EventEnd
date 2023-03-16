import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../utilities/personalization.dart';
import '../utilities/rive_nav_bat.dart';

AlertDialog alert = AlertDialog(
  title: const LoaderIcon(),
  content: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Loading...',
        style: headlineTile,
      ),
    ],
  ),
);

class LoaderIcon extends StatefulWidget {
  const LoaderIcon({super.key});

  @override
  State<LoaderIcon> createState() => _LoaderIconState();
}

class _LoaderIconState extends State<LoaderIcon> {
  RiveAsset setting = RiveAsset(
      src: "assets/loader.riv",
      artboard: "New Artboard",
      stateMachineName: "State Machine 1",
      title: 'loader');
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      setting.input!.change(false);
    });
    return SizedBox(
      height: 70,
      width: 100,
      child: RiveAnimation.asset(
        setting.src,
        artboard: setting.artboard,
        onInit: (artBoard) {
          StateMachineController controller = RiveUtils.getRController(artBoard,
              stateMachineName: setting.stateMachineName);
          setting.input = controller.findSMI("status") as SMIBool;
        },
      ),
    );
  }
}
