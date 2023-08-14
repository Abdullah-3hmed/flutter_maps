import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/phone_auth/auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  late String verificationId;

  Future<void> submitPhoneNumber({required String phoneNumber}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2',
      //timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  Future<void> verificationCompleted(PhoneAuthCredential credential) async {
    debugPrint("verificationCompleted");
    await signIn(credential);
  }

  Future<void> verificationFailed(FirebaseAuthException error) async {
    debugPrint("verificationFailed ${error.toString()}");
    emit(AuthErrorState(error: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    debugPrint("code sent");
    this.verificationId = verificationId;
    emit(AuthSuccessState());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    debugPrint("codeAutoRetrievalTimeout");
  }

  Future<void> submitOtp({required String otpCode}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpCode,
    );
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (error) {}
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User loggedInUser() {
    return FirebaseAuth.instance.currentUser!;
  }
}
