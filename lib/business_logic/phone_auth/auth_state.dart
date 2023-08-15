import 'package:equatable/equatable.dart';

abstract class AuthStates extends Equatable {
  const AuthStates();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String error;

  const AuthErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AuthOtpVerifiedState extends AuthStates {}
