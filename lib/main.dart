import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/firebase_options.dart';
import 'package:flutter_maps/presentation/screens/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlutterMaps());
}

class FlutterMaps extends StatelessWidget {
  const FlutterMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
      ),
    );
  }
}
