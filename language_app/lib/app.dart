import 'package:flutter/material.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'services/notificationService.dart';
import 'views/default_view/defaultView.dart';

class App extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialize();

    return MaterialApp(
      // Route indicated in initial route always has priority before '/' route
      navigatorKey: _navigationService.navigatorKey,
      home: LoginView(),
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case 'loginView':
            return MaterialPageRoute(builder: (context) => LoginView());
        }
      },
    );
  }
}
