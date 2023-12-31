import 'package:flutter/material.dart';
import 'package:pengawalan_virtual/pengguna_jasa/pengiriman.dart';
import 'package:pengawalan_virtual/petugas/pengawalan.dart';

import 'package:pengawalan_virtual/register.dart';





// void main() => runApp(AplikasiSaya());

void main(){
  runApp(
    MaterialApp(
      title: "Test aja",
      home : Login(),
    )
  );
}

class Login extends StatelessWidget {
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp2()),
                      );
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
                        MaterialPageRoute(builder: (context) => Register()),
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
            ],
          ),
        ),
      ),
    );
  }
}


