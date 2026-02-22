import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:quranapps_getx/app/routes/app_pages.dart';

import '../controllers/intro_controller.dart';

class IntroView extends GetView<IntroController> {
  const IntroView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        //widget introduction screen
        pages: [
          PageViewModel(
            // halaman pertama
            title: "Welcome to quran Apps",
            body: "bacalah quranmu dengan mudah",
            image: Container(
              height: Get.height * 0.3,

              child: Center(
                child: Lottie.asset(
                  "assets/lotties/satu.json",

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
        showSkipButton: true, //akliin tombol skip
        skip: Text("Skip"), //widget untuk skip
        next: Text("Next"), //widget untuk next
        done: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.w700),
        ), //widget untuk done
        onDone: () {
          // On Done button pressed
          Get.offAllNamed(Routes.HOME);
        },

        dotsDecorator: DotsDecorator(
          //untuk edit yg titik titik (dots)
          size: Size.square(10.0),
          activeSize: Size(20.0, 10.0),
          activeColor: Theme.of(context).colorScheme.secondary,
          color: Colors.black26,
          spacing: EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
