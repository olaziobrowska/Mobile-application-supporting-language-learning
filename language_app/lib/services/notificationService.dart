import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:language_app/utils/routes/routes.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future _serialiseAndNavigate(Map<String, dynamic> message) async {
    await _navigationService.navigateTo("loginView", 0);
  }

  Future initialize() async {
    _firebaseMessaging.setAutoInitEnabled(true);
    _firebaseMessaging.configure(
        onResume: _serialiseAndNavigate, onLaunch: _serialiseAndNavigate);
  }
}
