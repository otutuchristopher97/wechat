import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:get/get.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      routes: {
         kLoginScreen: (ctx) => LoginScreen(),
         kRegistrationScreen: (ctx) => RegistrationScreen(),
         kChartScreen: (ctx) => ChatScreen()
      },
    );
  }
}
