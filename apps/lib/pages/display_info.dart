import 'package:flutter/material.dart';
import 'dart:io';
class DisplayInfo extends StatefulWidget {
  @override
  _DisplayInfo createState() => _DisplayInfo();
}

class _DisplayInfo extends State<DisplayInfo> {

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
            Center(
              child: (

                Image.file(File(data['image_path']))
              ),
            ),
            Divider(
              color: Colors.grey[800],
              height: 60.0,
            ),
            Text(
              'NAME OF PLANT',
              style: TextStyle(
                color: Colors.greenAccent,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              data['plant_name'],
              style: TextStyle(
                color: Colors.black,
               // fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'DISEASE DETECTED',
              style: TextStyle(
                color: Colors.greenAccent,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              data['disease_detected'],
              style: TextStyle(
                color: Colors.black,
               // fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'MORE INFORMATION',
              style: TextStyle(
                color: Colors.greenAccent,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child:
                Text(
                  'Oryza sativa, commonly known as Asian rice, is the plant species most commonly referred to in English as rice. It is the type of farmed rice whose cultivars are most common globally, and was first domesticated in the Yangtze River basin in China 13,500 to 8,200 years ago.',
                  style: TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  ),

              )
            ),

          ],
        ),
      ),
    );
  }
}
