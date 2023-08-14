import 'package:flutter/material.dart';
import 'package:flutter_maps/presentation/widgets/pin_code_fields.dart';
import 'package:flutter_maps/utils/colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        text: phoneNumber,
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
              const PinCodeFields(),
              const SizedBox(
                height: 70.0,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(110.0, 50.0),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
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
