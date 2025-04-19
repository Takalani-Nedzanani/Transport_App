import 'package:transport_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:transport_app/pages/user/home_page.dart';
import 'package:transport_app/pages/user/user_profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return navbar(context);
  }

  Container navbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 15, left: 14, right: 14),
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 130, 129, 127)),
              backgroundColor: getColor(
                  const Color.fromARGB(255, 130, 129, 127),
                  const Color.fromARGB(255, 130, 129, 127)),
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.house_outlined,
              color: Colors.black,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 130, 129, 127)),
              backgroundColor: getColor(
                  const Color.fromARGB(255, 130, 129, 127),
                  const Color.fromARGB(255, 130, 129, 127)),
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserProfilePage(),
                    ),
                  );
                },
              );
            },
            child: const Icon(
              Icons.person,
              color: Colors.black,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 130, 129, 127)),
              backgroundColor: getColor(
                  const Color.fromARGB(255, 130, 129, 127),
                  const Color.fromARGB(255, 130, 129, 127)),
            ),
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 130, 129, 127),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      title: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      content: const Text(
                        "Are You sure You Want To Log Out Of Your Account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Home(),
                              ),
                            );
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            navigatorKey.currentState!
                                .popUntil((route) => route.isFirst);
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 242, 40, 40),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            },
            child: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  WidgetStateProperty<Color> getColor(Color color, Color colorPressed) {
    getColor(Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    }

    return WidgetStateProperty.resolveWith(getColor);
  }
}
