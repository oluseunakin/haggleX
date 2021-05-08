// @dart=2.9

import 'package:flutter/material.dart';
import 'package:graphql/client.dart' hide JsonSerializable;
import 'package:haggle/screens/VerifyEmail.dart';

import 'screens/Complete.dart';
import 'screens/Home.dart';
import 'screens/Homepage.dart';
import 'screens/RegisterScreen.dart';

void main() {
  runApp(MyApp());
}

GraphQLClient createClient(String token) {
  final httpLink =
      HttpLink('https://hagglex-backend-staging.herokuapp.com/graphql');
  final authLink = AuthLink(
    getToken: () async => token,
  );
  return GraphQLClient(cache: GraphQLCache(), link: authLink.concat(httpLink));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haggle App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.purple[900],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Welcome to Haggle'),
        '/register': (context) => Register(),
        '/verify': (context) => VerifyEmail(),
        '/complete': (context) => SetUpComplete(),
        '/home': (context) => Home()
      },
    );
  }
}
