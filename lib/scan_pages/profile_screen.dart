import 'package:dermavsion/scan_pages/account_information.dart';
import 'package:dermavsion/scan_pages/skin_information.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'log_out.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController =
      TextEditingController(text: "Saleh Fouda");
  int uploadedPhotosCount = 0;
  int withoutProblemsCount = 0;
  int diagnosedProblemsCount = 0;
  ImageProvider profileImage = const NetworkImage(
      "https://via.placeholder.com/150/FFC107/000000?Text=YS");
  final Color primaryColor = const Color(0xFF1A766E);

  Future<void> _showImageSourceDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt, color: primaryColor),
                title: const Text('Take a photo'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library, color: primaryColor),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        profileImage = FileImage(File(pickedFile.path));
      });
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutConfirmationDialog(
          onLogoutPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            // هنا هتحط الكود الفعلي لتسجيل الخروج
            print('Logging out...');
            // ممكن تعمل Navigator.pushReplacement عشان تروح لصفحة تسجيل الدخول
          },
          onCancelPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            print('Logout cancelled');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 60, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: profileImage,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _showImageSourceDialog,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 20,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.edit, color: Colors.white),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _InfoItem(
                          icon: Icons.camera_alt_outlined,
                          label: "Photos uploaded",
                          count: uploadedPhotosCount),
                      _InfoItem(
                          icon: Icons.check_circle_outline,
                          label: "Without Problems",
                          count: withoutProblemsCount),
                      _InfoItem(
                          icon: Icons.cancel_outlined,
                          label: "Diagnosed Problems",
                          count: diagnosedProblemsCount),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _OptionItem(
                              icon: Icons.person_outline,
                              title: 'Account Information',
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AccountInformation.routeName,
                                    arguments: {
                                      'name': nameController.text,
                                      'phone': '1234567890',
                                      'email': 'example@email.com',
                                      'dob': '01/01/2000',
                                    });
                              }),
                          _divider(),
                          _OptionItem(
                              icon: Icons.medical_services_outlined,
                              title: 'Skin Information',
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SkinInformation.routeName);
                              }),
                          _divider(),
                          _OptionItem(
                              icon: Icons.payment_outlined,
                              title: 'Payment Method',
                              onTap: () {}),
                          _divider(),
                          _OptionItem(
                              icon: Icons.help_outline,
                              title: 'FAQs',
                              onTap: () {}),
                          _divider(),
                          _OptionItem(
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              _showLogoutDialog(context);
                            },
                            isLogout: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              BottomNavigationBar(
                currentIndex: 4,
                selectedItemColor: primaryColor,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_outlined), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.mail), label: 'Mail'),
                  BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today_outlined),
                      label: 'Calendar'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline), label: 'Profile'),
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
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.camera_alt,
                      color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const SizedBox.shrink(),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.grey.shade300);
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;

  const _InfoItem(
      {required this.icon, required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 5),
        Text('$count photo${count > 1 ? 's' : ''}',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
            textAlign: TextAlign.center),
      ],
    );
  }
}

class _OptionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  const _OptionItem(
      {required this.icon,
      required this.title,
      required this.onTap,
      this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    final color = isLogout ? Colors.red : Colors.black87;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: isLogout ? Colors.red : Colors.grey.shade600),
            const SizedBox(width: 15),
            Text(title, style: TextStyle(fontSize: 16, color: color)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
