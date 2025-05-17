import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step5 extends StatefulWidget {
  static String routeName = '/step5';

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  String selectedSensitivity = '';

  final List<String> sensitivityOptions = [
    "Not Sensitive",
    "Very Sensitive",
    "Slightly Sensitive",
  ];

  void _showConfirmationDialog(String option) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 18.5),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color:Color(0xffE4E7F1),
                borderRadius: BorderRadius.circular(43.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Are you sure your skin sensitivity is "$option"?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      print('User confirmed: $option');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1A766E),
                      fixedSize: const Size(189, 46),
                    ),
                    child: const Text(
                      'Sure',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xff199A8E), fontWeight: FontWeight.w600),
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

  Widget _buildOption(String option) {
    bool isSelected = selectedSensitivity == option;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSensitivity = option;
        });
        _showConfirmationDialog(option);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: const Color(0xff1A766E),
              size: 25,),
            // const SizedBox(width: 8),
            Expanded(
              child: Text(
                option,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff101623),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
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
                      Color(0xffE4E7F1),
                      Color.fromRGBO(245, 247, 255, 0),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  Center(
                    child: Image.asset(
                      'assets/images/doc5.png',
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Container(
                    width: 350,
                    height: 318,
                    margin: const EdgeInsets.only(top: 0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffE4E7F1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "How sensitive is your skin?",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: _buildOption(sensitivityOptions[0])),
                            const SizedBox(width: 8),
                            Expanded(child: _buildOption(sensitivityOptions[1])),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: _buildOption(sensitivityOptions[2]),
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