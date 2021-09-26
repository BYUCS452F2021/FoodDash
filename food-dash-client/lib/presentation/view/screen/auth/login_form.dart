import 'package:dating_idea/bloc/bloc.dart';
import 'package:dating_idea/bloc/google_signIn/google_signIn_controller.dart';
import 'package:dating_idea/presentation/config/config.dart';
import 'package:dating_idea/presentation/config/theming/sample.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

/// LoginForm containing the form fields
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormFieldController = TextEditingController();
  final _passwordFormFieldController = TextEditingController();
  final _googleSignInController = GoogleSignInController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appName(),
              const SizedBox(
                height: 15.0,
              ),
              Card(
                color: CustomTheme.lightTheme.backgroundColor,
                elevation: 3.9,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: const EdgeInsetsDirectional.fromSTEB(25.0, 0, 25.0, 0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      emailFormField(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      passwordFormField(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final String email = _emailFormFieldController.text;
                            final String password =
                                _passwordFormFieldController.text;
                            await context
                                .read<LoginCubit>()
                                .login(email: email, password: password);
                          },
                          child: const Text('LOGIN'),
                          style: ElevatedButton.styleFrom(
                            primary: CustomTheme.lightTheme
                                .buttonColor, // Use the component's default
                            onPrimary: Colors.white,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // fontStyle: FontStyle.italic
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          )),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SignInButton(Buttons.GoogleDark, onPressed: _googleSign),
                      const SizedBox(
                        height: 5.0,
                      ),
                      registerText()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        listener: (BuildContext _, loginState) async {
          if (loginState is LoginPendingState) {
            await EasyLoading.showProgress(0.3, status: 'Login...');
          } else if (loginState is LoginSucceededState) {
            await EasyLoading.showSuccess('Login Success!');
          } else if (loginState is LoginFailedState) {
            await EasyLoading.showError(loginState.errorMessage);
          }
        });
  }

  Widget emailFormField() => TextFormField(
        controller: _emailFormFieldController,
        decoration: InputDecoration(
          labelText: "Email",
          prefixIcon: const Icon(Icons.email),
          filled: true,
          fillColor: Colors.white.withOpacity(.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );

  Widget passwordFormField() => TextFormField(
        controller: _passwordFormFieldController,
        decoration: InputDecoration(
          labelText: "Password",
          prefixIcon: const Icon(Icons.lock),
          filled: true,
          fillColor: Colors.white.withOpacity(.5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
  Widget registerText() => RichText(
        text: TextSpan(
            text: 'SIGNUP',
            style: DefaultTextStyle.of(context).style,
            recognizer: TapGestureRecognizer()
              ..onTap = () =>
                  Navigator.of(context).pushNamed(AppRouter.registerScreen)),
      );
  Widget appName() => RichText(
          text: TextSpan(
            text: 'FoodDash',
            style: CustomTheme.lightTheme.textTheme.headline2,
            //style: DefaultTextStyle.of(context).style,
          )
  );

  void _googleSign() async {
    final response = await _googleSignInController.googleSignIn();

    if (response.user == null) {
      await EasyLoading.showError("Google SignIn failed");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailFormFieldController.dispose();
    _passwordFormFieldController.dispose();
  }
}
