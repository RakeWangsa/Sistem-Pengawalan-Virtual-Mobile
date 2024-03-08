import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pengawalan_virtual/main.dart';
import 'package:pengawalan_virtual/pengguna_jasa/dashboard.dart';
import 'package:pengawalan_virtual/pengguna_jasa/dokumentasi.dart';
import 'package:pengawalan_virtual/pengguna_jasa/drawer.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LatLng;
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Permission.location.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(-6.124487407691205, 106.65877266300464),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final double lat;
  final double lng;
  MyHomePage(this.lat, this.lng);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userCoordinates = '';
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerLokasi = TextEditingController();
  LatLng.LatLng initialCenter = LatLng.LatLng(0, 0);
  MapController mapController = MapController();
  List<Marker> markers = [];
  Timer? _timer;


  String _locationName = '';

  @override
  Future<void> _fetchLocationName(double lat, double lng) async {
    final apiKey = '65dc4dd5da06e495765672ajqc27058';
    final url =
        'https://geocode.maps.co/reverse?lat=$lat&lon=$lng&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _locationName = data['display_name'];
        _controllerLokasi.text = _locationName;
      });
    } else {
      setState(() {
        _controllerLokasi.text = "Memperoleh Data Lokasi...";
      });
      await Future.delayed(
          Duration(seconds: 3)); // Tunggu 3 detik sebelum pemanggilan ulang
      _fetchLocationName(lat, lng); // Panggil ulang fungsi
    }
  }

  void initState() {
    super.initState();
    getLocation((coordinates) {
      setState(() {
        var latLngArray = coordinates.split(',');
        var lat = double.parse(latLngArray[0]);
        var lng = double.parse(latLngArray[1]);
        initialCenter = LatLng.LatLng(lat, lng);
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng.LatLng(lat, lng),
            child: Container(
              key: Key('lokasi_saya'),
              child: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 30.0,
              ),
            ),
          ),
        );
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng.LatLng(-6.640817470753179, 110.70944469305388),
            child: Container(
              child: Icon(
                Icons.home_work,
                color: Color.fromARGB(255, 44, 55, 255),
                size: 30.0,
              ),
            ),
          ),
        );
        _fetchLocationName(lat, lng);
        mapController.move(
            initialCenter, 16.0); // Pindahkan peta ke initialCenter
      });
    });
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      getLocation((coordinates) {
        setState(() {
          markers
              .removeWhere((marker) => marker.child.key == Key('lokasi_saya'));
          var latLngArray = coordinates.split(',');
          var lat = double.parse(latLngArray[0]);
          var lng = double.parse(latLngArray[1]);
          initialCenter = LatLng.LatLng(lat, lng);
          markers.add(
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng.LatLng(lat, lng),
              child: Container(
                key: Key('lokasi_saya'),
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 30.0,
                ),
              ),
            ),
          );
          _fetchLocationName(lat, lng);
          mapController.move(
              initialCenter, 16.0); // Pindahkan peta ke initialCenter
        });
      });
    });
  }



  void getLocation(Function(String) callback) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    setState(() {
      userCoordinates = '${position.latitude}, ${position.longitude}';
      _controller.text = userCoordinates;
    });

    // Update data di Firebase Firestore
    FirebaseFirestore.instance
        .collection('Lokasi')
        .doc('W6VtIVctpLQPoA4j6Qp6')
        .update({
      'LatLong': userCoordinates,
    });

    callback(userCoordinates);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
      drawer: AppDrawer(
        page : 'pengiriman',
      ),
      body: FlutterMap(
        options: MapOptions(
          minZoom: 5.0,
          initialCenter: initialCenter,
        ),
        mapController: mapController,
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),
          const MapCompass.cupertino(
            hideIfRotatedNorth: false,
          ),
          MarkerLayer(markers: markers),
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
                        color: const Color.fromRGBO(255, 255, 255,
                            0.5), // Ubah nilai alpha untuk mengurangi opacity
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        "Pengiriman",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),
                ),
                if (userCoordinates.isEmpty) ...[
                  Spacer(),
                  Text("Menyiapkan GPS, Mohon tunggu sebentar..."),
                ],
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Memindahkan peta ke posisi marker
                      mapController.move(
                          LatLng.LatLng(-6.640817470753179, 110.70944469305388),
                          16.0);
                    },
                    child: Icon(Icons.home_work_outlined,
                        color: Color.fromARGB(255, 134, 201, 255)),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(15),
                      backgroundColor: Color.fromARGB(
                          255, 255, 255, 255), // Warna latar belakang tombol
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Detail Pengiriman'),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('No Pengajuan : E/123/123'),
                                  Text('Tujuan : IKI A Tembalang, Semarang'),
                                  Text('Berangkat : 08.00 WIB'),
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
                        child: Icon(
                          Icons.info_outline,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                          backgroundColor: Color.fromARGB(255, 112, 191,
                              255), // Warna latar belakang tombol
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Memindahkan peta ke posisi marker
                          mapController.move(initialCenter, 16.0);
                        },
                        child: Icon(Icons.man,
                            color: Color.fromARGB(255, 134, 201, 255)),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(15),
                          backgroundColor: Color.fromARGB(255, 255, 255,
                              255), // Warna latar belakang tombol
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                TextField(
                  controller: _controller,
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                    labelText: "Koordinat",
                    hintText: userCoordinates.isNotEmpty
                        ? userCoordinates
                        : "Menunggu...",
                  ),
                ),
                SizedBox(height: 15.0),
                TextField(
                  controller: _controllerLokasi,
                  readOnly: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(255, 255, 255, 0.5),
                    labelText: "Lokasi",
                    hintText: _locationName.isNotEmpty
                        ? _locationName
                        : "Menunggu...",
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
