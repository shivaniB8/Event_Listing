import 'package:flutter/material.dart' hide Notification;

import '../../generated/l10n.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
    //..

      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute<dynamic> createSimpleRoute(
      Widget screenWidget,
      RouteSettings? routeSettings,
      ) {
    return MaterialPageRoute(
      builder: (_) => screenWidget,
      settings: routeSettings,
    );
  }

  static Route createFadeTransitionRoute(
      Widget screenWidget, [
        RouteSettings? routeSettings,
      ]) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screenWidget,
      transitionsBuilder: (_, anim, __, child) => FadeTransition(
        opacity: anim,
        child: child,
      ),
      transitionDuration: const Duration(milliseconds: 500),
      settings: routeSettings,
    );
  }

  // Creates routes for invalid route names
  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(
            S.of(context).wrongRoute_message_error,
          ),
        ),
      ),
    );
  }
}
