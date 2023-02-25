// import 'package:eventend/utilities/personalization.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../utilities/personalization.dart';
import '../utilities/rive_nav_bat.dart';

class LoaderForSearch extends StatefulWidget {
  const LoaderForSearch({super.key});

  @override
  State<LoaderForSearch> createState() => _LoaderForSearchState();
}

class _LoaderForSearchState extends State<LoaderForSearch> {
  RiveAsset loader = RiveAsset(
      src: 'assets/viro_splash.riv',
      artboard: "Loading",
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

// class RiveAssetForLoader {
//   late final String artboard, stateMachineName, title, src;
//   late SMIBool? input;
//   RiveAssetForLoader({
//     required this.src,
//     required this.artboard,
//     required this.stateMachineName,
//     required this.title,
//     this.input,
//   });

//   set setInput(SMIBool status) {
//     input = status;
//   }
// }

// List<RiveAsset> riveAssets = [
//   RiveAsset(
//       src: 'assets/ball_loader.riv',
//       artboard: "HOME",
//       stateMachineName: "State Machine 1",
//       title: 'Loader'),
// ];
