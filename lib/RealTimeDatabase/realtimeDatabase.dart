// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_practice/firebase/login.dart';

import '../componentss/components.dart';
import 'addRealtime.dart';

class RealTimeDatabase extends StatefulWidget {
  const RealTimeDatabase({super.key});

  @override
  State<RealTimeDatabase> createState() => _RealTimeDatabaseState();
}

class _RealTimeDatabaseState extends State<RealTimeDatabase> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref("Form");
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RealTime Database")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "Email", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  controller: genderController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: "Gender", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Phone#", border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                loading = true;
              });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              databaseRef.child(id).set({
                'gender': genderController.text.toString(),
                "email": emailController.text.toString(),
                'phone': phoneController.text.toString(),
                'id': id
              }).then((value) {
                ToastClass().toastMsg("Data is added successfully");
                setState(() {
                  loading = false;
                });
              }).onError((error, stackTrace) {
                ToastClass().toastMsg(error.toString());
                setState(() {
                  loading = false;
                });
              });
            },
            child: Components(
              loading: loading,
              text: "Added",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddRealTime()));
                },
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 22),
                )),
          ),
        ],
      ),
    );
  }
}
