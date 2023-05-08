part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoadedState extends AuthState {
  List<UserAuthModel> arrUserCred;
  AuthLoadedState(this.arrUserCred);
}

class AuthUserCreatedState extends AuthState {}

class AuthUserLoggedInState extends AuthState {}

class AuthUserLoggedOutState extends AuthState {}

class AuthErrorState extends AuthState {
  String errorMsg;
  AuthErrorState(this.errorMsg);
}
