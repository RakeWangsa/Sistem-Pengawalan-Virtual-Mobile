import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestFirestore extends StatefulWidget {
  const TestFirestore({super.key});

  @override
  State<TestFirestore> createState() => _TestFirestoreState();
}

class _TestFirestoreState extends State<TestFirestore> {
  var db = FirebaseFirestore.instance;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bornController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bornController.dispose();
    super.dispose();
  }

  void addUser() {
    final user = <String, dynamic>{
      "first": _firstNameController.text,
      "last": _lastNameController.text,
      "born": int.parse(_bornController.text)
    };
    db.collection("users").add(user).then((DocumentReference doc) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User added"))));

    _firstNameController.clear();
    _lastNameController.clear();
    _bornController.clear();
    Navigator.pop(context);
  }

  void updateUser(DocumentSnapshot<Object?> doc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
  final Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;

  if (userData != null) {
    _firstNameController.text = userData['first'];
    _lastNameController.text = userData['last'];
    _bornController.text = userData['born'].toString();
  }
        return AlertDialog(
          title: Text("Update User"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _bornController,
                decoration: InputDecoration(labelText: 'Year Born'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                final user = <String, dynamic>{
                  "first": _firstNameController.text,
                  "last": _lastNameController.text,
                  "born": int.parse(_bornController.text)
                };
                doc.reference.update(user).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data updated")))
                );
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("ERROR"),
            );
          }
          // olah data
          var _data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: _data.length,
            itemBuilder: (context, index) {
              return ListTile(
                onLongPress: () {
                  // auto delete ketika di klik lama
                  _data[index].reference.delete().then((value) =>
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Data removed"))));
                },
                onTap: () {
                  // update data ketika di klik
                  updateUser(_data[index]);
                },
                subtitle: Text(_data[index].data()['born'].toString()),
                title: Text(
                    _data[index].data()['first'] + " " + _data[index].data()['last']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Add User"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: 'First Name'),
                    ),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: 'Last Name'),
                    ),
                    TextField(
                      controller: _bornController,
                      decoration: InputDecoration(labelText: 'Year Born'),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      addUser();
                    },
                    child: Text('Add'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
