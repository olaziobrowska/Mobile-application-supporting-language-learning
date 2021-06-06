import 'package:flutter/material.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'package:language_app/views/home_view/homeView.dart';
import 'package:language_app/views/lessons_view/lessonsView.dart';
import 'package:language_app/views/flashcards_views/flashcardGroupsView.dart';
import 'package:language_app/views/flashcards_views/flashcardsView.dart';
import 'package:language_app/views/progress_view/progressView.dart';
import 'package:language_app/views/register_view/registerView.dart';
import 'package:language_app/views/reset_password_view/resetPasswordView.dart';
import 'package:language_app/views/test_views/testABCDView.dart';
import 'package:language_app/views/test_views/testSetUpView.dart';
import 'package:language_app/views/test_views/testTextView.dart';
import 'package:language_app/views/welcome_view/welcomeView.dart';

import 'services/notificationService.dart';
import 'views/login_view/loginView.dart';

class App extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  String email;
  App({this.email});
  @override
  Widget build(BuildContext context) {
    final pushNotificationService = PushNotificationService();
    pushNotificationService.initialize();

    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.grey[350]),
      // Route indicated in initial route always has priority before '/' route
      navigatorKey: _navigationService.navigatorKey,
      home: email == null ? WelcomeView() : HomeView(),
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
            // ignore: missing_return
            return MaterialPageRoute(builder: (context) => FlashcardView());
          case 'testView':
            return MaterialPageRoute(builder: (context) => TestSetUpView());
          case 'abcdTestView':
            return MaterialPageRoute(builder: (context) => TestABCDView());
          case 'textTestView':
            return MaterialPageRoute(builder: (context) => TestTextView());
          case 'publicFlashcardsView':
            return MaterialPageRoute(builder: (context) => FlashcardGroupsView(publicGroups: true));
        }
      },
    );
  }
}
