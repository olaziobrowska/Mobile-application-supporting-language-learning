import 'package:flutter/material.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/register_view/registerView.dart';
import 'package:language_app/views/welcome_view/welcomeView.dart';
import 'services/notificationService.dart';
import 'views/login_view/loginView.dart';

class App extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialize();

    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.grey[350]),
      // Route indicated in initial route always has priority before '/' route
      navigatorKey: _navigationService.navigatorKey,
      home: WelcomeView(),
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case 'welcomeView':
            return MaterialPageRoute(builder: (context) => WelcomeView());
          case 'loginView':
            return MaterialPageRoute(builder: (context) => LoginView());
          case 'registerView':
            return MaterialPageRoute(builder: (context) => RegisterView());
        }
      },
    );
  }
}
