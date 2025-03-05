import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transport_app/services/auth_service.dart';
import 'package:transport_app/main.dart';
import 'package:transport_app/pages/login.dart';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController schoolController;
  late TextEditingController parentsNameController;
  List<String> docIDs = [];

  get prefixIcon => null;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    ageController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    schoolController = TextEditingController();
    parentsNameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    passwordController.dispose();
    ageController.dispose();
    phoneController.dispose();
    addressController.dispose();
    schoolController.dispose();
    parentsNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 237, 196, 10),
              Color.fromARGB(255, 215, 214, 209),
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Create Your Account',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: usernameController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      prefixIcon ?? Icon(Icons.email_outlined),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 82, 81, 81)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Email",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !EmailValidator.validate(value)) {
                                    return "Enter a valid Email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      prefixIcon ?? Icon(Icons.child_care),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 76, 76, 76)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Child's Name",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 2) {
                                    return "Enter a valid name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: parentsNameController,
                                decoration: InputDecoration(
                                  prefixIcon: prefixIcon ?? Icon(Icons.person),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 76, 76, 76)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Parent's Name",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 2) {
                                    return "Enter a valid name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: phoneController,
                                decoration: InputDecoration(
                                  prefixIcon: prefixIcon ?? Icon(Icons.phone),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 76, 76, 76)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Phone Number",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 2) {
                                    return "Enter a valid name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: ageController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      prefixIcon ?? Icon(Icons.child_care),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 76, 76, 76)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Age of the child",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 2) {
                                    return "Enter a valid name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: addressController,
                                decoration: InputDecoration(
                                  prefixIcon: prefixIcon ??
                                      Icon(Icons.add_location_rounded),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 76, 76, 76)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Address",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 2) {
                                    return "Enter a valid name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: schoolController,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      prefixIcon ?? Icon(Icons.school_outlined),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 76, 76, 76)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "School Name",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 2) {
                                    return "Enter a valid name";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  prefixIcon:
                                      prefixIcon ?? Icon(Icons.password),
                                  fillColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 46, 46, 46)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: "Password",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 237, 196, 10)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 6) {
                                    return "*Enter min. 6 characters";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 120.0),
                              child: GestureDetector(
                                onTap: signUp,
                                child: Container(
                                  height: 55,
                                  width: 300,
                                  //padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromARGB(255, 237, 196, 10),
                                      Color.fromARGB(255, 215, 214, 209),
                                    ]),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "REGISTER",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const Login(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 100,
                                      padding: const EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: const LinearGradient(colors: [
                                          Color.fromARGB(255, 215, 214, 209),
                                          Color.fromARGB(255, 237, 196, 10),
                                        ]),
                                      ),
                                      child: const Text(
                                        "SIGN IN",
                                        style: TextStyle(

                                            ///done login page
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      // ignore: unused_local_variable

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      addUserDetails(
        nameController.text.trim(),
        usernameController.text.trim(),
        ageController.text.trim(),
        phoneController.text.trim(),
        addressController.text.trim(),
        schoolController.text.trim(),
        parentsNameController.text.trim(),
        passwordController.text.trim(),
        "user",
      );

      Utils.showSnackBar("Successfully Registered");
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.pop();
  }

//store information in the database
  Future addUserDetails(
    String firstname,
    String username,
    String age,
    String phone,
    String address,
    String school,
    String parentsName,
    String password,
    String role,
  ) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'first name': firstname,
      'username': username,
      'age': age,
      'phone': phone,
      'address': address,
      'school': school,
      'parents name': parentsName,
      'password': password,
      'role': role, //admin or user
    });
  }
}
