import 'package:food_dash/bloc/register_cubt/register_cubit.dart';
import 'package:food_dash/presentation/config/config.dart';
import 'package:food_dash/presentation/config/theming/sample.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final emailFormFieldController = TextEditingController();
  final passwordFormFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        builder: (BuildContext context, state) {
      return Form(
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
                margin: EdgeInsetsDirectional.fromSTEB(25.0, 0, 25.0, 0),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(children: [
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
                          if (_formKey.currentState.validate()) {
                            await context.read<RegisterCubit>().register(
                                email: emailFormFieldController.text,
                                password: passwordFormFieldController.text);
                          }
                        },
                        child: const Text('REGISTER'),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      loginText()
                    ])))
          ],
        ),
      );
    }, listener: (BuildContext context, state) async {
      if (state is RegisterPendingState) {
        await EasyLoading.show(status: 'Register..');
      } else if (state is RegisterSucceededState) {
        await EasyLoading.showSuccess('Register Success!');
        Navigator.of(context).pushReplacementNamed(AppRouter.homeScreen);
      } else if (state is RegisterFailedState) {
        await EasyLoading.showError(state.errorMessage);
      }
    });
  }

  Widget emailFormField() => TextFormField(
        controller: emailFormFieldController,
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
        controller: passwordFormFieldController,
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
  Widget loginText() => RichText(
      text: TextSpan(
          text: 'LOGIN',
          style: DefaultTextStyle.of(context).style,
          recognizer: TapGestureRecognizer()
            ..onTap = () => Navigator.of(context).pop()));
  Widget appName() => RichText(
          text: TextSpan(
        text: 'APP NAME HERE',
        style: CustomTheme.lightTheme.textTheme.headline2,
      ));
  @override
  void dispose() {
    super.dispose();
    emailFormFieldController.dispose();
    passwordFormFieldController.dispose();
  }
}
