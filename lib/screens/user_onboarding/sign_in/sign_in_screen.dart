import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_note_app/custom_widgets/custom_logo.dart';
import 'package:firebase_note_app/custom_widgets/custom_snackbar.dart';
import 'package:firebase_note_app/custom_widgets/custom_textfield.dart';
import 'package:firebase_note_app/screens/home_screen/home_screen.dart';
import 'package:firebase_note_app/screens/user_onboarding/bloc/auth_bloc.dart';
import 'package:firebase_note_app/screens/user_onboarding/sign_up/sign_up_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var hidePassword = true;

  void login(TextEditingController _emailController,
      TextEditingController _passwordController) async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      customSnackbarMessenger(context, "Please enter email and password");
    } else {
      // try {
      //   await FirebaseAuth.instance
      //       .signInWithEmailAndPassword(
      //           email: _emailController.text,
      //           password: _passwordController.text)
      //       .then((value) {
      //     customSnackbarMessenger(context, "Login successful");
      //     Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => HomeScreen(),
      //         ));
      //   });
      // } on FirebaseAuthException catch (e) {
      //   customSnackbarMessenger(context, e.toString());
      // }

      BlocProvider.of<AuthBloc>(context).add(UserLoginEvent(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    var isLight = Theme.of(context).brightness == Brightness.light;
    var height = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserLoggedInState) {
          customSnackbarMessenger(context, "Login successful");
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
              ? portraitUi(isLight, height)
              : landscapeUI(isLight)),
    );
  }

  Widget mainUi(isLight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SafeArea(
          child: SizedBox(
            height: 10,
          ),
        ),
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
          "Hello Again",
          style: mTextStyle43(
            mColor: isLight ? MyColor.bgBColor : MyColor.bgWColor,
          ),
        ),
        Text(
          "Welcome back you have been missed",
          style: mTextStyle16(mColor: MyColor.secondaryBColor),
        ),
        SizedBox(
          height: 28,
        ),
        CustomTextField(
          color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
          hintText: "Email",
          obscureText: false,
          controller: emailController,
          icon: Icons.mail_outlined,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextField(
          color: isLight ? MyColor.bgBColor : MyColor.bgWColor,
          hintText: "Password",
          obscureText: hidePassword,
          controller: passwordController,
          icon: Icons.lock_outline,
          suffixIcon: hidePassword ? Icons.visibility : Icons.visibility_off,
          voidCallback: () {
            hidePassword = !hidePassword;
            setState(() {});
          },
        ),
        SizedBox(
          height: 21,
        ),
        ElevatedButton(
          child: Text("Login"),
          onPressed: () {
            login(emailController, passwordController);
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text("Don't have an acount ?"),
            SizedBox(
              width: 5,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ));
                },
                child:
                    Text("Sign-Up", style: mTextStyle16(mColor: Colors.blue)))
          ],
        )
      ],
    );
  }

  Widget portraitUi(isLight, height) {
    // return height > 450
    //     ? mainUi(isLight)
    //     :
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
