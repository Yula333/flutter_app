import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController _cameraController;
  late File imageFile;

  bool isFlashOn = false;
  bool isRealCamera = true;

  int direction = 0;

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    _cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(15, 20, 40, 1),
          title: const Text(
            'Вдохновение',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  size: 40,
                ))
          ],
        ),
        body: Stack(
          children: [
            SizedBox(
              height: 700,
              child: CameraPreview(_cameraController),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(15, 20, 40, 1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 30, left: 30, bottom: 70),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isRealCamera = !isRealCamera;
                            });
                            isRealCamera ? startCamera(0) : startCamera(1);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(62, 62, 75, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: isRealCamera
                                  ? const Icon(
                                      Icons.cached,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : Icon(Icons.cached),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => captureImage(context),
                          child: buttonChecked(
                              Icons.circle_outlined, Alignment.bottomCenter),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(62, 62, 75, 1),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: isFlashOn
                                  ? const Icon(
                                      Icons.flash_on,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  : Icon(Icons.flash_off),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return const SizedBox();
    }
  }

  Widget buttonChecked(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, top: 20),
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(62, 62, 75, 1),
        ),
        child: Center(
            child: Icon(
          icon,
          size: 85,
          color: Colors.white,
        )),
      ),
    );
  }

  captureImage(BuildContext context) async {
    File image = File((await _cameraController.takePicture()).path);
    if (!context.mounted) return;
    Navigator.of(context).pop(image);
  }
}
