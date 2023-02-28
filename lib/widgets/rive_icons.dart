import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../utilities/personalization.dart';
import '../utilities/rive_nav_bat.dart';

class PenEdit extends StatefulWidget {
  const PenEdit({super.key});

  @override
  State<PenEdit> createState() => _PenEditState();
}

class _PenEditState extends State<PenEdit> {
  RiveAsset loader = RiveAsset(
      src: 'assets/pen.riv',
      artboard: "PEN",
      stateMachineName: "State Machine 1",
      title: 'Loader');
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 15), () {
      loader.input!.change(false);
    });
    return SizedBox(
      height: 50,
      width: 50,
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

class SettingsIcon extends StatefulWidget {
  const SettingsIcon({super.key});

  @override
  State<SettingsIcon> createState() => _SettingsIconState();
}

class _SettingsIconState extends State<SettingsIcon> {
  RiveAsset setting = RiveAsset(
      src: "assets/icons.riv",
      artboard: "SETTINGS",
      stateMachineName: "SETTINGS_Interactivity",
      title: 'Settings');
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      setting.input!.change(false);
    });
    return SizedBox(
      height: 12,
      width: 12,
      child: RiveAnimation.asset(
        setting.src,
        artboard: setting.artboard,
        onInit: (artBoard) {
          StateMachineController controller = RiveUtils.getRController(artBoard,
              stateMachineName: setting.stateMachineName);
          setting.input = controller.findSMI("active") as SMIBool;
        },
      ),
    );
  }
}

class ClockIcon extends StatefulWidget {
  const ClockIcon({super.key});

  @override
  State<ClockIcon> createState() => _ClockIconState();
}

class _ClockIconState extends State<ClockIcon> {
  RiveAsset timer = RiveAsset(
      src: "assets/icons.riv",
      artboard: "TIMER",
      stateMachineName: "TIMER_Interactivity",
      title: 'Clock');
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      timer.input!.change(false);
    });
    return SizedBox(
      height: 12,
      width: 12,
      child: RiveAnimation.asset(
        timer.src,
        artboard: timer.artboard,
        onInit: (artBoard) {
          StateMachineController controller = RiveUtils.getRController(artBoard,
              stateMachineName: timer.stateMachineName);
          timer.input = controller.findSMI("active") as SMIBool;
        },
      ),
    );
  }
}
