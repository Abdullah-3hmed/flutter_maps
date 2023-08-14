import 'package:flutter/material.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatelessWidget {
  const PinCodeFields({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: MyColors.blue,
        inactiveColor: MyColors.blue,
        activeFillColor: MyColors.lightBlue,
        inactiveFillColor: Colors.white,
        selectedColor: MyColors.blue,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (code) {
        //otpCode = code;
      },
      onChanged: (value) {
        debugPrint(value);
      },
    );
  }
}
