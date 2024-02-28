import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(Kamera(cameras: cameras));
}

class Kamera extends StatelessWidget {
  final List<CameraDescription> cameras;
  Kamera({super.key, required this.cameras});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dokumentasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(cameras: cameras,),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }
@override
void dispose() {
  _controller.dispose(); // Hentikan pemutaran kamera sebelum widget dihapus
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumentasi'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture();
            // Simpan gambar ke Firebase Storage
            await _uploadImageToFirebaseStorage(File(path));
            // Tampilkan snackbar jika berhasil
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gambar berhasil disimpan')),
            );
          } catch (e) {
            // Tampilkan snackbar jika gagal
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal menyimpan gambar: $e')),
            );
          }
        },
      ),
    );
  }

Future<void> _uploadImageToFirebaseStorage(File imageFile) async {
  try {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final String fileName = '${DateTime.now()}.png';
    final String filePath = '$tempPath/$fileName';

    // Salin file gambar ke direktori sementara
    await imageFile.copy(filePath);

    final firebaseStorageRef = FirebaseStorage.instance.ref().child('images/$fileName');
    await firebaseStorageRef.putFile(File(filePath));

    // Hapus file yang disalin ke direktori sementara
    await File(filePath).delete();

  } catch (e) {
    print('Gagal mengunggah gambar ke Firebase Storage: $e');
    throw e;
  }
}

}