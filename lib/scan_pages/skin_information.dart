// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class SkinInformation extends StatefulWidget {
//   static const String routeName = '/skin';
//
//   @override
//   State<SkinInformation> createState() => _SkinInformationScreenState();
// }
//
// class _SkinInformationScreenState extends State<SkinInformation> {
//   TextEditingController textureController = TextEditingController();
//   TextEditingController sensitivityController = TextEditingController();
//   TextEditingController concernsController = TextEditingController();
//
//   ImageProvider profileImage = const NetworkImage(
//       "https://via.placeholder.com/150/FFFFFF/000000?Text=AI"); // حل مشكلة الصورة
//   final Color primaryColor = const Color(0xFF1A766E);
//
//   Future<void> _showImageSourceDialog() async {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               ListTile(
//                 leading: Icon(Icons.camera_alt, color: primaryColor),
//                 title: const Text('Take a photo'),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   await _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library, color: primaryColor),
//                 title: const Text('Choose from gallery'),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   await _pickImage(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         profileImage = FileImage(File(pickedFile.path));
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.white),
//             onSelected: (value) {},
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//               const PopupMenuItem<String>(
//                 value: 'option1',
//                 child: Text('Option 1'),
//               ),
//               const PopupMenuItem<String>(
//                 value: 'option2',
//                 child: Text('Option 2'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 1, bottom: 42),
//               child: Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 60,
//                       backgroundImage: profileImage,
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: _showImageSourceDialog,
//                         child: Container(
//                           padding: const EdgeInsets.all(6),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             shape: BoxShape.circle,
//                             boxShadow: const [
//                               BoxShadow(
//                                 color: Colors.black26,
//                                 blurRadius: 4,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.camera_alt,
//                             size: 20,
//                             color: primaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: 442,
//               width: 600,
//               // margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0.5),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                         labelText: 'Skin Texture',
//                         controller: textureController),
//                     const SizedBox(height: 20),
//                     _buildTextField(
//                         labelText: 'Sensitivity',
//                         controller: sensitivityController),
//                     const SizedBox(height: 20),
//                     _buildTextField(
//                         labelText: 'Skin Concerns',
//                         controller: concernsController),
//                     const SizedBox(height: 40),
//                     SizedBox(
//                       height: 45,
//                       width: 207,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pop(context, {
//                             'texture': textureController.text,
//                             'sensitivity': sensitivityController.text,
//                             'concerns': concernsController.text,
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: primaryColor,
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         child: const Text('Update',
//                             style: TextStyle(fontSize: 16)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//       bottomNavigationBar: Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           BottomNavigationBar(
//             currentIndex: 4,
//             selectedItemColor: primaryColor,
//             unselectedItemColor: Colors.grey,
//             type: BottomNavigationBarType.fixed,
//             items: const [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.home_outlined), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Mail'),
//               BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.calendar_today_outlined), label: 'Calendar'),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.person_outline), label: 'Profile'),
//             ],
//             onTap: (index) {},
//           ),
//           Positioned(
//             top: -30,
//             child: Container(
//               width: 64,
//               height: 64,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.red.withOpacity(0.5),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child:
//                   const Icon(Icons.camera_alt, color: Colors.white, size: 28),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required String labelText,
//     required TextEditingController controller,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(labelText,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.grey)),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: controller,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(24.0),
//               borderSide: const BorderSide(color: Colors.grey),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: const BorderSide(color: Color(0xFF1A766E)),
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SkinInformation extends StatefulWidget {
  static const String routeName = '/skin';

  @override
  State<SkinInformation> createState() => _SkinInformationScreenState();
}

class _SkinInformationScreenState extends State<SkinInformation> {
  TextEditingController textureController = TextEditingController();
  TextEditingController sensitivityController = TextEditingController();
  TextEditingController concernsController = TextEditingController();

  ImageProvider profileImage = const NetworkImage(
      "https://via.placeholder.com/150/FFFFFF/000000?Text=AI");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {},
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'option1',
                child: Text('Option 1'),
              ),
              const PopupMenuItem<String>(
                value: 'option2',
                child: Text('Option 2'),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100), // عشان البوتوم بار
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 32),
                        child: Center(
                          child: Stack(
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
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _buildTextField(
                                labelText: 'Skin Texture',
                                controller: textureController,
                              ),
                              const SizedBox(height: 35),
                              _buildTextField(
                                labelText: 'Sensitivity',
                                controller: sensitivityController,
                              ),
                              const SizedBox(height: 35),
                              _buildTextField(
                                labelText: 'Skin Concerns',
                                controller: concernsController,
                              ),
                              const Spacer(),
                              SizedBox(
                                height: 45,
                                width: 207,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context, {
                                      'texture': textureController.text,
                                      'sensitivity':
                                      sensitivityController.text,
                                      'concerns': concernsController.text,
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(

                                    backgroundColor: primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                  child: const Text('Update',
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Stack(
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
              BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Mail'),
              BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined), label: 'Calendar'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
            onTap: (index) {},
          ),
          Positioned(
            top: -30,
            child: Container(
              width: 64,
              height: 95,
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
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.grey)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(color: Color(0xFF1A766E)),
            ),
            contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ],
    );
  }
}
