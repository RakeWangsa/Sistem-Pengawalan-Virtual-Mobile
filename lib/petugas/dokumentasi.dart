import 'package:flutter/material.dart';

void main() => runApp(DokumentasiPetugas());

class DokumentasiPetugas extends StatelessWidget {
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
                    "Dokumentasi",
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
              Container(
                height: 300, // Ganti nilai sesuai dengan kebutuhan max height
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minWidth: constraints.maxWidth),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: DataTable(
                              headingRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 224, 224, 224)),
                              columns: [
                                DataColumn(label: Text('Keterangan', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('File', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                              dataRowMinHeight: 30,
                              dividerThickness: 1.0,
                              rows: [
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Data')),
                                    DataCell(Text('Data')),
                                    DataCell(Icon(Icons.camera_alt)),
                                  ],
                                ),
                              ],
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
