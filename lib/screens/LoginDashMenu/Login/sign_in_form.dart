import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:sistema_expo/utils/rive_utils.dart';
import 'package:http/http.dart' as http;
import '../../../Dashboard.dart';
import '../../../ModelsDB/Personas.dart';
import '../../../ModelsDB/Providers/Personas.dart';
import '../../../entry_point.dart';
import '../../pantallas/AlertaAdmin.dart';

// esto es formario de dialog
class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// aniamciones de confeti
  bool isShowLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;
  String correo = "";
  String claveCredenciales = "";
  void signIn(BuildContext context) {
    setState(() {
      isShowLoading = true;
      isShowConfetti = true;
    });
    Future.delayed(
      Duration(seconds: 1),
      () async {
        if (_formKey.currentState!.validate()) {
          // se valida si algo vacio
          _formKey.currentState!.save();
          String password = claveCredenciales;
          // incrip de la contraseñas
          String encryptedPassword = encryptPassword(password);
          String baseUrl =
              'https://expo2023-6f28ab340676.herokuapp.com/Credenciales/user';
          String url = Uri.parse(baseUrl).replace(queryParameters: {
            'correo': correo,
            'claveCredenciales': encryptedPassword,
          }).toString();
// manda llamar el url
          http.Response response = await http.get(Uri.parse(url));
          // si encuentra algun resgistro da un  200 code de la api
          if (response.statusCode == 200) {
            dynamic responseData = json.decode(response.body);
            if (responseData != null) {
              Person person = Person.fromJson(responseData);
              var personas = Provider.of<Personas>(context, listen: false);
              personas.person = person;
              check.fire();
              Future.delayed(
                Duration(seconds: 2),
                () {
                  setState(() {
                    isShowLoading = false;
                  });

                  confetti.fire();

                  if (person.idTipoPersona == 2) {
                    Future.delayed(
                      Duration(seconds: 1),
                      () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntryPoint(),
                          ),
                          (route) => false,
                        );
                       
                      },
                    );
                  } else if (person.idTipoPersona == 1) {
                    Future.delayed(
                      Duration(seconds: 1),
                      () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardDocenteScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    );
                  } else {
                    Future.delayed(
                      Duration(seconds: 1),
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlertaAdmin(),
                          ),
                        );
                      },
                    );
                  }
                },
              );
            } else {
              error.fire();
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  setState(() {
                    isShowLoading = false;
                  });
                },
              );
            }
          } else {
            error.fire();
            Future.delayed(
              const Duration(seconds: 2),
              () {
                setState(() {
                  isShowLoading = false;
                });
              },
            );
          }
        } else {
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
            },
          );
        }
      },
    );
  }

  String encryptPassword(String password) {
    var bytes = utf8.encode(password);
    var sha256Password = sha256.convert(bytes);

    return sha256Password.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // diseño de la pantalla
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (email) {
                      correo = email!;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Image.asset("assets/icons/email.png")),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Contraseña",
                  style: TextStyle(color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    onSaved: (password) {
                      claveCredenciales = password!;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Image.asset("assets/icons/pass.png")),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      signIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[1600],
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    icon: const Icon(
                      CupertinoIcons.arrow_right,
                      color: Colors.white,
                    ),
                    label: const Text("Inicia sesión"),
                  ),
                ),
              ],
            ),
          ),
          isShowLoading
              ? CustomPositioned(
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/check.riv",
                    onInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard);
                      // animacion de error
                      check = controller.findSMI("Check") as SMITrigger;
                      error = controller.findSMI("Error") as SMITrigger;
                      reset = controller.findSMI("Reset") as SMITrigger;
                    },
                  ),
                )
              : const SizedBox(),
          isShowConfetti
              ? CustomPositioned(
                  child: Transform.scale(
                    scale: 7,
                    child: RiveAnimation.asset(
                      "assets/RiveAssets/confetti.riv",
                      onInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveController(artboard);

                        confetti = controller.findSMI("Trigger explosion")
                            as SMITrigger;
                      },
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});

  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          Spacer(),
          SizedBox(
            height: size,
            width: size,
            child: child,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
