import 'dart:convert';
import 'package:dermavsion/register/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../services/api_service.dart';
import '../widgets/auth_text_field.dart';

class register extends StatefulWidget {
  static const String routeName = ('/register');

  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool _agreeToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields.')),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please agree to the terms and conditions.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ApiService.signup(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        print('Registration successful: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(responseData['message'] ??
                  'Registration successful! Please login.')),
        );
        //
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.leftToRight,
            child: const Loginscreen(),
          ),
        );
      } else {
        String errorMessage;
        try {
          final errorData = json.decode(response.body);
          errorMessage = errorData['message'] ?? 'Unknown error';
        } catch (e) {
          errorMessage = response.body;
        }
        print('Error during registration: $errorMessage');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $errorMessage')),
        );
      }
    } catch (e) {
      print('Error during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during registration: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.06,
            child: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Sign up",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0,
          ),
        ),
        toolbarHeight: 110,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 40),
            Auth_text_field(
              text: "Enter your name",
              icon: "assets/images/User-Outline.png",
              controller: nameController,
            ),
            const SizedBox(height: 5),
            Auth_text_field(
              text: "Enter your email",
              icon: "assets/images/Email.png",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 5),
            Auth_text_field(
              text: "Enter your phone",
              icon: "assets/images/call.png",
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 5),
            Auth_text_field(
              text: "Enter your password",
              icon: "assets/images/Password.png",
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 5),
            Auth_text_field(
              text: "Confirm your password",
              icon: "assets/images/Password.png",
              controller: confirmPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _agreeToTerms = newValue ?? false;
                    });
                  },
                  activeColor: const Color.fromARGB(255, 3, 190, 150),
                ),
                Expanded(
                  child: Text(
                    "I agree to the terms and conditions",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 26, 118, 110),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: const Loginscreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: const Color.fromARGB(255, 26, 118, 110),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ]),
        ),
      ),
    );
  }
}
