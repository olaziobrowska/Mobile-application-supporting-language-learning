import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/components/common/commonComponents.dart';
import 'package:language_app/utils/routes/routes.dart';
import 'LoginViewStyle.dart';

class ResetPasswordView extends StatefulWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  ResetPasswordView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final emailController = TextEditingController();
  Future<void> _sendEmailWithNewPassword() async {
    await auth.sendPasswordResetEmail(email: emailController.text);
    widget._navigationService.navigateTo('loginView', 0);
  }
  void _navigateToRegister() {
    widget._navigationService.navigateTo('registerView', 0);
  }
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final emailField = TextInputComponent("Email", false, null, emailController);
    final loginButton = OnPressButton("Send email", _sendEmailWithNewPassword, context);
    final logoPath = "assets/images/placeholder.png";

    List<Widget> widgetList = [
      emailField,
      loginButton,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Container(
                child: Form(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [LoginViewPadding(widgetList, logoPath)]),
                ))),
      ),
    );
  }
}
