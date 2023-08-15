import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_state.dart';
import 'package:flutter_maps/presentation/screens/map_screen.dart';
import 'package:flutter_maps/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/functions/show_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String otpCode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is AuthLoadingState) {
          showCircularProgressIndicator(context: context);
        }
        if (state is AuthOtpVerifiedState) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MapScreen(),
            ),
            (route) => false,
          );
        }
        if (state is AuthErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 10),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 88.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Verify your phone number",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text.rich(
                    TextSpan(
                      text: "Enter your 6 digit code sent at ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: widget.phoneNumber,
                          style: const TextStyle(
                            color: MyColors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 110.0,
                ),
                buildPinCodeFields(context),
                const SizedBox(
                  height: 70.0,
                ),
                CustomElevatedButton(
                  text: "verify",
                  onPressed: () {
                    showCircularProgressIndicator(context: context);
                    context.read<AuthCubit>().submitOtp(otpCode: otpCode);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPinCodeFields(BuildContext context) => PinCodeTextField(
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
          otpCode = code;
        },
        onChanged: (value) {
          debugPrint(value);
        },
      );
}
