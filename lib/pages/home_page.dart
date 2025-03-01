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
          title: const Text("Daily Community Updates"),
          backgroundColor: const Color.fromARGB(255, 108, 245, 231),
          elevation: 0,
        ),
        // drawer: const AppDrawer(),
        body: const Column(
          children: [
            /* Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return CommuneCard(
                    title: Text(
                      snapshot.child("Message").value.toString(),
                    ),
                    subtitle: const Text(""),
                    onTap: () {},
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
