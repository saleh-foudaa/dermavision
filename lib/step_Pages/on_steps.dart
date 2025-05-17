import 'package:dermavsion/step_Pages/step1.dart';
import 'package:dermavsion/step_Pages/step10.dart';
import 'package:dermavsion/step_Pages/step2.dart';
import 'package:dermavsion/step_Pages/step3.dart';
import 'package:dermavsion/step_Pages/step4.dart';
import 'package:dermavsion/step_Pages/step5.dart';
import 'package:dermavsion/step_Pages/step7.dart';
import 'package:dermavsion/step_Pages/step8.dart';
import 'package:dermavsion/step_Pages/step9.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../start/start_screen.dart';
import 'step6.dart';
import 'step9.dart';

class OnSteps extends StatefulWidget {
  const OnSteps({super.key});

  static const String routeName = '/onsteps';

  @override
  State<OnSteps> createState() => _OnStepsState();
}

class _OnStepsState extends State<OnSteps> {
  final PageController _controller = PageController();
  bool onLastStep = false;

  final List<Widget> steps = [
    Step1(),
    Step2(),
    Step3(),
    Step4(),
    Step5(),
    Step6(),
    Step7(),
    Step8(),
    Step9(),
    Step10(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastStep = (index == steps.length - 1);
              });
            },
            children: steps,
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip button
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(steps.length - 1);
                  },
                  child: Text(
                    "Skip",
                    style: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                  ),
                ),
                // Page Indicator
                SmoothPageIndicator(
                  controller: _controller,
                  count: steps.length,
                  effect: SlideEffect(
                    spacing: 4.0,
                    radius: 4.0,
                    dotWidth: 14.0,
                    dotHeight: 7.0,
                    strokeWidth: 1.5,
                    dotColor: Color.fromARGB(255, 170, 255, 237),
                    activeDotColor: Color(0xff1A766E),
                  ),
                ),
                // Next or Done Button
                GestureDetector(
                  onTap: () {
                    if (onLastStep) {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: Startscreen(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Container(
                    width: 56.17,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(0xff1A766E),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/Arrow Right.png",
                        height: 24,
                        width: 24.07,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
