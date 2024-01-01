import 'package:flutter/material.dart';
import 'package:pengawalan_virtual/main.dart';
import 'package:pengawalan_virtual/petugas/dokumentasi.dart';
import 'package:pengawalan_virtual/petugas/laporanPengawalan.dart';
import 'package:pengawalan_virtual/petugas/pengawalan.dart';
import 'package:pengawalan_virtual/petugas/riwayatPengawalan.dart';

void main() => runApp(SuratPerintah());

class SuratPerintah extends StatelessWidget {
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
                          width: 2.0, // Atur lebar border sesuai keinginan
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/img/prabowo.jpg'),
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
                        MaterialPageRoute(builder: (context) => SuratPerintah()),
                      );
              },
            ),
            Divider(), 
            ListTile(
              tileColor: Colors.grey[300],
              title: Row(
                children: [
                  Icon(Icons.local_shipping),
                  SizedBox(width: 10),
                  Text('Pengawalan'),
                ],
              ),
              onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp2()),
                      );
              },
            ),
            Divider(), 
            ListTile(
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
                        MaterialPageRoute(builder: (context) => DokumentasiPetugas()),
                      );
              },
            ),
            Divider(),
                        ListTile(
              title: Row(
                children: [
                  Icon(Icons.file_copy), 
                  SizedBox(width: 10),
                  Text('Laporan Pengawalan'),
                ],
              ),
              onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LaporanPengawalan()),
                      );
              },
            ),
            Divider(),
                        ListTile(
              title: Row(
                children: [
                  Icon(Icons.history), 
                  SizedBox(width: 10),
                  Text('Riwayat Pengawalan'),
                ],
              ),
              onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RiwayatPengawalan()),
                      );
              },
            ),
            Divider(), 
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
                margin: EdgeInsets.only(bottom: 35.0),
                child: Center(
                  child: Text(
                    "Surat Perintah Pengawalan",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
Container(
  height: 400, // Ganti nilai sesuai dengan kebutuhan max height
  child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 215, 215, 215)),
            columns: [
              DataColumn(label: Text('No', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('No Pengajuan', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('No PPK', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Nama Perusahaan', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Jenis', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Tujuan', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            dataRowMinHeight: 30,
            dividerThickness: 1.0,
rows: [
                                DataRow(
                                  cells: [
                                    DataCell(Text('1')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.assignment)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('2')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.assignment)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('3')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.assignment)),
                                  ],
                                ),
                              ],
          ),
        ),
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

  DataRow buildDataRow(List<String> data) {
    return DataRow(
      cells: data.map((item) => DataCell(Text(item))).toList(),
    );
  }
}