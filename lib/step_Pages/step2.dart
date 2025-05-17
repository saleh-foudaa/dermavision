import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Step2 extends StatelessWidget {
  static String routeName = '/Step2';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
              ),
              const SizedBox(height: 40),
              Text(
                "Skin Texture:",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 35),
              Container(
                height:573.3,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffE4E7F1),
                  borderRadius: BorderRadius.circular(24),

                ),
                child: Column(
                  children: [
                    buildSkinTypeRow(
                      title: "Oily",
                      description:
                          "Skin produces excess oil, leading to shiny appearance and potentially clogged pores.",
                    ),
                    divider(),
                    buildSkinTypeRow(
                      title: "Dry",
                      description:
                          "Skin feels tight, rough, or flaky due to a lack of moisture.",
                    ),
                    divider(),
                    buildSkinTypeRow(
                      title: "Normal",
                      description:
                          "Balanced skin, not too oily or dry, with few imperfections.",
                    ),
                    divider(),
                    buildSkinTypeRow(
                      title: "Combination",
                      description:
                          "A mix of both oily and dry areas, often oily on T-zone (forehead, nose, chin) and dry on cheeks.",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSkinTypeRow(
      {required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.circle, size: 8, color: Color(0xff101623)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff101623),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 1,
    );
  }
}
