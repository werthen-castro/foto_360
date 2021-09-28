import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:export_video_frame/export_video_frame.dart';
import 'package:path_provider/path_provider.dart';

class GetVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plugin Example App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(images: <Image>[]),
    );
  }
}

class ImageItem extends StatelessWidget {
  ImageItem({this.image}) : super(key: ObjectKey(image));
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(child: image);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.images});

  final List<Image> images;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isClean = false;
  final ImagePicker _picker = ImagePicker();
  Stream<File> _imagesStream;

  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _createDirectory() async {
    final String path = await _localPath;

    File file = File('$path/frames');

    try {
      if (!(await file.exists())) {
        final Directory directory =
            await Directory('$path/frames').create(recursive: true);
      }
    } catch (e) {}
  }

  Future _getImagesByTime() async {
    int index = 0;
    final PickedFile file = await _picker.getVideo(
      source: ImageSource.gallery,
    );
    _imagesStream = ExportVideoFrame.exportImagesFromFile(
      File(file.path),
      const Duration(milliseconds: 1000),
      0,
    );
    await _createDirectory();
    String path = await _localPath;

    _imagesStream.listen((image) async {
      index++;

      final pngByteData = await image.readAsBytes();
      File _file = File('$path/frames/$index.jpg');

      print('${_file.path}');

      _file.writeAsBytesSync(pngByteData);
    });
  }

  Future _handleClickFourth() async {
    await _getImagesByTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Export Image"),
      ),
      body: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 0,
              child: Center(
                child: MaterialButton(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  height: 40,
                  minWidth: 150,
                  onPressed: () {
                    _handleClickFourth();
                  },
                  color: Colors.orange,
                  child: Text("Recuperar video"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
