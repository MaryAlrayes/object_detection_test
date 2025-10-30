import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter TTS')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                  );

                  final options = ObjectDetectorOptions(
                    mode: DetectionMode.single,
                    classifyObjects: true,
                    multipleObjects: true,
                  );
                  print(
                    '111111111111111111111111111111111111111111111111111111',
                  );
                  final objectDetector = ObjectDetector(options: options);

                  print(
                    '2222222222222222222222222222222222222222222222222222222222222222',
                  );
                  final inputImage = InputImage.fromFilePath(image!.path);

                  print(
                    '33333333333333333333333333333333333333333333333333333333333333333333333',
                  );
                  final List<DetectedObject> objects = await objectDetector
                      .processImage(inputImage);

                  print(
                    '4444444444444444444444444444444444444444444444444444444444444444444444444',
                  );
                  for (final object in objects) {
                    print('Object detected at: ${object.boundingBox}');
                    print(
                      'oooooooooobbbbbbbbbbbbbbbbbbb ${object.toString()}}',
                    );
                    for (final label in object.labels) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Label: ${label.text}, Confidence: ${label.confidence}',
                          ),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.black87,
                        ),
                      );
                      print(
                        'hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
                      );
                      print(
                        'Label: ${label.text}, Confidence: ${label.confidence}',
                      );
                    }
                  }
                },
                child: Text('capture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
