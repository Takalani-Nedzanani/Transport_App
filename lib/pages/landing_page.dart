// ignore_for_file: avoid_unnecessary_containers

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
          color: Color.fromARGB(255, 255, 255, 255),
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
                        child: Lottie.asset(
                      'assets/animation/transport.json',
                      animate: true,
                      width: 300,
                      height: 300,
                    )),
                  ),
                  
                  Container(
                    //margin: EdgeInsets.fromLTRB(0, 0, 7.9, 84),
                    child: Text(
                      'Joyful Journeys',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: const Color.fromARGB(255, 0, 0, 0),
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
                        Color.fromARGB(255, 237, 196, 10),
                        Color.fromARGB(255, 215, 214, 209),
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
                        Color.fromARGB(255, 215, 214, 209),
                        Color.fromARGB(255, 237, 196, 10),
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
                      child: Container(
                        child: const Center(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 237, 196, 10),
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
