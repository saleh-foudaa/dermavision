import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class auth_social_logins extends StatelessWidget {
  final String text;
  final String logo;

  auth_social_logins({required this.logo, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.06,
                child: Image.asset(
                  logo,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: const Color.fromARGB(255, 44, 44, 44),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 10),
          ]),
    );
  }
}
