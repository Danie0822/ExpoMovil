
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'components/animated_btn.dart';
import 'components/custom_sign_in_dialog.dart';

// Let's get started
// first we need to check is text field is empty or not

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationColtroller;
   List images = ['assets/Backgrounds/fondo.png', 'assets/Backgrounds/fondo.png'];
  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 350.0,
                  aspectRatio: 0.20,
                  viewportFraction: 1,
                  autoPlay: true,
                ),
                items: images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(i);
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: images
                    .map((e) => Container(
                          width: 10.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 50,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                  "El camino hacia el éxito puede ser desafiante, pero recuerda que los desafíos te ayudan a crecer y a superarte.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
                      AnimatedBtn(
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: () {
                          _btnAnimationColtroller.isActive = true;
                          Future.delayed(
                            const Duration(milliseconds: 800),
                            () {
                              setState(() {
                                isSignInDialogShown = true;
                              });
        
                              customSigninDialog(
                                context,
                                onCLosed: (_) {
                                  setState(() {
                                    isSignInDialogShown = false;
                                  });
                                },
                              );
                            },
                          );
                        },
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
