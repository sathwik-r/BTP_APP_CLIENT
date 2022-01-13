import 'package:flutter/material.dart';
import 'package:apps/pages/upload_image.dart';
import 'package:apps/pages/display_info.dart';
import 'package:apps/pages/display_error.dart';
void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/display': (context) => DisplayInfo(),
      '/': (context) => PlantDoctor(),
      '/error':(context)=>DisplayError(),

    }
));