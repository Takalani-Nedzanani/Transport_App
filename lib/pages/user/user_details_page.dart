/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsPage extends StatelessWidget {
  final String userId;

  const UserDetailsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Color.fromARGB(255, 130, 129, 127),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User not found."));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['first name']} ",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Parents Name: ${userData['parents name']}"),
                SizedBox(height: 10),
                Text("Address: ${userData['address']}"),
                SizedBox(height: 10),
                Text("School: ${userData['school']}"),
                SizedBox(height: 10),
                Text("Age: ${userData['age']}"),
                SizedBox(height: 10),
                Text("Email: ${userData['username']}"),
                SizedBox(height: 10),
                Text("Phone: ${userData['phone']}"),
                SizedBox(height: 10),
                Text(
                    "Picked Up: ${userData['pickedUp'] == true ? 'Yes' : 'No'}"),
              ],
            ),
          );
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsPage extends StatelessWidget {
  final String userId;

  const UserDetailsPage({super.key, required this.userId});

  void _deleteUser(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted successfully')),
      );

      // Go back to previous screen
      Navigator.pop(context);
    } catch (e) {
      print("Error deleting user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: const Color.fromARGB(255, 130, 129, 127),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("User not found."));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${userData['first name']}",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 10),
                Text("Parents Name: ${userData['parents name']}"),
                SizedBox(height: 10),
                Text("Address: ${userData['address']}"),
                SizedBox(height: 10),
                Text("School: ${userData['school']}"),
                SizedBox(height: 10),
                Text("Age: ${userData['age']}"),
                SizedBox(height: 10),
                Text("Email: ${userData['username']}"),
                SizedBox(height: 10),
                Text("Phone: ${userData['phone']}"),
                SizedBox(height: 10),
                Text(
                    "Picked Up: ${userData['pickedUp'] == true ? 'Yes' : 'No'}"),
                const Spacer(),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmDelete(context),
                    icon: const Icon(Icons.delete),
                    label: const Text("Delete User"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx); // close dialog
              _deleteUser(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
