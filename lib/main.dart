import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pengawalan_virtual/firebase_options.dart';
import 'package:pengawalan_virtual/pengguna_jasa/pengiriman.dart';
import 'package:pengawalan_virtual/petugas/pengawalan.dart';

import 'package:pengawalan_virtual/register.dart';
import 'package:pengawalan_virtual/test_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';






// void main() => runApp(AplikasiSaya());

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    MaterialApp(
      title: "Test aja",
      home : Login(),
    )
  );
}

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Login({Key? key}) : super(key: key);


Future<void> signInWithEmailAndPassword(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    
    // Ambil data pengguna dari Firestore
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(uid).get();

    // Periksa role pengguna
    String role = userSnapshot['Role'];

    // Arahkan pengguna ke halaman yang sesuai berdasarkan role
    if (role == 'Petugas') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp2()),
      );
    } else if (role == 'Pengguna Jasa') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      // Jika role tidak sesuai, tindakan tambahan sesuai kebutuhan aplikasi Anda
    }
  } catch (e) {
    // Jika terjadi error, tampilkan pesan error
    print('Error signing in: $e');
  }
}




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                margin: EdgeInsets.only(bottom: 35.0),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 44, 175)), // Warna default
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue), // Warna saat fokus
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  labelText: "Email",
                  hintText: "Masukkan Email",
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 44, 175)), // Warna default
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.blue), // Warna saat fokus
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  labelText: "Password",
                  hintText: "Masukkan Password",
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                margin: EdgeInsets.only(top: 20.0), // Sesuaikan dengan spasi yang diinginkan
                child: ElevatedButton(
onPressed: () {
  signInWithEmailAndPassword(context, emailController.text, passwordController.text);
},

  child: Text("Login"),
),


              ),
              
              SizedBox(height: 16.0),
              // Teks dan tombol register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum ada akun? Silahkan"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    child: Text("Register"),
                  ),
                ],
              ),
              Spacer(),
              // Image.asset di ujung bawah
              Image.asset(
                'assets/img/LogoBKIPM.png',
                height: 50,
              ),
              SizedBox(height: 5.0),
              Center(
                child: Container(
                  child: Text(
                    "Created By Rake Wangsa & Auliya Putri",
                    style: TextStyle(
                      color: Color.fromARGB(255, 65, 96, 163),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


