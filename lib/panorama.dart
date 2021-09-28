import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';
import 'package:panorama/panorama.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_360/view_image.dart';

class PinImage {
  double posX;
  double posY;
  Widget pin;
}

class PanoramaPage extends StatefulWidget {
  const PanoramaPage();

  @override
  _PanoramaPageState createState() => _PanoramaPageState();
}

class _PanoramaPageState extends State<PanoramaPage> {
  Color corLeft = Colors.white;
  Color corRigth = Colors.black54;
  Color corTemp = Colors.transparent;
  bool isExterior = true;

  List<ImageProvider> imageList = [];
  bool autoRotate = true;
  int rotationCount = 1;
  int swipeSensitivity = 1;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.clockwise;
  Duration frameChangeDuration = Duration(milliseconds: 10);
  bool imagePrecached = false;
  List<PinImage> pin = [];
  int posFrame = 0;

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  @override
  void dispose() {
    imageList.clear();
    super.dispose();
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap down " + x.toString() + ", " + y.toString());
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    print(details.localPosition);
    print("tap up " + x.toString() + ", " + y.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            isExterior
                ? Positioned(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 72.0),
                        child: (imagePrecached == true)
                            ? GestureDetector(
                                onTap: () {
                                  print('aqui');
                                },
                                onTapDown: (TapDownDetails details) =>
                                    _onTapDown(details),
                                onTapUp: (TapUpDetails details) =>
                                    _onTapUp(details),
                                child: Stack(
                                  children: [
                                    ImageView360(
                                      key: UniqueKey(),
                                      imageList: imageList,
                                      // autoRotate: autoRotate,
                                      rotationCount: rotationCount,

                                      // rotationDirection: RotationDirection.anticlockwise,
                                      frameChangeDuration:
                                          Duration(milliseconds: 100),
                                      swipeSensitivity: swipeSensitivity,
                                      allowSwipeToRotate: allowSwipeToRotate,
                                      onImageIndexChanged: (currentImageIndex) {
                                        print(
                                            "currentImageIndex: $currentImageIndex");
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Text("Pre-Caching images..."),
                      ),
                    ),
                  )
                : Positioned(
                    child: Container(
                      child: Panorama(
                          child: Image.asset('assets/R0010027.jpg'),
                          hotspots: [
                            Hotspot(
                              name: "nome",
                              latitude: -45.0,
                              longitude: 0.0,
                              orgin: Offset(0.5, 0.5),
                              width: 70.0,
                              height: 70.0,
                              widget: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewImage()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Hotspot(
                              name: "nome",
                              latitude: -10.0,
                              longitude: -60.0,
                              orgin: Offset(0.5, 0.5),
                              width: 70.0,
                              height: 70.0,
                              widget: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewImage()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Hotspot(
                              name: "nome",
                              latitude: -5.0,
                              longitude: -40.0,
                              orgin: Offset(0.5, 0.5),
                              width: 70.0,
                              height: 70.0,
                              widget: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewImage()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            Hotspot(
                              name: "nome",
                              latitude: -20.0,
                              longitude: -5.0,
                              orgin: Offset(0.5, 0.5),
                              width: 70.0,
                              height: 70.0,
                              widget: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewImage()));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                          onTap: (x, y, z) {
                            print('x $x y $y z $z');
                          }),
                    ),
                  ),
            Positioned(
              top: 98,
              left: (MediaQuery.of(context).size.width / 2) - 152,
              child: Container(
                height: 54,
                width: 304,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
              ),
            ),
            Positioned(
              top: 100,
              left: (MediaQuery.of(context).size.width / 2) - 150,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        corTemp = corRigth;
                        corRigth = corLeft;
                        corLeft = corTemp;
                        isExterior = !isExterior;
                      });
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: corLeft,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: Text(
                          'Exterior',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: corRigth),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        corTemp = corLeft;
                        corLeft = corRigth;
                        corRigth = corTemp;
                        isExterior = !isExterior;
                      });
                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: corRigth,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Text(
                            'Interior',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: corLeft),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    int tam = 0;
    final Directory directory = await getApplicationDocumentsDirectory();

    final dir = Directory('${directory.path}/frames');
    if (dir.existsSync()) {
      await dir.list(recursive: false).forEach((f) {
        tam++;
        print(f.path);
      });
    }

    for (int i = 1; i <= tam; i++) {
      File _file = File('${directory.path}/frames/$i.jpg');
      imageList.add(Image.file(_file).image);
      await precacheImage(Image.file(_file).image, context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
