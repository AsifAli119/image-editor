import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/crop_controller.dart';
import '../src/crop_image.dart';
import '../src/crop_rotation.dart';
import 'home_screen.dart';

List<String> frameAssets = [
  "assets/images/user_image_frame_1.png",
  "assets/images/user_image_frame_2.png",
  "assets/images/user_image_frame_3.png",
  "assets/images/user_image_frame_4.png"
];
int selectedFrameIndex = 0;
bool isFrame = false;
class MyEditingScreen extends StatefulWidget {
  final String title;
  final String imagePath; // Add imagePath parameter

  const MyEditingScreen({
    Key? key,
    required this.title,
    required this.imagePath, // Initialize imagePath
  }) : super(key: key);

  @override
  State<MyEditingScreen> createState() => _MyEditingScreenState();
}

class _MyEditingScreenState extends State<MyEditingScreen> {
  final controller = CropController(
    aspectRatio: null,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  bool _isFlippedHorizontally = false;
  bool _isFlippedVertically = false;

  void _toggleHorizontalFlip() {
    setState(() {
      _isFlippedHorizontally = !_isFlippedHorizontally;
    });
  }

  void _toggleVerticalFlip() {
    setState(() {
      _isFlippedVertically = !_isFlippedVertically;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_left_outlined),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
            },
          ),
          actions: [
            _buildButtons(),
          ],
        ),
        body: Center(
          child: _isFlippedHorizontally
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi), // Horizontal flip
                  child: CropImage(
                    controller: controller,
                    image: Image.file(File(widget.imagePath)),
                    paddingSize: 25.0,
                    alwaysMove: true,
                  ))
              : _isFlippedVertically
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationX(pi), // Horizontal flip
                      child: CropImage(
                        controller: controller,
                        image: Image.file(File(widget.imagePath)),
                        paddingSize: 25.0,
                        alwaysMove: true,
                      ),
                    )
                  : CropImage(
                      controller: controller,
                      image: Image.file(
                          File(widget.imagePath)), // Load the picked image
                      paddingSize: 25.0,
                      alwaysMove: true,
                    ),
        ),
      );
  Widget _buildButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.flip),
            onPressed: _toggleHorizontalFlip, // Toggle horizontal flip
          ),
          IconButton(
            icon: const Icon(Icons.flip),
            onPressed: _toggleVerticalFlip, // Toggle vertical flip
          ),
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_ccw_outlined),
            onPressed: _rotateLeft,
          ),
          IconButton(
            icon: const Icon(Icons.rotate_90_degrees_cw_outlined),
            onPressed: _rotateRight,
          ),
          TextButton(
            onPressed: _finished,
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );

  Future<void> _rotateLeft() async => controller.rotateLeft();

  Future<void> _rotateRight() async => controller.rotateRight();

  Future<void> _finished() async {
    final image = await controller.croppedImage();
    // ignore: use_build_context_synchronously
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(6.0),
          titlePadding: const EdgeInsets.all(8.0),
          title: Text(
            'Uploaded Image',
            textAlign: TextAlign.center,
            style: GoogleFonts.aboreto(fontWeight: FontWeight.bold),
          ),
          children: [
            const SizedBox(height: 5),
            Stack(
              children: [
                image,
                isFrame ? Positioned.fill(
                  child: Image.asset(
                    frameAssets[selectedFrameIndex],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ): SizedBox.shrink(),
              ],
            ),
            Container(
              height: 40,
              child: Row(
                children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 4),
                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.grey),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: Text("Original", style: GoogleFonts.abel(
                     fontWeight: FontWeight.bold,
                     fontSize: 22,
                   ),
                   ),
                 ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isFrame = true;
                          selectedFrameIndex = 2;
                        });
                        isFrame = false;
                      },
                      child: Container(
                        width: 45,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(frameAssets[0]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isFrame = true;
                          selectedFrameIndex = 2;
                        });
                        isFrame = false;
                      },
                      child: Container(
                        width: 45,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(frameAssets[1]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isFrame = true;
                          selectedFrameIndex = 2;
                        });
                        isFrame = false;
                      },
                      child: Container(
                        width: 45,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(frameAssets[2]),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          isFrame = true;
                          selectedFrameIndex = 3;
                        });
                        isFrame = false;
                      },
                      child: Container(
                        width: 45,
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.asset(frameAssets[3]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: TextButton(
                onPressed: ()async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
        },
                child: const Text(
                  'Use this image',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
