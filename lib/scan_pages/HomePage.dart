import 'package:dermavsion/scan_pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

import 'history_manager.dart';
import 'history_screen.dart';
import 'manual_screen.dart';

class Homepage extends StatefulWidget {
  static const String routeName = '/homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<File> _scannedImages = [];
  final HistoryManager _historyManager =
      HistoryManager(); // Instance من HistoryManager

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _scannedImages.add(File(pickedFile.path));
      });
      _navigateToDermatitisLocationScreen(File(pickedFile.path));
    }
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _scannedImages.add(File(pickedFile.path));
      });
      _navigateToDermatitisLocationScreen(File(pickedFile.path));
    }
  }

  void _navigateToDermatitisLocationScreen(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DermatitisLocationScreen(
            image: imageFile,
            historyManager: _historyManager), // مرر الـ historyManager
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    File? lastScannedImage =
        _scannedImages.isNotEmpty ? _scannedImages.last : null;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: Text(
                      "Find your perfect\nskincare solution.",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Icon(Icons.notifications_none),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Search doctor, drugs, articles...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color(0xffFBFBFB),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Color(0xffffffff)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const _QuickIcon(icon: Icons.bar_chart, label: "Progress"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ManualScreen()),
                      );
                    },
                    child: const _QuickIcon(
                        icon: Icons.menu_book, label: "Manual"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryScreen(
                                history: _historyManager.getHistory())),
                      );
                    },
                    child:
                        const _QuickIcon(icon: Icons.history, label: "History"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffB1CDD1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Early protection for\nyour skin!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0xff1A766E)),
                            ),
                            child: Text(
                              "Learn more",
                              style: TextStyle(color: Color(0xffffffff)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset("assets/images/doc home.png", height: 80),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Your Last Scanning",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              AllScansScreen(scannedImages: _scannedImages),
                        ),
                      );
                    },
                    child: const Text("See all",
                        style: TextStyle(color: Color(0xff1A766E))),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffDADADA)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                        onTap: () {
                          if (lastScannedImage != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ScanDetailScreen(
                                    image: lastScannedImage,
                                    scanDateTime: DateTime.now()),
                              ),
                            );
                          }
                        },
                        child: lastScannedImage != null
                            ? Image.file(
                                lastScannedImage,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Center(child: Text("No scans yet")),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: lastScannedImage != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ScanDetailScreen(
                                      image: lastScannedImage,
                                      scanDateTime: DateTime.now()),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff1A766E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text("Scan Details"),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        if (lastScannedImage != null) {
                          _navigateToDermatitisLocationScreen(lastScannedImage);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'No scan available. Please scan first.')),
                          );
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: Color(0xff1A766E), size: 16),
                          SizedBox(width: 4),
                          Text(
                            "Identify Location",
                            style: TextStyle(
                                color: Color(0xff1A766E), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      lastScannedImage != null ? "Today" : "",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: 0,
            selectedItemColor: const Color(0xff1A766E),
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Mail'),
              BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
            onTap: (index) {
              if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              } else {
                print('Pressed item at index $index');
              }
            },
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
                                  _pickImageFromCamera();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library,
                                    color: Color(0xff1A766E)),
                                title: const Text("Choose from Gallery"),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImageFromGallery();
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
    );
  }
}

class _QuickIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: const Color(0xffE4E7F1),
          child: Icon(icon, color: const Color(0xff1A766E)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ScanDetailScreen extends StatelessWidget {
  final File image;
  final bool isAsset;
  final DateTime scanDateTime;

  const ScanDetailScreen({
    Key? key,
    required this.image,
    this.isAsset = false,
    required this.scanDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color(0xff1A766E),
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff1A766E)),
        elevation: 1,
      ),
      backgroundColor: const Color(0xffF8F8F8),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isAsset ? Image.asset(image.path) : Image.file(image),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scan Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xff333333),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined,
                          color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Date: ${DateFormat('yyyy-MM-dd').format(scanDateTime)}',
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xff555555)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined,
                          color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Time: ${DateFormat('HH:mm:ss').format(scanDateTime)}',
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xff555555)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllScansScreen extends StatelessWidget {
  final List<File> scannedImages;

  const AllScansScreen({Key? key, required this.scannedImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Scans')),
      body: scannedImages.isEmpty
          ? const Center(child: Text("No scans available."))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              padding: const EdgeInsets.all(8),
              itemCount: scannedImages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ScanDetailScreen(
                            image: scannedImages[index],
                            scanDateTime: DateTime.now()),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      scannedImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class DermatitisLocationScreen extends StatelessWidget {
  final File image;
  final HistoryManager historyManager;

  const DermatitisLocationScreen(
      {Key? key, required this.image, required this.historyManager})
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
            RadioListTile(
              title: const Text('Head'),
              value: 'Head',
              groupValue: null,
              onChanged: (value) {
                historyManager.addScan(value!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile(
              title: const Text('Body'),
              value: 'Body',
              groupValue: null,
              onChanged: (value) {
                historyManager.addScan(value!); // تسجيل اختيار "Body"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile(
              title: const Text('Left Arm'),
              value: 'Left Arm',
              groupValue: null,
              onChanged: (value) {
                historyManager.addScan(value!); // تسجيل اختيار "Left Arm"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile(
              title: const Text('Right Arm'),
              value: 'Right Arm',
              groupValue: null,
              onChanged: (value) {
                historyManager.addScan(value!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile(
              title: const Text('Left Leg'),
              value: 'Left Leg',
              groupValue: null,
              onChanged: (value) {
                historyManager.addScan(value!);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NextQuestionScreen(image: image, location: value!),
                  ),
                );
              },
            ),
            RadioListTile(
              title: const Text('Right Leg'),
              value: 'Right Leg',
              groupValue: null,
              onChanged: (value) {
                historyManager.addScan(value!);
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
