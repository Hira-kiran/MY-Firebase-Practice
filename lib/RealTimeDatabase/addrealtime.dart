// ignore_for_file: file_names

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_practice/firebase/login.dart';

class AddRealTime extends StatefulWidget {
  const AddRealTime({super.key});

  @override
  State<AddRealTime> createState() => _AddRealTimeState();
}

class _AddRealTimeState extends State<AddRealTime> {
  final databaseRef = FirebaseDatabase.instance.ref("Form");
  final searchController = TextEditingController();
//for update data
  final updateController = TextEditingController();
  Future<void> updateDailogue(String id, String title) async {
    updateController.text = title;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Data"),
            content: TextFormField(
              controller: updateController,
              decoration: const InputDecoration(hintText: "Edit"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  databaseRef.child(id).update({
                    'email': updateController.text.toLowerCase()
                  }).then((value) {
                    ToastClass().toastMsg('Post Updated');
                  }).onError((error, stackTrace) {
                    ToastClass().toastMsg(error.toString());
                  });
                },
                child: const Text("Update"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add realTime")),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                    hintText: 'Search', border: OutlineInputBorder()),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: databaseRef,
                defaultChild: const Text("Loading..."),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child('email').value.toString();
                  if (searchController.text.isEmpty) {
                    return ListTile(
                      title: Container(
                        height: 100,
                        width: 350,
                        color: Colors.grey,
                        child: Column(
                          children: [
                            Text(snapshot.child("email").value.toString()),
                            Text(snapshot.child('id').value.toString())
                          ],
                        ),
                      ),
                      trailing: PopupMenuButton(
                          child: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                    child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    updateDailogue(
                                        title,
                                        snapshot
                                            .child('email')
                                            .value
                                            .toString());
                                  },
                                  title: const Text("Edit"),
                                  trailing: const Icon(Icons.edit),
                                )),
                                PopupMenuItem(
                                    child: ListTile(
                                  onTap: () {
                                    databaseRef
                                        .child(snapshot
                                            .child('id')
                                            .value
                                            .toString())
                                        .remove();
                                    Navigator.pop(context);
                                  },
                                  title: const Text("delete"),
                                  trailing: const Icon(Icons.delete),
                                )),
                              ]),
                    );
                  } else if (title.toLowerCase().contains(
                      searchController.text.toLowerCase().toString())) {
                    return ListTile(
                      title: Text(snapshot
                          .child('post')
                          .value
                          .toString()), //if u get post
                      subtitle: Text(
                          snapshot.child('id').value.toString()), //if u get id
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ));
  }
}

// ********************* Fatch data from realtime database********************
 /*  Expanded(
              child: FirebaseAnimatedList(
                query: databaseRef,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    title: Container(
                      height: 150,
                      width: 350,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          Text(snapshot.child("email").value.toString()),
                          Text(snapshot.child("phone").value.toString()),
                          Text(snapshot.child("gender").value.toString()),
                          Text(snapshot.child("id").value.toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

 */