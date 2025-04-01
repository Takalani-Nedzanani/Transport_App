// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_app/pages/widgets/admin_navbar.dart';
import 'package:geolocator/geolocator.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  Position? adminPosition;

  @override
  void initState() {
    super.initState();
    _enableLocation();
  }

  // Enable location tracking and update Firestore
  Future<void> _enableLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      adminPosition = position;
    });

    print('Admin Location: ${position.latitude}, ${position.longitude}');

    // Update Firestore with admin's location
    FirebaseFirestore.instance
        .collection('admin_location')
        .doc('location')
        .set({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AdminNavbar(),
      appBar: AppBar(title: Text('Joyful Journeys Kids List')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _enableLocation,
            child: Text("Share Location"),
          ),
          Expanded(
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: snapshot.data!.docs.map((user) {
                    bool isPickedUp = user['pickedUp'] ?? false;

                    return ListTile(
                      title: Text(user['first name'],
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      subtitle: Text(user['school']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            value: true,
                            groupValue: isPickedUp,
                            onChanged: (value) {
                              updatePickupStatus(user.id, true);
                            },
                          ),
                          Text('Picked Up'),
                          Radio(
                            value: false,
                            groupValue: isPickedUp,
                            onChanged: (value) {
                              updatePickupStatus(user.id, false);
                            },
                          ),
                          Text('Not Picked Up'),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void updatePickupStatus(String userId, bool status) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'pickedUp': status});
  }
}
