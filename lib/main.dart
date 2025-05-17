import 'package:dermavsion/scan_pages/HomePage.dart';
import 'package:dermavsion/guide_pages/on_pages.dart';
import 'package:dermavsion/register/login_screen.dart';
import 'package:dermavsion/register/register.dart';
import 'package:dermavsion/scan_pages/account_information.dart';
import 'package:dermavsion/scan_pages/history_screen.dart';
import 'package:dermavsion/scan_pages/log_out.dart';
import 'package:dermavsion/scan_pages/manual_screen.dart';
import 'package:dermavsion/scan_pages/profile_screen.dart';
import 'package:dermavsion/scan_pages/skin_information.dart';

import 'package:dermavsion/splash/splash_screen.dart';
import 'package:dermavsion/start/start_screen.dart';
import 'package:dermavsion/step_Pages/on_steps.dart';

import 'package:dermavsion/step_Pages/step1.dart';
import 'package:dermavsion/step_Pages/step10.dart';
import 'package:dermavsion/step_Pages/step2.dart';
import 'package:dermavsion/step_Pages/step3.dart';
import 'package:dermavsion/step_Pages/step4.dart';
import 'package:dermavsion/step_Pages/step6.dart';
import 'package:dermavsion/step_Pages/step7.dart';
import 'package:dermavsion/step_Pages/step8.dart';
import 'package:dermavsion/step_Pages/step9.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'guide_pages/page1.dart';
import 'guide_pages/page2.dart';
import 'guide_pages/page3.dart';
import 'step_Pages/step5.dart';
import 'step_Pages/step9.dart';

void main() {
  runApp(ResponsiveSizer(builder: (context, orientation, screenType) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Splashscreen.routeName,
      routes: {
        Splashscreen.routeName: (_) => Splashscreen(),
        OnSteps.routeName: (_) => const OnSteps(),
        Page1.routeName: (_) => Page1(),
        Page2.routeName: (_) => Page2(),
        Page3.routeName: (_) => Page3(),
        Startscreen.routeName: (_) => Startscreen(),
        Loginscreen.routeName: (_) => Loginscreen(),
        register.routeName: (_) => register(),
        OnPages.routeName: (_) => const OnPages(),
        Step1.routeName: (_) => Step1(),
        Step2.routeName: (_) => Step2(),
        Step3.routeName: (_) => Step3(),
        Step4.routeName: (_) => Step4(),
        Step5.routeName: (_) => Step5(),
        Step6.routeName: (_) => Step6(),
        Step7.routeName: (_) => Step7(),
        Step8.routeName: (_) => Step8(),
        Step9.routeName: (_) => Step9(),
        Step10.routeName: (_) => Step10(),
        Homepage.routeName: (_) => Homepage(),
        ManualScreen.routeName: (_) => ManualScreen(),
        HistoryScreen.routeName: (_) => HistoryScreen(
              history: [],
            ),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        AccountInformation.routeName: (_) => AccountInformation(),
        SkinInformation.routeName: (_) => SkinInformation(),
        LogoutConfirmationDialog.routeName: (_) => LogoutConfirmationDialog(
              onLogoutPressed: () {},
              onCancelPressed: () {},
            )
      },
    );
  }));
}
