import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step3 extends StatefulWidget {
  static String routeName = '/Step3';

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  String selectedType = '';

  final List<Map<String, String>> skinTypes = [
    {"title": "Oily", "image": "assets/images/Rectangle 960.png"},
    {"title": "Dry", "image": "assets/images/Rectangle 970.png"},
    {"title": "Normal", "image": "assets/images/Rectangle 980.png"},
    {"title": "Combination", "image": "assets/images/Rectangle 990.png"},
  ];

  void _showConfirmationDialog(
      BuildContext context, String skinType, String imagePath) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(160.0),
                      child: Image.asset(
                        imagePath,
                        height: 300.0,
                        width: 327.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.5),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xffF5F7FF),
                    borderRadius: BorderRadius.circular(43.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Are you sure your skin texture is similar to this picture?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('User confirmed: $skinType')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              maximumSize: Size.fromRadius(32),
                              backgroundColor: const Color(0xff1A766E),
                              fixedSize: Size(189, 46),
                            ),
                            child: const Text(
                              'Sure',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff)),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xff199A8E),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffF5F7FF),
                      Color.fromRGBO(245, 247, 255, 0),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                  ),
                  const SizedBox(height: 1),
                  Center(
                    child: Image.asset(
                      'assets/images/doc optation.png',
                      height: 400,
                    ),
                  ),
                  Container(
                    height: 310,
                    width: 800,
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F7FF),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "What best describes your skin texture?",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 4 / 1,
                          ),
                          itemCount: skinTypes.length,
                          itemBuilder: (context, index) {
                            final skinType = skinTypes[index];
                            bool isSelected = selectedType == skinType["title"];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedType = skinType["title"]!;
                                });
                                _showConfirmationDialog(
                                  context,
                                  skinType["title"]!,
                                  skinType["image"]!,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_off,
                                      color: const Color(0xff1A766E),
                                      size: 25,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        skinType["title"]!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff000000),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
}
