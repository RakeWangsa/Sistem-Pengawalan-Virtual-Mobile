import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pengawalan_virtual/main.dart';
import 'package:pengawalan_virtual/pengguna_jasa/pengiriman.dart';
import 'package:pengawalan_virtual/pengguna_jasa/dashboard.dart';
import 'package:pengawalan_virtual/pengguna_jasa/dokumentasi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

void main() {
  runApp(TesKamera());
}

class TesKamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamera',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  String? imageUrl;
  
  
  @override
  void initState() {
    super.initState();
    fetchImageUrl();
  }

  Future<void> fetchImageUrl() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Dokumentasi')
          .where('No Pengajuan', isEqualTo: 'E/E/01.0/20230123/002466')
          .get();

      if (snapshot.docs.isNotEmpty) {
        imageUrl = snapshot.docs.first['gambar'];
        setState(() {});
      }
    } catch (e) {
      print('Error fetching image URL: $e');
    }
  }

Future<void> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? imagePicked =
      await picker.pickImage(source: ImageSource.camera);
  if (imagePicked != null) {
    setState(() {
      image = File(imagePicked.path);
    });
    // Upload gambar ke Firebase Storage
    await uploadImageToFirebaseStorage();

    // Tampilkan URL gambar di Firestore
    FirebaseFirestore.instance
        .collection('Dokumentasi')
        .where('No Pengajuan', isEqualTo: 'E/E/01.0/20230123/002466')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          imageUrl = doc['gambar'];
        });
      });
    });
  }
}


Future<void> uploadImageToFirebaseStorage() async {
  if (image != null) {
    try {
      // Ambil referensi ke Firebase Storage
      firebase_storage.Reference ref = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().toString()}.jpg');

      // Upload file gambar ke Firebase Storage
      await ref.putFile(image!);

      // Dapatkan URL download gambar yang diupload
      String imageUrl = await ref.getDownloadURL();

      // Periksa apakah dokumen dengan 'No Pengajuan' yang sama sudah ada
      var snapshot = await FirebaseFirestore.instance
          .collection('Dokumentasi')
          .where('No Pengajuan', isEqualTo: 'E/E/01.0/20230123/002466')
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Dokumen sudah ada, maka update kolom 'gambar' saja
        var docId = snapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('Dokumentasi')
            .doc(docId)
            .update({'gambar': imageUrl});
      } else {
        // Dokumen belum ada, maka tambahkan dokumen baru
        await FirebaseFirestore.instance
            .collection('Dokumentasi')
            .add({
          'No Pengajuan': 'E/E/01.0/20230123/002466',
          'gambar': imageUrl,
        });
      }

      // Tampilkan URL download gambar di konsol
      print('Image uploaded to Firebase Storage: $imageUrl');
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 38, 52, 255),
                Color.fromARGB(255, 0, 150, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: Text(
              "Pengawalan Virtual",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 38, 52, 255),
                          Color.fromARGB(255, 0, 150, 255),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width:
                                    2.0, // Atur lebar border sesuai keinginan
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/img/prabowo.jpg'),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Prabowo Subianto',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.dashboard),
                        SizedBox(width: 10),
                        Text('Dashboard'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.local_shipping),
                        SizedBox(width: 10),
                        Text('Pengiriman'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    tileColor: Colors.grey[300],
                    title: Row(
                      children: [
                        Icon(Icons.camera_alt),
                        SizedBox(width: 10),
                        Text('Dokumentasi'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dokumentasi()),
                      );
                    },
                  ),
                  Divider(), // Add a divider for visual separation
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.logout), // Add a logout icon
                        SizedBox(width: 10),
                        Text('Logout'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Image.asset di paling bawah
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/img/LogoBKIPM.png',
                height: 50,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 191, 229, 255),
              Color.fromARGB(255, 89, 186, 255),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Center(
                child: Text(
                  "Kamera",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      await getImage();
                    },
                    child: Text('Open Camera'),
                  ),
                  SizedBox(height: 20.0),
                  image != null ? Image.file(image!) : Container(),
                  Image.network(
imageUrl ?? '',
  fit: BoxFit.cover,
  width:300,
  height:300 // atau sesuaikan dengan kebutuhan Anda
),


                  Text(
                    'Foto Tampak Atas',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
