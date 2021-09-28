import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_360/main.dart';

List<CameraDescription> cameras;

class OverlayCamera extends StatefulWidget {
  @override
  _OverlayCameraState createState() => _OverlayCameraState();
}

class _OverlayCameraState extends State<OverlayCamera> {
  CameraController controller;
  String imagePath;
  bool _toggleCamera = false;
  bool isLoding = true;
  double sizeWith = 0;
  bool showOverlay = true;
  bool isStopped = false;
  bool alterOverlay = true;
  int index = 0;
  Timer _timer;
  List<bool> imagesOverlays = [
    true,
    false,
  ];
  bool isShow1 = true;
  List<String> images = [
    'assets/overlay.png',
    'assets/overlay2.png',
    'assets/overlay3.png',
    "",
    "",
    ""
  ];

  _cancel(Timer timer) {
    timer.cancel();
  }

  _periodic() {
    final duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      _timer = timer;
      if (isStopped) {
        timer.cancel();
      }

      setState(() {
        alterOverlay = !alterOverlay;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) async {
      await controller.lockCaptureOrientation(DeviceOrientation.landscapeLeft);

      if (!mounted) {
        return;
      }

      _periodic();
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    sizeWith = MediaQuery.of(context).size.width * 0.7;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized && sizeWith != 0) {
      return Container();
    }
    return Scaffold(
        body: Container(
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: CameraPreview(controller)),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 120.0,
              height: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Color.fromRGBO(00, 00, 00, 0.95),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        onTap: () {
                          takePicture();
                        },
                        child: Image.asset(
                          'assets/botton.png',
                          width: 72.0,
                          height: 72.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: showOverlay,
            child: Visibility(
              visible: alterOverlay,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Image.asset(
                    images[index],
                    width: sizeWith,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: 120.0,
              height: double.infinity,
              padding: EdgeInsets.only(right: 10, top: 35),
              color: Color.fromRGBO(00, 00, 00, 0.9),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: index == 0 ? Colors.grey : Colors.black,
                            height: 55,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.green,
                                ),
                                Text(
                                  '01',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: index == 1 ? Colors.grey : Colors.black,
                            height: 55,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                Text(
                                  '02',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 2;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: index == 2 ? Colors.grey : Colors.black,
                            height: 55,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                Text(
                                  '03',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 3;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: index == 3 ? Colors.grey : Colors.black,
                            height: 55,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                Text(
                                  '04',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 4;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: index == 4 ? Colors.grey : Colors.black,
                            height: 55,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                Text(
                                  '05',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 5;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            color: index == 5 ? Colors.grey : Colors.black,
                            height: 55,
                            width: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: Colors.red,
                                ),
                                Text(
                                  '06',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void onCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) await controller.dispose();
    controller = CameraController(cameraDescription, ResolutionPreset.medium);

    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
        showMessage('Camera Error: ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      showException(e);
    }

    if (mounted) setState(() {});
  }

  String timestamp() => new DateTime.now().millisecondsSinceEpoch.toString();

  void _captureImage() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          showMessage('Picture saved to $filePath');
          setCameraResult();
        }
      }
    });
  }

  void setCameraResult() {
    Navigator.pop(context, imagePath);
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized && controller.value.isTakingPicture) {
      showMessage('Error: select a camera first.');
    }

    try {
      var foto = await controller.takePicture();
      inspect(foto);
    } on CameraException catch (e) {
      showException(e);
    }
    return '';
  }

  void showException(CameraException e) {
    showMessage('Error: ${e.code}\n${e.description}');
  }

  void showMessage(String message) {
    print(message);
  }
}
