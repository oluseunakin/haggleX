import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:haggle/Models/EmailInput.dart';
import 'package:haggle/Models/UserRO.dart';
import 'package:haggle/Models/VerifyUserModel.dart';
import 'package:haggle/main.dart';

class VerifyEmail extends StatelessWidget {
  late final String code;

  @override
  Widget build(BuildContext context) {
    UserRO userRO = ModalRoute.of(context)!.settings.arguments as UserRO;
    String token = userRO.token;
    var client = createClient('Bearer $token');

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            child: ElevatedButton(
              child: Icon(Icons.navigate_before),
              onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)))),
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 25.0),
          child: Text(
            'Verify your account',
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 35.0, bottom: 20.0),
                      child: Icon(
                        Icons.check_circle_outline,
                      )),
                  Container(
                    child: Column(children: [
                      Text('We just sent a verification code to your email'),
                      Text('Please enter the code')
                    ]),
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  Container(
                    child: TextField(
                      decoration:
                          InputDecoration(hintText: 'Verification code'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => code = value,
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
                  ),
                  Container(
                      child: ElevatedButton(
                          onPressed: () async {
                            final MutationOptions options = MutationOptions(
                              document: gql(r'''
                      mutation VerifyUser($data: VerifyUserInput) {
                        action: verifyUser(data: $data) {
                          user {
                            email
                          }
                          token
                        }
                      }
                    '''),
                              variables: <String, dynamic>{
                                'data': VerifyUserInput(int.parse(code)),
                              },
                            );
                            final QueryResult result =
                                await client.mutate(options);
                            if (result.data != null) {
                              Navigator.pushNamed(context, '/complete',
                                  arguments: userRO);
                            } else {}
                          },
                          child: Center(child: Text('VERIFY ME'))),
                      margin: EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15.0)),
                  Center(child: Text('This code will expire in 10 minutes')),
                  Container(
                    child: TextButton(
                      onPressed: () async {
                        final QueryOptions options = QueryOptions(
                          document: gql(r'''
                      query ResendVerificationCode($data: EmailInput){
                        resendVerificationCode(data: $data)
                      }
                    '''),
                          variables: <String, dynamic>{
                            'data': EmailInput(userRO.user.email),
                          },
                        );
                        final QueryResult result = await client.query(options);
                        print(result);
                      },
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50.0),
                  )
                ],
              ),
            )),
      ],
    ));
  }
}
