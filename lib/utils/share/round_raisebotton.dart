import 'package:flutter/material.dart';
import '../../constants.dart';

class RoundedRaisedButton extends StatelessWidget {
  bool isLoading;
  double circleborderRadius;
  String title;
  Color titleColor, buttonColor;
  Function onPress;
  RoundedRaisedButton({
    this.title,
    this.onPress,
    this.circleborderRadius,
    this.titleColor,
    this.buttonColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      // color: buttonColor,
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(circleborderRadius==null ? 15 : circleborderRadius)),
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: 20,
                  height: 20,
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white),
                ),
              )
            : Text(
                this.title,
                style: TextStyle(color: titleColor, fontSize: 16),
              ),
        color: buttonColor,
        disabledColor: buttonColor,
        onPressed: isLoading ? null : this.onPress,
      ),
    );
  }
}
