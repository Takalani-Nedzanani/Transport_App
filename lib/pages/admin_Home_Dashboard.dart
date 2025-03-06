import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_app/pages/widgets/navbar.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Navbar(),
      appBar: AppBar(title: Text('Joyful Journeys Kids List')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((user) {
              bool isPickedUp =
                  user['pickedUp'] ?? false; // Default to false if null

              return ListTile(
                title: Text(user['first name'],
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
    );
  }

  // Function to update Firestore
  void updatePickupStatus(String userId, bool status) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'pickedUp': status});
  }
}
