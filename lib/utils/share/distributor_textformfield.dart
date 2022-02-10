import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  String labelText, initialValue, hintText;
  Icon icon;
  Color textColor;
  bool obscureText, disabled;
  TextInputType keyboardType;
  TextEditingController controller;
  Function iconPressed, validator, onSaved;

  CustomTextFormField(
      {this.labelText,
      this.icon,
      this.obscureText = false,
      this.initialValue,
      this.textColor = Colors.black,
      this.iconPressed = null,
      this.disabled,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.hintText,
      this.onSaved,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            margin: EdgeInsets.only(top: 20),
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xff3810D7,),width: 1.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: icon != null
                  ? Padding(
                    padding: const EdgeInsets.only(top: 12, ),
                    child: TextFormField(
                        key: Key(labelText),
                        controller: controller,
                        onSaved: onSaved,
                        initialValue: initialValue,
                        validator: validator,
                        keyboardType: keyboardType,
                        obscureText: this.obscureText,
                        enabled: disabled,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: this.icon,
                              onPressed: this.iconPressed,
                            ),
                            hintText: hintText,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none),
                      ),
                  )
                  : TextFormField(
                      key: Key(labelText),
                      controller: controller,
                      onSaved: onSaved,
                      validator: validator,
                      initialValue: initialValue,
                      keyboardType: keyboardType,
                      enabled: disabled,
                      obscureText: this.obscureText,
                      decoration: InputDecoration(
                          hintText: hintText,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          // hintText: labelText,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
