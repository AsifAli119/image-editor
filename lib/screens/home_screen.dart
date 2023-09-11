import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import '../src/crop_controller.dart';
import 'package:editor/screens/editing_screen.dart';
import 'package:modern_form_line_awesome_icons/modern_form_line_awesome_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = CropController(
    aspectRatio: null,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  Future<void> _pickImage() async {
    final XFile? selectedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      _selectedImage = selectedImage;
    });

    // You can navigate to the editing screen or perform other actions here
    if (_selectedImage != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyEditingScreen(imagePath: _selectedImage!.path, title: '',),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            SystemNavigator.pop();
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
          "Add Image/Icon",
          style: GoogleFonts.acme(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 500),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Upload Image",
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: _pickImage,
                        child: Text(
                          "Choose from Device",
                          style: GoogleFonts.abel(),
                        )
                    ),
                    SizedBox(height: 45,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

