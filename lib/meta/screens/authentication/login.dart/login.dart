import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/meta/screens/authentication/signup.dart/signup.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/widgets/primary_button.dart';
import 'package:beauty_store/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Text(AppConfig.appName,
                  style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 40),
              PrimaryTextField(
                title: "Email",
                controller: _email,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextField(
                title: "Password",
                isPasswordField: true,
                controller: _password,
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PrimaryButton(
                  title: "Login",
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (_email.text.trim().isEmpty && _password.text.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Email and Password cannot be empty");
                    } else if (_email.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Email cannot be empty");
                    } else if (_password.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Password cannot be empty");
                    } else {
                      await AuthService()
                          .login(_email.text, _password.text, context);
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUpView()));
                  },
                  child: const Text("Create an Account? Sign Up."))
            ],
          ),
        ),
      )),
    );
  }
}
