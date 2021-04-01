import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ppdb_wikrama/services/firebase/firestore_services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class LaporanPage extends StatelessWidget {
  static const String id = '/laporan';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('siswa').snapshots(),
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  final doc = pw.Document();
                  doc.addPage(
                    pw.Page(
                      pageFormat: PdfPageFormat.a3,
                      build: (pw.Context context) {
                        return pw.Table(
                          border: pw.TableBorder.all(
                            color: PdfColors.black,
                            style: pw.BorderStyle.solid,
                            width: 2,
                          ),
                          children: [
                            pw.TableRow(children: [
                              pw.Column(children: [pw.Text('NIS')]),
                              pw.Column(children: [pw.Text('Nama')]),
                              pw.Column(children: [pw.Text('Jenis Kelamin')]),
                              pw.Column(children: [pw.Text('Tanggal Lahir')]),
                              pw.Column(children: [pw.Text('Alamat')]),
                              pw.Column(children: [pw.Text('Asal Sekolah')]),
                              pw.Column(children: [pw.Text('Kelas')]),
                              pw.Column(children: [pw.Text('Jurusan')]),
                            ]),
                            pw.TableRow(children: [
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['nis']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['nama']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['jenis_kelamin']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['tanggal_lahir']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['alamat']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['asal_sekolah']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['kelas']);
                                  },
                                ).toList(),
                              ),
                              pw.Column(
                                children: snapshot.data.docs.map<pw.Widget>(
                                  (document) {
                                    return pw.Text(document['jurusan']);
                                  },
                                ).toList(),
                              ),
                            ]),
                          ],
                        );
                      },
                    ),
                  );

                  await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => doc.save());
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "Print",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirestoreServices.getSiswaList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text("Nama")),
                  DataColumn(label: Text("Nis")),
                  DataColumn(label: Text("Jenis Kelamin")),
                  DataColumn(label: Text("Tanggal Lahir")),
                  DataColumn(label: Text("Tempat Lahir")),
                  DataColumn(label: Text("Alamat")),
                  DataColumn(label: Text("Asal Sekolah")),
                  DataColumn(label: Text("Kelas")),
                  DataColumn(label: Text("Jurusan")),
                ],
                rows: snapshot.data.docs.map<DataRow>(
                  (document) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(document['nama'])),
                        DataCell(Text(document['nis'])),
                        DataCell(Text(document['jenis_kelamin'])),
                        DataCell(Text(document['tanggal_lahir'])),
                        DataCell(Text(document['tempat_lahir'])),
                        DataCell(Text(document['alamat'])),
                        DataCell(Text(document['asal_sekolah'])),
                        DataCell(Text(document['kelas'])),
                        DataCell(Text(document['jurusan'])),
                      ],
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
