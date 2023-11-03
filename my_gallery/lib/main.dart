import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: const MyGalleryApp(),
    );
  }
}

class MyGalleryApp extends StatefulWidget {
  const MyGalleryApp({Key? key}) : super(key: key);

  @override
  State<MyGalleryApp> createState() => _MyGalleryAppState();
}

class _MyGalleryAppState extends State<MyGalleryApp> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images;

  @override
  void initState() {
    super.initState();


    loadImages();
  }
  Future<void> loadImages() async{
    images = await _picker.pickMultiImage();
    setState(() { // 화면 갱신해줘 --

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('전자액자'),
      ),
      // body: Image.,
    );
  }
}
