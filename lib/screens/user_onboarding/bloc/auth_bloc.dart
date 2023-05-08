import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/models/user_auth_model.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<UserSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: event.userAuthModel.email!, password: event.password)
            .then((value) async {
          User? currentUser = await FirebaseAuth.instance.currentUser!;
          UserAuthModel newAuthModel = UserAuthModel(
              id: currentUser.uid,
              name: event.userAuthModel.name,
              email: event.userAuthModel.email,
              mobileNo: event.userAuthModel.mobileNo);
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(event.userAuthModel.email)
              .set(newAuthModel.toJson());
        });
      } on FirebaseAuthException catch (e) {
        emit(AuthErrorState(e.toString()));
      }
    });
  }
}
