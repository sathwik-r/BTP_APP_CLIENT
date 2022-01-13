import 'dart:io';
import 'display_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
// class PlantDoctor extends StatefulWidget {
//   @override
//   _PlantDoctor createState()=> _PlantDoctor();
// }
// class _PlantDoctor extends State<PlantDoctor>{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Plant Doctor',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyImagePicker(title: 'Upload image'),
//     );
//   }
// }
class PlantDoctor extends StatefulWidget {
  final String title='Plant Doctor';

  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<PlantDoctor> {
   PickedFile? _imageFile;
  //final String uploadUrl = 'http://plantdoctorv2-env.eba-nwd2am9b.ap-south-1.elasticbeanstalk.com/process_image';
  final String uploadUrl='http://10.0.2.2:5000/process_image';
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    print("image is" + filepath);
    request.files.add(await http.MultipartFile.fromPath('image', filepath));
    var streamedResponse = await request.send();
    var res = await http.Response.fromStream(streamedResponse);
    Map decoded;
    print(res);
    if( res.statusCode==200){
      print(res.body);
      decoded= jsonDecode(res.body.toString().replaceAll("\n",""));
      print("decoded");
      print(decoded);
      try{
        Navigator.pushReplacementNamed(context, "/display", arguments: {
          'plant_name': decoded['plant_name'],
          'disease_detected': decoded['disease_detected'],
          'image_path': filepath
          // 'plant_name': "Test",
          // 'disease_detected': "Disease",
          // 'image_path': filepath
        });

      }
      catch (e) {
        print("Navigation error " );
        Navigator.pushReplacementNamed(context, "/error", arguments: {
          'error': e.toString()
        });
      }
    }
    // try{
    //   Navigator.pushReplacementNamed(context, "/display", arguments: {
    //     'plant_name': decoded.data.plant_name,
    //     'disease_detected': decoded.data.disease_detected,
    //     'image_path': filepath
    //     // 'plant_name': "Test",
    //     // 'disease_detected': "Disease",
    //     // 'image_path': filepath
    //   });
    // }
    // catch (e) {
    //   print("Navigation error " );
    // }

  }
  Future<void> retriveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      print('Retrieve error ' + response.exception.code);
    }
  }

  Widget _previewImage() {
    if (_imageFile != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(File(_imageFile!.path)),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () async {
                 await uploadImage(_imageFile!.path, uploadUrl);

              },
              child: const Text('Upload'),
            )
          ],
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("Image picker error "+e.toString() );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plant Doctor'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        leading: GestureDetector(
          onTap: () { /* Write listener code here */ },
          child: Icon(
            Icons.menu,  // add custom icons also
          ),
        ),
        elevation: 0.0,
      ),

      body: Center(
          child: FutureBuilder<void>(
            future: retriveLostData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Text('Picked an image');
                case ConnectionState.done:
                  return _previewImage();
                default:
                  return const Text('Picked an image');
              }
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image from gallery',
        child: Icon(Icons.photo_library),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}