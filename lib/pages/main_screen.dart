import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/camera_screen.dart';
import 'package:flutter_app/pages/promocode_widget.dart';
import 'package:share_plus/share_plus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Image _image = Image.asset('assets/photo_placeholder.jpg',
      width: 300, height: 300, fit: BoxFit.cover);
  late XFile photoToSend;
  bool promocode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Творчество',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(42, 50, 94, 10),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                        )),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Stack(
                children: [
                  Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: _image,
                  ),
                  if (promocode) const PromocodeWidget(),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: MaterialButton(
                  onPressed: () async {
                    changeImage();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Colors.grey[200],
                  child: const Text(
                    'Поменять картинку',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Дополнительная информация',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                          'Промокод можно передвинуть куда пожелаете и поделиться своим творением.'),
                    ],
                  )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black,
                ),
                child: ElevatedButton.icon(
                    onPressed: () async {
                      share(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    label: const Text(
                      'Поделиться творением',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changeImage() async {
    final result = await Navigator.push<File>(
        context, MaterialPageRoute(builder: (context) => CameraScreen()));

    if (result != null) {
      _image = Image.file(result, width: 300, height: 300, fit: BoxFit.cover);
      promocode = true;
      setState(() {});
    }
  }

  void share(BuildContext context) async {}
}
