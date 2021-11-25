import 'dart:developer';

import 'package:client/models/user.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/services/http_auth_service.dart';
import 'package:client/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final HttpAuthService _httpAuthService = HttpAuthService();

  final _formKey = GlobalKey<FormState>();
  bool _enableAutoValidation = false;
  // bool loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in to get access"),
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
              "Register",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
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
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _enableAutoValidation = true;
                    });
                    if (_formKey.currentState == null) return;

                    if (_formKey.currentState!.validate()) {
                      try {
                        User user =
                            await _httpAuthService.signInWithEmailAndPassword(
                          _emailController.text,
                          _passwordController.text,
                        );
                        _userProvider.setNextStreamValue(user);
                      } catch (e) {
                        log(e.toString());
                      }
                    }
                  },
                  child: const Text(
                    "Sign In",
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
