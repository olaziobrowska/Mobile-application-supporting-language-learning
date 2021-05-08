import 'package:flutter/material.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/home_view/homeView.dart';
import 'package:language_app/views/lessons_view/lessonsView.dart';
import 'package:language_app/views/notes_view/notesView.dart';
import 'package:language_app/views/flashcards_views/flashcardGroupsView.dart';
import 'package:language_app/views/flashcards_views/flashcardsView.dart';
import 'package:language_app/views/progress_view/progressView.dart';
import 'package:language_app/views/register_view/registerView.dart';
import 'package:language_app/views/reset_password_view/resetPasswordView.dart';
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
            return MaterialPageRoute(builder: (context) => WelcomeView(id: routeSettings.arguments));
          case 'loginView':
            return MaterialPageRoute(builder: (context) => LoginView());
          case 'registerView':
            return MaterialPageRoute(builder: (context) => RegisterView());
          case 'homeView':
            return MaterialPageRoute(builder: (context) => HomeView());
          case 'lessonsView':
            return MaterialPageRoute(builder: (context) => LessonsView());
          case 'resetPasswordView':
            return MaterialPageRoute(builder: (context) => ResetPasswordView());
          case 'progressView':
            return MaterialPageRoute(builder: (context) => ProgressView());
          case 'flashcardGroupsView':
            return MaterialPageRoute(builder: (context) => FlashcardGroupsView());
          case 'flashcardsView':
            return MaterialPageRoute(builder: (context) => FlashcardView());
        }
      },
    );
  }
}
