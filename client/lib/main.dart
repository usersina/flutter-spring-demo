import 'package:client/models/user.dart';
import 'package:client/providers/user_provider.dart';
import 'package:client/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider _userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return StreamProvider<User?>.value(
      initialData: null,
      value: _userProvider.loggedUser$,
      child: MaterialApp(
        title: "Flutter HTTP demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
