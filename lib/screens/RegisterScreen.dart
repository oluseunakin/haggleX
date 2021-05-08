import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:graphql/client.dart' hide JsonSerializable;
import 'package:haggle/Models/UserRO.dart';
import 'package:haggle/main.dart';
import '../Models/RegisterModel.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password, username, phone, currency, country;

  void register() async {
    FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      final MutationOptions options = MutationOptions(
        document: gql(r'''
        mutation Register($data: CreateUserInput) {
          action: register(data: $data) {
            user {
              email
            }
            token
          }
        }
        '''),
        variables: <String, dynamic>{
          'data': CreateUserInput(
              email, password, username, phone, currency, country),
        },
      );
      var client = createClient('');
      final QueryResult result = await client.mutate(options);
      if (result.data != null) {
        var userRO = UserRO.fromJson(result.data['action']);
        Navigator.pushNamed(context, '/verify', arguments: userRO);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
            child: ElevatedButton(
              child: Icon(Icons.navigate_before),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)))),
            ),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(20.0)),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Create a new account',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                Container(
                  child: TextFormField(
                      decoration: InputDecoration(hintText: 'Email Address'),
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
                      onSaved: (value) => email = value),
                  padding: EdgeInsets.all(15.0),
                ),
                Container(
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: 'Password(Min 8 characters)'),
                    validator: (String? value) {
                      if (value != null) {
                        if (value.length <= 8)
                          return "Password must be greater than 8";
                        return null;
                      }
                      return null;
                    },
                    onSaved: (value) => password = value,
                    obscureText: true,
                  ),
                  padding: EdgeInsets.all(15.0),
                ),
                Container(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: 'Create a username'),
                    onSaved: (value) => username = value,
                  ),
                  padding: EdgeInsets.all(15.0),
                ),
                Container(
                  child: TextFormField(
                    onSaved: (value) {
                      phone = value;
                      country = 'Nigeria';
                      currency = 'Naira';
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter your phone number',
                        icon: TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[Icon(Icons.phone_iphone)],
                            ))),
                  ),
                  padding: EdgeInsets.all(15.0),
                ),
                Container(
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: 'Referal code (optional)'),
                    onSaved: (value) {},
                  ),
                  padding: EdgeInsets.all(15.0),
                ),
                Container(
                  child: Text(
                    'By signing, you agree to HaggleX terms and conditions',
                  ),
                  padding: EdgeInsets.all(15.0),
                ),
                ElevatedButton(
                    onPressed: register,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text('SIGN UP'),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
