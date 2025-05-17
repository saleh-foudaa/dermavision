import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Step4 extends StatelessWidget {
  static String routeName = '/Step4';

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
                "Sensitivity :",
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 35),
              Container(
                height: 573.3,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffE4E7F1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    buildSkinTypeRow(
                      title: "Not Sensitive:",
                      description:
                          "Skin shows minimal or no reactivity to external irritants, maintaining a strong barrier function and low inflammation response.",
                    ),
                    divider(),
                    buildSkinTypeRow(
                      title: "Slightly Sensitive:",
                      description:
                          "Skin occasionally reacts to irritants or environmental factors, with mild redness or discomfort, indicating a moderately compromised barrier.",
                    ),
                    divider(),
                    buildSkinTypeRow(
                      title: "Very Sensitive:",
                      description:
                          "Skin frequently reacts to irritants, allergens, or environmental triggers, exhibiting pronounced redness, itching, or irritation due to a weakened barrier and heightened immune response",
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
                    fontSize: 15,
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
