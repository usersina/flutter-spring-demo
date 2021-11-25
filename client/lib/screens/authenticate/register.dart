import 'dart:developer';

import 'package:client/models/user.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/services/http_auth_service.dart';
import 'package:client/shared/constants.dart';
import 'package:client/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final HttpAuthService _httpAuthService = HttpAuthService();

  final _formKey = GlobalKey<FormState>();
  bool _enableAutoValidation = false;
  bool loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    handleRegister() async {
      setState(() {
        _enableAutoValidation = true;
      });
      if (_formKey.currentState == null) return;

      if (_formKey.currentState!.validate()) {
        setState(() {
          loading = true;
        });

        try {
          User user = await _httpAuthService.registerWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
          _userProvider.setNextStreamValue(user);
        } catch (e) {
          log(e.toString());
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Clould not register in with these credentials!',
                style: TextStyle(fontSize: 16.0),
              ),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Create an account"),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _enableAutoValidation
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          if (value == null) return "";

                          if (value.isEmpty || !value.contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: "Enter your email",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) return "";

                          if (value.isEmpty || value.length < 3) {
                            return "Password should have 3 characters minimum";
                          }
                          return null;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: "Enter your password",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordConfirmController,
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null) return "";

                          if (value.isEmpty ||
                              value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        decoration: textInputDecoration.copyWith(
                          hintText: "Confirm your password",
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: handleRegister,
                        child: const Text(
                          "Register",
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
