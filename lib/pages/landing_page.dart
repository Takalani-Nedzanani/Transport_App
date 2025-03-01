import 'package:transport_app/pages/forgot_pass.dart';
import 'package:transport_app/pages/login.dart';
import 'package:transport_app/pages/register.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF0F4F3),
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(19, 14.5, 17, 79),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 127),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 12, 55),
                    child: Container(
                        child: Lottie.network(
                      'https://lottie.host/f30bd1b7-0bc6-45ea-940c-392aa9555117/0gkYsVMLtY.json',
                      animate: true,
                      width: 270,
                      //height: 250,
                    )),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    //margin: EdgeInsets.fromLTRB(0, 0, 7.9, 84),
                    child: Text(
                      'Empowering Student Finances.',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: const Color(0xFF000000),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 55,
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(1, 0, 12, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 25, 208, 83),
                        Color.fromARGB(255, 71, 37, 97),
                      ]),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'Log In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 55,
                    width: 300,
                    margin: const EdgeInsets.fromLTRB(1, 0, 12, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 25, 208, 83),
                        Color.fromARGB(255, 71, 37, 97),
                      ]),
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Registration(),
                            ),
                          );
                        },
                        child: const Center(
                          child: Text(
                            'SIGN Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: const Center(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w100,
                              color: Color.fromARGB(255, 95, 238, 164),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
