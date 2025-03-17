/*import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: const Text(
          "Welcome To Joyful Journeys",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 245, 237, 30),
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
}*/


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transport_app/pages/widgets/navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late GoogleMapController mapController;
  LatLng? adminLocation;

  @override
  void initState() {
    super.initState();
    _listenToAdminLocation();
  }

  // Listen to Admin Location in Firestore
  void _listenToAdminLocation() {
    FirebaseFirestore.instance
        .collection('admin')
        .doc('location')
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        setState(() {
          adminLocation = LatLng(doc['latitude'], doc['longitude']);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const Navbar(),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text(
            "Welcome To Joyful Journeys",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 245, 237, 30),
          elevation: 0,
        ),
        body: Column(
          children: [
            // Picked Up Status
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                bool isPickedUp = snapshot.data!['pickedUp'] ?? false;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    isPickedUp
                        ? 'You have been picked up!'
                        : 'You are not picked up yet!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                );
              },
            ),

            // Map Showing Admin's Location
            Expanded(
              child: adminLocation == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: adminLocation!,
                        zoom: 15.0,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId("admin"),
                          position: adminLocation!,
                          infoWindow: InfoWindow(title: "Admin Location"),
                        ),
                      },
                      onMapCreated: (controller) {
                        mapController = controller;
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

