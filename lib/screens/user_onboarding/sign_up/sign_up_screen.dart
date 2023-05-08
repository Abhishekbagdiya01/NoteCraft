import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/custom_widgets/custom_logo.dart';
import 'package:firebase_note_app/custom_widgets/custom_snackbar.dart';
import 'package:firebase_note_app/custom_widgets/custom_textfield.dart';
import 'package:firebase_note_app/models/user_auth_model.dart';
import 'package:firebase_note_app/screens/home_screen/home_screen.dart';
import 'package:firebase_note_app/screens/user_onboarding/bloc/auth_bloc.dart';
import 'package:firebase_note_app/screens/user_onboarding/sign_in/sign_in_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController mobNoController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var hidePassword = true;

  var hideConfirmPassword = true;

  Future signUp(
      TextEditingController _emailController,
      TextEditingController _passwordController,
      TextEditingController _nameController,
      TextEditingController _mobNoController) async {
    if (_emailController.text.trim() == "" ||
        _passwordController.text.trim() == "" ||
        _mobNoController == "" ||
        _nameController == "") {
      customSnackbarMessenger(context, "Required field cannot be empty");
    } else {
      UserAuthModel newUser = UserAuthModel(
          id: '',
          name: _nameController.text,
          email: _emailController.text,
          mobileNo: _mobNoController.text);

      BlocProvider.of<AuthBloc>(context).add(UserSignUpEvent(
          userAuthModel: newUser, password: _passwordController.text));

      /* try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) async {
          User? currentUser = await FirebaseAuth.instance.currentUser!;

          UserAuthModel newUser = await UserAuthModel(
              id: currentUser.uid,
              name: _nameController.text,
              email: _emailController.text,
              mobileNo: _mobNoController.text);

          await FirebaseFirestore.instance
              .collection("Users")
              .doc(_emailController.text)
              .set(newUser.toJson());

          customSnackbarMessenger(context, "Account created successfully");
          return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        });
      } on FirebaseAuthException catch (e) {
        customSnackbarMessenger(context, e.toString());
      }*/
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    print(orientation);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserCreatedState) {
          print("asdf");
          customSnackbarMessenger(context, "Account created successfully");

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        } else if (state is AuthErrorState) {
          customSnackbarMessenger(context, state.errorMsg);
        }
      },
      child: Scaffold(
          body: orientation == Orientation.portrait
              ? portraitUI(isLight, height)
              : landscapeUI(isLight)),
    );
  }

  Widget mainUi(isLight) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomLogo(
                isLight: isLight,
                radius: 60,
                height: 80,
                width: 80,
              ),
              SizedBox(
                height: 21,
              ),
              Text(
                "Welcome",
                style: mTextStyle25(
                    mColor: isLight ? MyColor.bgBColor : MyColor.bgWColor),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "Name",
                controller: nameController,
                icon: Icons.person,
                textInputType: TextInputType.text,
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "Email",
                controller: emailController,
                icon: Icons.email_outlined,
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "Mobille No",
                controller: mobNoController,
                icon: Icons.call,
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                textInputType: TextInputType.phone,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                hintText: "Password",
                controller: passwordController,
                obscureText: hidePassword,
                icon: Icons.lock_outline,
                color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                textInputType: TextInputType.text,
                suffixIcon:
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                voidCallback: () {
                  hidePassword = !hidePassword;
                  setState(() {});
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: hideConfirmPassword,
                  icon: Icons.lock_outline,
                  color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
                  textInputType: TextInputType.text,
                  suffixIcon: hideConfirmPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  voidCallback: () {
                    hideConfirmPassword = !hideConfirmPassword;
                    setState(() {});
                  }),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                child: Text("SignUp"),
                onPressed: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    signUp(emailController, passwordController, nameController,
                        mobNoController);
                  } else {
                    customSnackbarMessenger(context,
                        "Password and confirm password does not match");
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Already have an account ?"),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: Text(
                        "Login",
                        style: mTextStyle16(mColor: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget portraitUI(isLight, height) {
    // return height > 600
    //     ? mainUi(isLight)
    // :
    return SingleChildScrollView(
      child: mainUi(isLight),
    );
  }

  Widget landscapeUI(isLight) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
            child: Center(
              child: CustomLogo(
                isLight: isLight,
                radius: 150,
              ),
            ),
          ),
        ),
        Expanded(child: SingleChildScrollView(child: mainUi(isLight)))
      ],
    );
  }
}
