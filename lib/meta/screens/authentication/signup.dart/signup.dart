import 'package:beauty_store/config/app_config.dart';
import 'package:beauty_store/meta/screens/authentication/login.dart/login.dart';
import 'package:beauty_store/services/auth.service.dart';
import 'package:beauty_store/widgets/primary_button.dart';
import 'package:beauty_store/widgets/primary_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpView extends StatefulWidget {
  SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool loading = false;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _address = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              Text(
                AppConfig.appName,
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 40),
              PrimaryTextField(
                title: "Full Name",
                controller: _name,
              ),
              const SizedBox(height: 20),
              PrimaryTextField(
                title: "Email",
                controller: _email,
              ),
              const SizedBox(height: 20),
              PrimaryTextField(title: "Phone Number", controller: _phone),
              const SizedBox(height: 20),
              PrimaryTextField(title: "Address", controller: _address),
              const SizedBox(height: 20),
              PrimaryTextField(
                  title: "Password",
                  isPasswordField: true,
                  controller: _password),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: PrimaryButton(
                  loading: loading,
                  title: "SignUp",
                  onTap: () async {
                    FocusScope.of(context).unfocus();

                    if (_email.text.trim().isEmpty &&
                        _address.text.trim().isEmpty &&
                        _name.text.trim().isEmpty &&
                        _phone.text.trim().isEmpty &&
                        _password.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Fields cannot be empty");
                    } else if (_name.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Full name cannot be empty.");
                    } else if (_email.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Email cannot be empty.");
                    } else if (_phone.text.length < 10) {
                      Fluttertoast.showToast(
                          msg: "Valid contact number required");
                    } else if (_address.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Address cannot be empty.");
                    } else if (_password.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Password cannot be empty.");
                    } else {
                      try {
                        await AuthService().signup(context,
                            name: _name.text,
                            email: _email.text,
                            password: _password.text,
                            phone: _phone.text,
                            address: _address.text);
                        setState(() {
                          loading = true;
                        });
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                },
                child: const Text(
                  "I have an account. LogIn?",
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
