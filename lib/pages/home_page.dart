import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:transport_app/pages/widgets/appdrawer.dart';
import 'package:transport_app/pages/widgets/navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final ref = FirebaseDatabase.instance.ref("Communiques");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: const Navbar(),

      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text("Welcome To Joyful Journeys"),
        backgroundColor: const Color.fromARGB(255, 108, 245, 231),
        elevation: 0,
      ),

      // drawer: const AppDrawer(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          bool isPickedUp = snapshot.data!['pickedUp'] ?? false;

          return Center(
            child: Text(
              isPickedUp
                  ? 'You have been picked up!'
                  : 'You are not picked up yet!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          );
        },
      ),
    ));
  }
}
