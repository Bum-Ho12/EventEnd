import 'package:eventend/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class ThemeApplication {
  bool? changeTheme;

  getTheme(BuildContext context) {
    changeTheme = context.watch<AppTheme>().setTheme as bool;
  }

  static ThemeApplier lightTheme = ThemeApplier(
    backgroundColor: Colors.white,
    backgroundColor2: const Color.fromARGB(255, 17, 58, 78),
    navBar: const Color(0xFF81B4FF),
    warningColor: Colors.redAccent,
    primaryShadow: const Color.fromARGB(255, 83, 98, 105),
    shimmerColor: const Color.fromARGB(255, 203, 209, 212),
  );

  static ThemeApplier darkTheme = ThemeApplier(
    backgroundColor: const Color.fromARGB(255, 17, 58, 78),
    backgroundColor2: const Color.fromARGB(255, 180, 199, 209),
    navBar: const Color(0xFF81B4FF),
    primaryShadow: const Color.fromARGB(255, 224, 226, 228),
    shimmerColor: const Color.fromARGB(255, 203, 209, 212),
    warningColor: Colors.redAccent,
  );
}

TextStyle pageTitle = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor2,
  fontSize: 24,
  fontWeight: FontWeight.w800,
);
TextStyle headline1Profile = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor,
  fontSize: 22,
  fontWeight: FontWeight.w600,
);
TextStyle headline2Profile = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
TextStyle headline1detail = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor2,
  fontSize: 18,
  fontWeight: FontWeight.w600,
);
TextStyle headline2Detail = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor2,
  fontSize: 16,
  fontWeight: FontWeight.w200,
  overflow: TextOverflow.fade,
);
TextStyle headline2detail = TextStyle(
  color: ThemeApplication.lightTheme.navBar,
  fontSize: 16,
  fontWeight: FontWeight.w200,
);
TextStyle headline1 = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor2,
  fontSize: 22,
  fontWeight: FontWeight.w600,
);
TextStyle headlineForTile = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor2,
  fontSize: 15,
  fontWeight: FontWeight.w400,
);
TextStyle headlineTile = TextStyle(
  color: ThemeApplication.lightTheme.backgroundColor2,
  fontSize: 16,
  fontWeight: FontWeight.w200,
);
TextStyle commonTextMain = const TextStyle(
  color: Colors.black54,
  fontSize: 12,
);
TextStyle commonText = const TextStyle(
  color: Colors.black54,
  fontSize: 14,
);

class RiveUtils {
  static StateMachineController getRController(Artboard artboard,
      {stateMachineName = 'State Machine 1'}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);
    artboard.addController(controller!);
    return controller;
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget? page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
