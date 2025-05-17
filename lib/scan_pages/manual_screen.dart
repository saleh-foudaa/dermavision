
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../scan_pages/HomePage.dart';

class ManualScreen extends StatelessWidget {
  static const String routeName = '/manual';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 35),
          child: const Text(
            'Manual',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        backgroundColor: const Color(0xff1A766E),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 27, left: 15),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              weight: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 1,
      ),
      backgroundColor: const Color(0xff1A766E),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50, bottom: 70),
        child: Center(
          child: Container(
            width: 550,

            height: 570,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _QuestionItem(
                      title: 'User Manual', hasArrow: true, isHeader: true),
                  Divider(),
                  _QuestionItem(
                      title: 'How machine learning used in the application',
                      hasArrow: true),
                  Divider(),
                  _QuestionItem(title: 'What is Derma Vision', hasArrow: true),
                  Divider(),
                  _QuestionItem(
                      title: 'Who should use Derma Vision', hasArrow: true),
                  Divider(),
                  _QuestionItem(
                      title: 'Does Derma Vision replace the Doctor?',
                      hasArrow: true),
                  Divider(),
                  _QuestionItem(
                      title: 'Is my personal information safe?',
                      hasArrow: true),
                  Divider(),
                  _QuestionItem(title: 'How to Use?', hasArrow: true),
                  Divider(),
                  _QuestionItem(
                      title: 'How to delete my account',
                      textColor: Colors.red,
                      hasArrow: true),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: 1,
            selectedItemColor: const Color(0xff1A766E),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Manual'),
              BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
          Positioned(
            top: -30,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white, size: 28),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Scan Options',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              ListTile(
                                leading: const Icon(Icons.camera_alt,
                                    color: Color(0xff1A766E)),
                                title: const Text("Take a Photo"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImageFromCamera(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library,
                                    color: Color(0xff1A766E)),
                                title: const Text("Choose from Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImageFromGallery(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final String title;
  final Color? textColor;
  final bool isHeader;
  final bool hasArrow;

  const _QuestionItem({
    required this.title,
    this.textColor,
    this.isHeader = false,
    this.hasArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.black87,
              ),
            ),
          ),
          if (hasArrow)
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        ],
      ),
    );
  }
}

Future<void> _pickImageFromCamera(BuildContext context) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DermatitisLocationScreen(image: File(pickedFile.path)),
      ),
    );
  }
}

Future<void> _pickImageFromGallery(BuildContext context) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DermatitisLocationScreen(image: File(pickedFile.path)),
      ),
    );
  }
}

class DermatitisLocationScreen extends StatelessWidget {
  final File image;

  const DermatitisLocationScreen({Key? key, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Where is your dermatitis?')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please select the location of the affected skin:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RadioListTile<String>(
              title: const Text('Head'),
              value: 'Head',
              groupValue: null,
              onChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile<String>(
              title: const Text('Body'),
              value: 'Body',
              groupValue: null,
              onChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile<String>(
              title: const Text('Left Arm'),
              value: 'Left Arm',
              groupValue: null,
              onChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile<String>(
              title: const Text('Right Arm'),
              value: 'Right Arm',
              groupValue: null,
              onChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile<String>(
              title: const Text('Left Leg'),
              value: 'Left Leg',
              groupValue: null,
              onChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile<String>(
              title: const Text('Right Leg'),
              value: 'Right Leg',
              groupValue: null,
              onChanged: (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NextQuestionScreen extends StatelessWidget {
  final File image;
  final String location;

  const NextQuestionScreen(
      {Key? key, required this.image, required this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location of scan')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location selected: $location',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}