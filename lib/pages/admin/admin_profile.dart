import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:transport_app/services/auth_service.dart';

import 'package:email_validator/email_validator.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController schoolController;
  late TextEditingController parentsNameController;
  late TextEditingController passwordController;

  bool _isEditing = false;
  bool _isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    ageController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    schoolController = TextEditingController();
    parentsNameController = TextEditingController();
    passwordController = TextEditingController();

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists) {
        setState(() {
          userData = doc.data();
          nameController.text = userData?['first name'] ?? '';
          emailController.text = userData?['username'] ?? '';
          ageController.text = userData?['age'] ?? '';
          phoneController.text = userData?['phone'] ?? '';
          addressController.text = userData?['address'] ?? '';
          schoolController.text = userData?['school'] ?? '';
          parentsNameController.text = userData?['parents name'] ?? '';
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    phoneController.dispose();
    addressController.dispose();
    schoolController.dispose();
    parentsNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Update email if changed
        if (emailController.text.trim() != user.email) {
          // ignore: deprecated_member_use
          await user.updateEmail(emailController.text.trim());
        }

        // Update password if provided
        if (passwordController.text.trim().isNotEmpty) {
          await user.updatePassword(passwordController.text.trim());
        }

        // Update Firestore document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'first name': nameController.text.trim(),
          'username': emailController.text.trim(),
          'age': ageController.text.trim(),
          'phone': phoneController.text.trim(),
          'address': addressController.text.trim(),
          'school': schoolController.text.trim(),
          'parents name': parentsNameController.text.trim(),
        });

        Utils.showSnackBar("Profile updated successfully");
        setState(() => _isEditing = false);
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message ?? "An error occurred");
    } finally {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        enabled: _isEditing,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 237, 196, 10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 237, 196, 10)),
          ),
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
                if (!_isEditing) {
                  // Reset to original values if editing is cancelled
                  _loadUserData();
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromARGB(255, 237, 196, 10),
                child: Text(
                  nameController.text.isNotEmpty
                      ? nameController.text[0].toUpperCase()
                      : 'U',
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              _buildEditableField(
                label: 'Child\'s Name',
                controller: nameController,
                icon: Icons.child_care,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <= 2) {
                    return "Enter a valid name";
                  }
                  return null;
                },
              ),
              _buildEditableField(
                label: 'Email',
                controller: emailController,
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !EmailValidator.validate(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              _buildEditableField(
                label: 'Parent\'s Name',
                controller: parentsNameController,
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length <= 2) {
                    return "Enter a valid name";
                  }
                  return null;
                },
              ),
              _buildEditableField(
                label: 'Phone Number',
                controller: phoneController,
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid phone number";
                  }
                  return null;
                },
              ),
              _buildEditableField(
                label: 'Age',
                controller: ageController,
                icon: Icons.cake,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid age";
                  }
                  return null;
                },
              ),
              _buildEditableField(
                label: 'Address',
                controller: addressController,
                icon: Icons.home,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid address";
                  }
                  return null;
                },
              ),
              _buildEditableField(
                label: 'School',
                controller: schoolController,
                icon: Icons.school,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid school name";
                  }
                  return null;
                },
              ),
              if (_isEditing)
                _buildEditableField(
                  label: 'New Password (leave blank to keep current)',
                  controller: passwordController,
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              if (_isEditing)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 237, 196, 10),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: _updateProfile,
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
