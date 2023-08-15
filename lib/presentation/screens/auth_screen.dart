import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_state.dart';
import 'package:flutter_maps/presentation/screens/otp_screen.dart';
import 'package:flutter_maps/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/functions/get_country_flag.dart';
import 'package:flutter_maps/utils/functions/show_dialog.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

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
        if (state is AuthSuccessState) {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phoneNumber: phoneController.text,
              ),
            ),
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
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 88.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "What is your phone number ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      "Please enter our phone number to verify account.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 110.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.lightGrey,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            "${getCountryFlag()} +20",
                            style: const TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.blue,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            autofocus: true,
                            style: const TextStyle(
                              fontSize: 18.0,
                              letterSpacing: 2.0,
                            ),
                            decoration: const InputDecoration(border: InputBorder.none),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your phone number";
                              } else if (value.length < 11) {
                                return " Too short for a phone number!";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70.0,
                  ),
                  CustomElevatedButton(
                    text: "Next",
                    onPressed: () {
                      showCircularProgressIndicator(context: context);
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        context.read<AuthCubit>().submitPhoneNumber(phoneNumber: phoneController.text);
                      } else {
                        Navigator.pop(context);
                        return;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
