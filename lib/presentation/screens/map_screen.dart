import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/presentation/screens/auth_screen.dart';
import 'package:flutter_maps/presentation/widgets/custom_elevated_button.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomElevatedButton(
          text: "logout",
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
              (route) => false,
            );
            context.read<AuthCubit>().logOut();
          },
        ),
      ),
    );
  }
}
