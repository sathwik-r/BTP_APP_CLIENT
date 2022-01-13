import 'package:flutter/material.dart';
import 'dart:io';
class DisplayError extends StatefulWidget {
  @override
  _DisplayError createState() => _DisplayError();
}

class _DisplayError extends State<DisplayError> {

  Map data = {};
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings?.arguments as Map;
    // data= {'plant_name': "Test",
    //   'disease_detected': "Disease",
    // };
    print(data);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plant Doctor'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
      ),


      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Divider(
              color: Colors.grey[800],
              height: 60.0,
            ),
            Text(
              'Error',
              style: TextStyle(
                color: Colors.greenAccent,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              data['error'],
              style: TextStyle(
                color: Colors.black,
                // fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 2.0,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
