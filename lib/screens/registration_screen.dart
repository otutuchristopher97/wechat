import 'package:connectivity/connectivity.dart';
import 'package:flash_chat/utils/share/distributor_textformfield.dart';
import 'package:flash_chat/utils/share/round_raisebotton.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> _signupFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _obscurePassword = true;
  bool _obscurePassword2 = true;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _isLoading = false;
  bool _hidePassword = true;
  TextEditingController _passwordController = TextEditingController();

  Future<void> submitReg() async {
    if (!_signupFormKey.currentState.validate()) {
      return;
    }
    _signupFormKey.currentState.save();
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('I am connected to a mobile network');
      setState(() {
        _isLoading = true;
      });
      try {
        print(email);
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        if (newUser != null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(kChartScreen, (route) => false);
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
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  "Hello there!",
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
                  "Create an account with us",
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
                    key: _signupFormKey,
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
                          controller: _passwordController,
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
                            if (value.length < 7) {
                              return "Password must be between 7 to 30 characters";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                        ),
                        CustomTextFormField(
                          hintText: "Confirm Password",
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return "Password does not match";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            password = value;
                          },
                          icon: _hidePassword
                              ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                          iconPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          obscureText: _hidePassword,
                        ),
                        SizedBox(
                          height: 50.0,
                        ),
                        Container(
                          width: double.infinity,
                          child: RoundedRaisedButton(
                            title: "SIGN UP",
                            titleColor: Colors.white,
                            buttonColor: Color(0xff3810D7),
                            isLoading: _isLoading,
                            onPress: () => submitReg(),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?  ",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xffBDBDBD))),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Log in",
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
              // Flexible(
              //   child: Hero(
              //     tag: 'logo',
              //     child: Container(
              //       height: 200.0,
              //       child: Image.asset('assets/images/logo.png'),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 48.0,
              // ),
              // TextField(
              //   keyboardType: TextInputType.emailAddress,
              //   textAlign: TextAlign.center,
              //   onChanged: (value) {
              //     email = value;
              //   },
              //   decoration:
              //       kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              // ),
              // SizedBox(
              //   height: 8.0,
              // ),
              // TextField(
              //   obscureText: true,
              //   textAlign: TextAlign.center,
              //   onChanged: (value) {
              //     password = value;
              //   },
              //   decoration: kTextFieldDecoration.copyWith(
              //       hintText: 'Enter your password'),
              // ),
              // SizedBox(
              //   height: 24.0,
              // ),
              // RoundedButton(
              //   title: 'Register',
              //   colour: Colors.blueAccent,
              //   onPressed: () async {
              //     setState(() {
              //       showSpinner = true;
              //     });
              //     try {
              //       final newUser = await _auth.createUserWithEmailAndPassword(
              //           email: email, password: password);
              //       if (newUser != null) {
              //         Navigator.of(context).pushNamedAndRemoveUntil(kChartScreen, (route) => false);
              //       }
              //       setState(() {
              //         showSpinner = false;
              //       });
              //     } catch (e) {
              //       print(e);
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
