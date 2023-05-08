part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class UserSignUpEvent extends AuthEvent {
  UserAuthModel userAuthModel;
  String password;
  UserSignUpEvent({required this.userAuthModel,required this.password});
}
