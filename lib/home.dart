import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_360/panorama.dart';
import 'dart:io';

import 'getVideo.dart';
import 'overlay_camera.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Future<void> didChangeDependencies() async {
    cameras = await availableCameras();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste Camera 360'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PanoramaPage()),
                  );
                },
                child: Text('Imagem Panoramica')),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetVideo()),
                  );
                },
                child: Text('Get Video')),
            ElevatedButton(
                onPressed: () async {
                  final Directory directory =
                      await getApplicationDocumentsDirectory();

                  final dir = Directory('${directory.path}/frames');

                  if (dir.existsSync()) {
                    dir..deleteSync(recursive: true);
                  }
                },
                child: Text('Remover cache')),
            ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OverlayCamera()),
                  );
                },
                child: Text('Overlay Carro')),
          ],
        ),
      ),
    );
  }
}
