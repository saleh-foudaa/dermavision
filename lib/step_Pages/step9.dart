import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Step9 extends StatelessWidget {
  static String routeName = '/step9';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 55,
              left: 87,
              right: 50,
              child: SizedBox(
                width: 124,
                height: 32,
                child: Text(
                  'Skin Concerns :',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 117,
              left: 17,
              right: 17,
              child: Container(
                width: 343,
                height: 600,
                decoration: BoxDecoration(
                  color: const Color(0xffE4E7F1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 1),
                    ConcernOption(
                      title: "Redness:",
                      description:
                          "Persistent redness, irritation, or visible blood vessels.",
                      imagePath: "assets/images/image 13.png",
                    ),
                    ConcernOption(
                      title: "Dryness:",
                      description:
                          "Skin feels tight, flaky, or lacks moisture.",
                      imagePath: "assets/images/image 14.png",
                    ),
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

class ConcernOption extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const ConcernOption({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),

          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 7,),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imagePath,
              width: 303,
              height: 137,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
