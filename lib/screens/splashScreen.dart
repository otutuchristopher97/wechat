import 'dart:async';

import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.of(context).popAndPushNamed(kLoginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icon.png",
                  ),
                  SizedBox(height: 10,),
                  Image.asset(
                    "assets/images/WeChat.png",
                    width: 150,
                  ),
                ],
              ),
            )),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Powered By ',
                style: TextStyle(fontWeight: FontWeight.normal, color: Color(0xff687078), fontSize: 12),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Chris Technologies',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff365770), fontSize: 12)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
