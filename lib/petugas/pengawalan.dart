import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LatLng;
import 'package:pengawalan_virtual/main.dart';
import 'package:pengawalan_virtual/petugas/dokumentasi.dart';
import 'package:pengawalan_virtual/petugas/laporanPengawalan.dart';
import 'package:pengawalan_virtual/petugas/riwayatPengawalan.dart';
import 'package:pengawalan_virtual/petugas/suratPerintah.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage2(),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePageState2 createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {

var db = FirebaseFirestore.instance;


  List<String> points = [
    "(poin berwarna hijau) E/E/01.0/20230123/002464 - IKI 1",
    "(poin berwarna hijau) E/E/01.0/20230123/002465 - IKI 2",
    "(poin berwarna merah) E/E/01.0/20230123/002466 - IKI 3",
  ];
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
body: FlutterMap(
  options: MapOptions(
    minZoom: 5.0,
    initialCenter: LatLng.LatLng(-6.124487407691205, 106.65877266300464), // Koordinat Indonesia
  ),
  children: [
    TileLayer(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      subdomains: ['a', 'b', 'c'],
    ),
    MarkerLayer(
      markers: [
        Marker(point: LatLng.LatLng(-6.160164936412775, 106.76858326927852), child: Icon(
                Icons.local_shipping,
                color: Color.fromARGB(255, 17, 44, 244),
                size: 25.0,
              ),
            ),
        Marker(point: LatLng.LatLng(-6.225276324675301, 106.84672900320778), child: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 25.0,
              ),
            ),
        Marker(point: LatLng.LatLng(-6.129826216110446, 106.83630957201721), child: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 25.0,
              ),
            ),
      ]
      ),
    Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 15.0),
Container(
  child: Center(
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.5), // Ubah nilai alpha untuk mengurangi opacity
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Text(
        "Pengawalan",
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    ),
  ),
),





          Spacer(),
Container(
  height: 200, // Ganti nilai sesuai dengan kebutuhan max height
  child: LayoutBuilder(
    builder: (context, constraints) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(128),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('Pengawalan').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator(); // Menampilkan loading indicator jika data sedang diambil
    } else {
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
return SingleChildScrollView(
  scrollDirection: Axis.vertical,
  child: ConstrainedBox(
    constraints: BoxConstraints(minHeight: constraints.maxHeight),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(128),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(31, 237, 237, 237)),
            columns: [
              DataColumn(label: Text('No Pengajuan', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Tujuan', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            dataRowMinHeight: 30,
            dividerThickness: 1.0,
            rows: snapshot.data != null
                ? snapshot.data!.docs.map<DataRow>((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    return DataRow(
                      cells: [
                        DataCell(Text(data['No Pengajuan'] ?? '')),
                        DataCell(Text(data['Tujuan'] ?? '')),
                      ],
                    );
                  }).toList()
                : [],
          ),
        ),
      ),
    ),
  ),
);

      }
    }
  },
),

            ),
          ),
        ),
      );
    },
  ),
),



        ],
      ),
    ),
  ],
),

    );
  }
}