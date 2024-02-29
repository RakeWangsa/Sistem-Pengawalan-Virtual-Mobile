import 'dart:io';
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
    }
  }

  Future<void> uploadImageToFirebaseStorage() async {
    if (image != null) {
      try {
        // Ambil referensi ke Firebase Storage
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now()}.jpg');

        // Upload file gambar ke Firebase Storage
        await ref.putFile(image!);

        // Dapatkan URL download gambar yang diupload
        String imageUrl = await ref.getDownloadURL();

        // Tampilkan URL download gambar di konsol
        print('Image uploaded to Firebase Storage: $imageUrl');

        // setState(() {
        //   image = null; // Reset image setelah diupload
        // });
      } catch (e) {
        print('Error uploading image to Firebase Storage: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kamera"),
      ),
      body: Container(
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

Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/tugas-akhir-d36dd.appspot.com/o/images%2F2024-02-29%2016%3A31%3A27.402699.jpg?alt=media&token=cb2a01e4-ca90-47f6-a018-d0a818e2210e',
                          fit: BoxFit.cover,
                                width: 100, // Lebar gambar
      height: 100, // Tinggi gambar
                        )
,
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
