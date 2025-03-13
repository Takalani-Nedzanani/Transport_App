import 'package:transport_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transport_app/pages/admin_Home_Dashboard.dart';
import 'package:transport_app/pages/admin_profile.dart';

import 'package:transport_app/pages/home_page.dart';

class AdminNavbar extends StatefulWidget {
  const AdminNavbar({super.key});

  @override
  State<AdminNavbar> createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  @override
  Widget build(BuildContext context) {
    return navbar(context);
  }

  Container navbar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 15, left: 14, right: 14),
      color: const Color.fromARGB(255, 249, 233, 156),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 251, 210, 5)),
              backgroundColor: getColor(const Color.fromARGB(255, 246, 201, 3),
                  const Color.fromARGB(255, 240, 211, 64)),
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AdminDashboard(),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.house_outlined),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 251, 210, 5)),
              backgroundColor: getColor(const Color.fromARGB(255, 246, 201, 3),
                  const Color.fromARGB(255, 240, 211, 64)),
            ),
            onPressed: () {
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AdminProfile(),
                    ),
                  );
                },
              );
            },
            child: const Icon(Icons.person),
          ),
          ElevatedButton(
            style: ButtonStyle(
              foregroundColor: getColor(
                  Colors.black, const Color.fromARGB(255, 251, 210, 5)),
              backgroundColor: getColor(const Color.fromARGB(255, 246, 201, 3),
                  const Color.fromARGB(255, 240, 211, 64)),
            ),
            onPressed: () {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 238, 184, 8),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      title: const Center(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      content: const Text(
                        "Are You sure You Want To Log Out Of Your Account?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
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
                              color: Color.fromARGB(255, 167, 39, 39),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              });
            },
            child: const Icon(Icons.logout_outlined),
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
