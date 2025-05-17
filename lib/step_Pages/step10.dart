import 'package:dermavsion/scan_pages/HomePage.dart';
import 'package:dermavsion/step_Pages/on_steps.dart';
import 'package:dermavsion/step_Pages/step1.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step10 extends StatefulWidget {
  static String routeName = '/step10';

  @override
  State<Step10> createState() => _Step10State();
}

class _Step10State extends State<Step10> {
  String selectedConcern = '';

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
                color: const Color(0xffE4E7F1),
                borderRadius: BorderRadius.circular(43.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Finally, are you sure about all the information you’ve entered?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Homepage.routeName);
                      ///////////////
                      // Home//
                      /////////////////
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1A766E),
                      fixedSize: const Size(189, 46),
                    ),
                    child: const Text(
                      'Yes, confirm',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, OnSteps.routeName);
                    },
                    child: const Text(
                      'No, let me review',
                      style: TextStyle(
                          color: Color(0xff1A766E),
                          fontWeight: FontWeight.w600),
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
    bool isSelected = selectedConcern == option;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedConcern = option;
        });
        _showConfirmationDialog(option);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: const Color(0xff1A766E),
            size: 24,
          ),
          const SizedBox(width: 8),
          Text(
            option,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xff101623),
            ),
          ),
        ],
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
                      'assets/images/image 15.png',
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: 343,
                    height: 318,
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xffE4E7F1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "What are your main skin concerns?",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _buildOption("Acne")),
                            SizedBox(width: 16),
                            Expanded(child: _buildOption("Wrinkles")),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _buildOption("Pigmentation")),
                            SizedBox(width: 16),
                            Expanded(child: _buildOption("Dullness")),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _buildOption("Redness")),
                            SizedBox(width: 16),
                            Expanded(child: _buildOption("Dryness")),
                          ],
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
