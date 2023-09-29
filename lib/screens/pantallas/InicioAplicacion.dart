
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../LoginDashMenu/Login/animated_btn.dart';
import '../LoginDashMenu/Login/custom_sign_in_dialog.dart';

// inicio de la aplicacion 
class OnboardingScreen extends StatefulWidget {
   OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // se llama todo los widget como carusel el boton animado 
  bool isSignInDialogShown = false;
  late RiveAnimationController _btnAnimationColtroller;
  List images = ['assets/Backgrounds/Da.png', 'assets/Backgrounds/dona.png'];
  List<String> messages = [];
 String? randomMessage;
  @override
  void initState() {
    _btnAnimationColtroller = OneShotAnimation(
      "active",
      
      autoplay: false,
   
      
    );
    fetchMessages();
    super.initState();
    
  }
  // se cara lo mensjes aletadores para dar animos 
  Future<void> fetchMessages() async {
  final response = await http.get(Uri.parse('https://expo2023-6f28ab340676.herokuapp.com/Funciones/Mensajes'));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)); 
    final messageList = List<Map<String, dynamic>>.from(jsonResponse);
    final messages = messageList.map((map) => map['messages'] as String).toList();
    
    setState(() {
      this.messages = messages;
      randomMessage = messages.isNotEmpty ? messages[Random().nextInt(messages.length)] : '';
    });
  } else {
    print('Error al obtener los mensajes: ${response.statusCode}');
  }
}
bool isSignInDialogOpen = false; 

void _handlePress() {
  if (isSignInDialogOpen) {
    return; 
  }
  setState(() {
    isSignInDialogOpen = true;
  });

  _btnAnimationColtroller.isActive = true;
  Future.delayed(
    const Duration(milliseconds: 800),
    () {
      customSigninDialog(
        context,
        onCLosed: (_) {
          setState(() {
            isSignInDialogOpen = false;
          });
        },
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    // diseño de dicha pantalla 
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
               Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Text(
                 randomMessage ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
                      AnimatedBtn(
                        btnAnimationColtroller: _btnAnimationColtroller,
                        press: _handlePress
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
