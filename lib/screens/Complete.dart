import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetUpComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                Icon(Icons.check_circle_sharp),
                Text(
                  'Setup Complete',
                  style: TextStyle(color: Colors.lightBlue),
                ),
                Text(
                  'Thank you for setting up your HaggleX account',
                  style: TextStyle(color: Colors.lightBlue),
                )
              ],
            ),
            margin: EdgeInsets.only(top: 180.0),
            alignment: Alignment.center,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 120.0, 30.0, 60.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: Center(
                  child: Text('START EXPLORING'),
                )),
          )
        ],
      ),
    );
  }
}
