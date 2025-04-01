import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_app/pages/widgets/navbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? _mapController;
  LatLng? adminLocation;

  @override
  void initState() {
    super.initState();
    _fetchAdminLocation();
  }

  // Fetch Admin's location from Firestore
  void _fetchAdminLocation() {
    FirebaseFirestore.instance
        .collection('admin_location')
        .doc('location')
        .snapshots()
        .listen((doc) {
      if (doc.exists) {
        setState(() {
          adminLocation = LatLng(doc['latitude'], doc['longitude']);
        });

        if (_mapController != null) {
          _mapController!.animateCamera(
            CameraUpdate.newLatLng(adminLocation!),
          );
        }
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
            "Welcome to Joyful Journeys",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color.fromARGB(255, 130, 129, 127),
          elevation: 2,
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
                      color: isPickedUp
                          ? Colors.green // Green when picked up
                          : Colors.red, // Red when not picked up
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: adminLocation == null
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: adminLocation!,
                        zoom: 15,
                      ),
                      markers: <Marker>{
                        Marker(
                          markerId: MarkerId("admin_location"),
                          position: adminLocation!,
                          infoWindow: InfoWindow(title: "Admin's Location"),
                        ),
                      },
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                    ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
