import 'package:flutter/material.dart';
import 'package:graphql/client.dart' hide JsonSerializable;
import 'package:haggle/Models/LoginModel.dart';
import 'package:haggle/Models/UserRO.dart';
import 'package:haggle/main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _address, _password;

  Future<void> _login() async {
    FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      final MutationOptions options = MutationOptions(
        document: gql(r'''
        mutation Login($data: LoginInput!) {
          action: login(data: $data) {
            user {
              email
            }
            token
          }
        }
        '''),
        variables: <String, dynamic>{
          'data': LoginInput(_address, _password),
        },
      );
      var client = createClient('');
      final QueryResult result = await client.mutate(options);
      if (!result.hasException) {
        var userRO = UserRO.fromJson(result.data['action']);
        Navigator.pushNamed(context, '/home', arguments: userRO);
      }
    }
  }

  void _forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.cyan),
              ),
              padding: EdgeInsets.symmetric(vertical: 70.0),
              alignment: Alignment.center,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    hintText: "Email Address",
                    hintStyle: TextStyle(color: Colors.cyan)),
                validator: (String? value) {
                  if (value != null) {
                    RegExp emailPattern = RegExp(
                        r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
                        caseSensitive: false);
                    if (!emailPattern.hasMatch(value))
                      return "Email Address is in a wrong format";
                    return null;
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _address = value;
                },
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: "Password (Min 8 characters)",
                      hintStyle: TextStyle(color: Colors.cyan)),
                  obscureText: true,
                  validator: (String? value) {
                    if (value != null) {
                      if (value.length <= 8)
                        return "Password must be greater than 8";
                      return null;
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value;
                  },
                )),
            Container(
              child: TextButton(
                  style: ButtonStyle(),
                  onPressed: _forgotPassword,
                  child: Text('Forgot Password')),
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                  onPressed: _login,
                  child: Center(
                    child: Text(
                      'LOG IN',
                    ),
                  )),
            ),
            Container(
              child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'New User?Create a new account',
                  )),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.bottomCenter,
            )
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
