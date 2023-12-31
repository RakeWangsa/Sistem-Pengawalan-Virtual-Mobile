import 'package:flutter/material.dart';

void main() => runApp(RiwayatPengawalan());

class RiwayatPengawalan extends StatelessWidget {
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
                    "Riwayat Pengawalan",
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
              DataColumn(label: Text('Tujuan', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Petugas', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            dataRowMinHeight: 30,
            dividerThickness: 1.0,
            rows: [
              buildDataRow(['1', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['2', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['3', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['4', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['5', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['6', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['7', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['8', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['9', 'Data', 'Data', 'Data', 'Data', 'Data']),
              buildDataRow(['10', 'Data', 'Data', 'Data', 'Data', 'Data']),
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