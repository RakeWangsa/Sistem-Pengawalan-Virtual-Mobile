import 'package:flutter/material.dart';

void main() => runApp(LaporanPengawalan());

class LaporanPengawalan extends StatelessWidget {
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
                margin: EdgeInsets.only(bottom: 5.0),
                child: Center(
                  child: Text(
                    "Laporan Pengawalan",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow("Nama Perusahaan", "PT Bumi Pangan Utama"),
                    buildInfoRow("Tanggal", "01/12/2023"),
                    buildInfoRow("No Pengajuan", "E/E/01.0/20230123/002464"),
                    buildInfoRow("Jenis", "Daging Rajungan Pasteu"),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
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
                  labelText: "Tujuan",
                  hintText: "Masukkan Tujuan",
                ),
              ),
              SizedBox(height: 16.0),
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
                  labelText: "Waktu",
                  hintText: "Masukkan Waktu",
                ),
              ),
              SizedBox(height: 16.0),
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
                  labelText: "Keterangan",
                  hintText: "Masukkan Keterangan",
                ),
              ),
              SizedBox(height: 16.0),
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
                  labelText: "Petugas",
                  hintText: "Masukkan Petugas",
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildInfoRow(String label, String value) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(":"),
        SizedBox(width: 10), // Tambahkan spasi antara ":" dan value
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}
