import 'package:flutter/material.dart';
import 'package:pengawalan_virtual/main.dart';
import 'package:pengawalan_virtual/pengguna_jasa/dashboard.dart';
import 'package:pengawalan_virtual/pengguna_jasa/dokumentasi.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as LatLng;
import 'package:geolocator/geolocator.dart';
import 'dart:async';

void main() => runApp(MyApp());

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
LatLng.LatLng initialCenter = LatLng.LatLng(0, 0); 
MapController mapController = MapController();
List<Marker> markers = [];
Timer? _timer;






  @override


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
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 30.0,
            ),
          ),
        ),
      );
        mapController.move(initialCenter, 16.0); // Pindahkan peta ke initialCenter
      });
    });
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
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
            child: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 30.0,
            ),
          ),
        ),
      );
        mapController.move(initialCenter, 16.0); // Pindahkan peta ke initialCenter
      });
    });

    });
  }

  // void initState() {
  //   super.initState();
  //   getLocation((coordinates) {
  //     setState(() {
  //       var latLngArray = coordinates.split(',');
  //       var lat = double.parse(latLngArray[0]);
  //       var lng = double.parse(latLngArray[1]);
  //       initialCenter = LatLng.LatLng(lat, lng);
  //       markers.add(
  //       Marker(
  //         width: 80.0,
  //         height: 80.0,
  //         point: LatLng.LatLng(lat, lng),
  //         child: Container(
  //           child: Icon(
  //             Icons.location_pin,
  //             color: Colors.red,
  //             size: 30.0,
  //           ),
  //         ),
  //       ),
  //     );
  //       mapController.move(initialCenter, 16.0); // Pindahkan peta ke initialCenter
  //     });
  //   });



  // }

  void getLocation(Function(String) callback) async {
    Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userCoordinates = '${position.latitude}, ${position.longitude}';
      _controller.text = userCoordinates;
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
                        MaterialPageRoute(builder: (context) => Dashboard()),
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
            // ElevatedButton(child: Text("Get Location"),onPressed: getLocation,),
            
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




body: FlutterMap(
  options: MapOptions(
    minZoom: 5.0,
    initialCenter: initialCenter,
  ),
  mapController: mapController,
  children: [
    TileLayer(
      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      subdomains: ['a', 'b', 'c'],
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
        color: const Color.fromRGBO(255, 255, 255, 0.5), // Ubah nilai alpha untuk mengurangi opacity
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





          Spacer(),
TextField(
  controller: _controller,
  readOnly: true,
  decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
    ),
    filled: true,
    fillColor: Color.fromRGBO(255, 255, 255, 0.5),
    labelText: "Koordinat",
    hintText: userCoordinates.isNotEmpty ? userCoordinates : "Masukkan Koordinat pada Peta",
  ),
),


          SizedBox(height: 15.0),
          TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.blue),
              ),
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 0.5),
              labelText: "Lokasi",
              hintText: "Masukkan Lokasi pada Peta",
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