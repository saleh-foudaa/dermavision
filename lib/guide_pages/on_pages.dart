import 'package:dermavsion/guide_pages/page1.dart';
import 'package:dermavsion/guide_pages/page2.dart';
import 'package:dermavsion/guide_pages/page3.dart';
import 'package:dermavsion/start/start_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnPages extends StatefulWidget {
  const OnPages({super.key});

  static const String routeName = '/onpages';

  @override
  State<OnPages> createState() => _OnPagesState();
}

class _OnPagesState extends State<OnPages> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Page1(),
              Page2(),
              Page3(),
            ]),
        Padding(
          padding: const EdgeInsets.only(top: Checkbox.width),
          child: Container(
            alignment: Alignment(-0.6, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      "Skip",
                      style:
                          GoogleFonts.inter(fontSize: 15, color: Colors.grey),
                    )),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: SlideEffect(
                      spacing: 4.0,
                      radius: 4.0,
                      dotWidth: 14.0,
                      dotHeight: 7.0,
                      strokeWidth: 1.5,
                      dotColor: Color.fromARGB(255, 170, 255, 237),
                      activeDotColor: Color(0xff1A766E)),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.bottomToTop,
                                  child: Startscreen()));
                        },
                        child: Container(
                          width: 56.17,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Color(0xff1A766E),
                              // color: const Color.fromARGB(30, 80, 250, 90),
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 56.17,
                                  height: 56,
                                  child: Image.asset(
                                    "assets/images/Arrow Right.png",
                                    height: 24,
                                    width: 24.07,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40)),
                                ),
                              ],
                            ),
                          ),
                        ))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 56.17,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Color(0xff1A766E),
                              borderRadius: BorderRadius.circular(40)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/Arrow Right.png",
                                  height: 24,
                                  width: 24.07,
                                ),
                                // ),
                              ],
                            ),
                          ),
                        )),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
