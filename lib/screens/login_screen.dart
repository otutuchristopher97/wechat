import 'package:connectivity/connectivity.dart';
import 'package:flash_chat/utils/share/distributor_textformfield.dart';
import 'package:flash_chat/utils/share/round_raisebotton.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _obscurePassword = true;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _isLoading = false;

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState.validate()) {
      return;
    }
    _loginFormKey.currentState.save();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
      });
      try {
        print(email);
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(kChartScreen, (route) => false);
        }
      } catch (error) {
        print(error.toString());
        Get.snackbar('Error', "Wrong Credentials",
            barBlur: 0,
            colorText: Colors.white,
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            backgroundColor: Color(0xff3810D7),
            overlayBlur: 0,
            animationDuration: Duration(seconds: 2),
            duration: Duration(seconds: 3));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      Get.snackbar('Info', "Please check your Internet connection!!!",
          barBlur: 0,
          colorText: Colors.white,
          dismissDirection: SnackDismissDirection.HORIZONTAL,
          backgroundColor: Color(0xff3810D7),
          overlayBlur: 0,
          animationDuration: Duration(seconds: 2),
          duration: Duration(seconds: 3));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  "assets/images/icon.png",
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Image.asset(
                  "assets/images/WeChat.png",
                  width: 120,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  "Welcome back!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff365770)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Hello, Welcome back. Login to continue",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff365770)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextFormField(
                          hintText: "Email",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "required";
                            } else if (!value.contains("@") ||
                                !value.contains(".")) {
                              return "Enter a valid email address";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            email = value.toString().trim();
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Password",
                          icon: _obscurePassword
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : Icon(Icons.visibility, color: Colors.grey),
                          obscureText: _obscurePassword,
                          iconPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Required";
                            }
                          },
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: RoundedRaisedButton(
                            title: "LOGIN",
                            titleColor: Colors.white,
                            isLoading: _isLoading,
                            buttonColor: Color(0xff3810D7),
                            onPress: ()=> _submitLogin(),
                          ),
                        ),
                        // RoundedButton(
                        //   title: 'Log In',
                        //   colour: Colors.lightBlueAccent,
                        //   onPressed: () async {
                        //     setState(() {
                        //       showSpinner = true;
                        //     });
                        //     try {
                        //       final user = await _auth.signInWithEmailAndPassword(
                        //           email: email, password: password);
                        //       if (user != null) {
                        //         Navigator.of(context).pushNamedAndRemoveUntil(
                        //             kChartScreen, (route) => false);
                        //       }
                  
                        //       setState(() {
                        //         showSpinner = false;
                        //       });
                        //     } catch (e) {
                        //       print(e);
                        //     }
                        //   },
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don’t have an account?   ",
                                    style: TextStyle(
                                        fontSize: 13, color: Color(0xffBDBDBD))),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(kRegistrationScreen);
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xff365770),
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
