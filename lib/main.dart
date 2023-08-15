import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/firebase_options.dart';
import 'package:flutter_maps/presentation/screens/auth_screen.dart';
import 'package:flutter_maps/presentation/screens/map_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  late Widget startWidget;
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      debugPrint("null $user");
      startWidget = const AuthScreen();
    } else {
      debugPrint(" not null $user");
      startWidget = const MapScreen();
    }
  });
  runApp(
    FlutterMaps(
      startWidget: startWidget,
    ),
  );
}

class FlutterMaps extends StatelessWidget {
  const FlutterMaps({
    super.key,
    required this.startWidget,
  });

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}
