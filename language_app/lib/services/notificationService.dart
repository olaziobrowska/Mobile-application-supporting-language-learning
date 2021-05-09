import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:language_app/utils/routes/routes.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future _serialiseAndNavigate(Map<String, dynamic> message) async {
    String routeName = message['data']['routeName'];
    int routeId = int.parse(message['data']['routeId']);
    if ( routeName != null && routeId != null) {
      await _navigationService.navigateTo(routeName, routeId);
    } else {
      await _navigationService.navigateTo('welcomeView', 0);
    }
  }

  Future initialize() async {
    _firebaseMessaging.setAutoInitEnabled(true);
    _firebaseMessaging.configure(
        onResume: _serialiseAndNavigate, onLaunch: _serialiseAndNavigate);
  }
}
