import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AnimatedWidgetBar extends StatelessWidget {
  const AnimatedWidgetBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 6,
      width: isActive ? 20 : 0,
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: navBar,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class RiveAsset {
  late final String artboard, stateMachineName, title, src;
  late SMIBool? input;
  RiveAsset({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomBarNavs = [
  RiveAsset(
      src: "assets/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity",
      title: 'Home'),
  RiveAsset(
      src: "assets/icons.riv",
      artboard: "SEARCH",
      stateMachineName: "SEARCH_Interactivity",
      title: 'Search'),
  RiveAsset(
      src: "assets/icons.riv",
      artboard: "LIKE/STAR",
      stateMachineName: "STAR_Interactivity",
      title: 'Home'),
  RiveAsset(
      src: "assets/icons.riv",
      artboard: "USER",
      stateMachineName: "USER_Interactivity",
      title: 'Profile'),
];
