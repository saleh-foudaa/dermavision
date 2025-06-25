
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Auth_text_field extends StatelessWidget {
  final String text;
  final String icon;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  const Auth_text_field({
    Key? key,
    required this.text,
    required this.icon,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 247, 247, 247),
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Image.asset(icon, width: 24, height: 24),
          ),
          labelText: text,
          labelStyle: GoogleFonts.poppins(fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}