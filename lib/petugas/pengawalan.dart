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
int noTable = 1;
int noTruck = 1;
int noIKI = 1;

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
    StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('Lokasi').orderBy('Nama').snapshots(), 
  builder: (context, snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }

    if (!snapshot.hasData) {
      return CircularProgressIndicator(); // Menampilkan loading indicator jika data belum tersedia
    }

    return MarkerLayer(
      markers: snapshot.data!.docs.map<Marker>((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        IconData iconData;
        Color iconColor;

    if (data['Jenis'] == 'truck') {
      iconData = Icons.local_shipping;
      iconColor = Color.fromARGB(255, 17, 44, 244);
    } else if (data['Jenis'] == 'IKI') {
      iconData = Icons.location_pin;
      iconColor = Color.fromARGB(255, 244, 17, 17);
    }else {
      // Default icon jika tidak ada nilai yang cocok
      iconData = Icons.error;
      iconColor = Color.fromARGB(255, 17, 44, 244);
    }

        return Marker(
          point: LatLng.LatLng(
    double.parse(data['LatLong'].split(',')[0]), // Latitude
    double.parse(data['LatLong'].split(',')[1]), // Longitude
  ),
          child: Stack(
    alignment: Alignment.center,
    children: [
      Icon(
        iconData,
        color: iconColor,
        size: 20.0,
      ),
      Positioned(
        top : -3,
        child: Container(
          child: Text(
            "${noTruck++}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    ],
  ),
        );
      }).toList()
      ..addAll(snapshot.data!.docs.map<Marker>((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Marker(
            point: LatLng.LatLng(
              double.parse(data['LatLongIKI'].split(',')[0]), // Latitude
              double.parse(data['LatLongIKI'].split(',')[1]), // Longitude
            ),
            child: Stack(
    alignment: Alignment.center,
    children: [
      Icon(
        Icons.location_pin,
        color: Color.fromARGB(255, 244, 17, 17),
        size: 20.0,
      ),
      Positioned(
        top : -3,
        child: Container(
          child: Text(
            "${noIKI++}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    ],
  ),
              
          );
        })),
    );
    
  }
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
  stream: FirebaseFirestore.instance.collection('Pengawalan').orderBy('No Pengajuan').snapshots(),
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
              DataColumn(label: Text('No', style: TextStyle(fontWeight: FontWeight.bold))),
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
                        DataCell(Text('${noTable++}')),
                        DataCell(
                          Text(data['No Pengajuan'] ?? ''),
                          onTap: (){
                            //ketika di klik saya ingin mapnya langsung diarahkan ke marker yang data['Nama'] nya bernilai sama dengan data['No Pengajuan'] disini
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Detail Data'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('No Pengajuan: ${data['No Pengajuan']}'),
                                    Text('Tujuan: ${data['Tujuan']}'),
                                    // Tambahkan kolom lainnya sesuai kebutuhan
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Tutup'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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