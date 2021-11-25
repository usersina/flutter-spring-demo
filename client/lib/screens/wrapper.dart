import 'package:client/models/user.dart';
import 'package:client/screens/authenticate/authenticate.dart';
import 'package:client/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // -- Subscribe to the User provided by the previous widget stream
    final user = Provider.of<User?>(context);
    return user == null ? const Authenticate() : const Home();
  }
}
