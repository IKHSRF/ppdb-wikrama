import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ppdb_wikrama/services/firebase/firebase_auth_services.dart';
import 'package:ppdb_wikrama/services/firebase/firestore_services.dart';
import 'package:ppdb_wikrama/widgets/input_field.dart';
import 'package:intl/intl.dart';
import 'package:ppdb_wikrama/services/provider/jenis_kelamin_provider.dart';
import 'package:ppdb_wikrama/services/provider/kelas_provider.dart';
import 'package:ppdb_wikrama/services/provider/tanggal_lahir_provider.dart';
import 'package:provider/provider.dart';

class SiswaPage extends StatelessWidget {
  static const String id = '/siswa';
  @override
  Widget build(BuildContext context) {
    TextEditingController _namaController = TextEditingController();
    TextEditingController _nisController = TextEditingController();
    TextEditingController _tmptLahirController = TextEditingController();
    TextEditingController _alamatController = TextEditingController();
    TextEditingController _asalSekolahController = TextEditingController();
    TextEditingController _jurusanController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        title: TextButton(
          child: Text(
            "Log out",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            AuthServices.signOut();
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('siswa')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .snapshots(),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListTile(
                title: Text(data['nama'] ?? "Data Belum Tervalidasi"),
                subtitle: Text(data['nama'] == 'Data Belum Tervalidasi'
                    ? 'Data Belum Tervalidasi'
                    : 'Data Sudah Divalidasi'),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 'menu',
                      child: TextButton(
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Consumer<TanggalLahirProvider>(
                                builder: (context, tgl, _) =>
                                    Consumer<KelasProvider>(
                                  builder: (context, kls, _) =>
                                      Consumer<JenisKelaminProvider>(
                                    builder: (context, jk, _) => AlertDialog(
                                      title: Text('Edit Data'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InputField(
                                              textEditingController:
                                                  _namaController,
                                              hintText: (data['nama'] ==
                                                      'Data Belum Tervalidasi')
                                                  ? 'Nama'
                                                  : data['nama'],
                                            ),
                                            InputField(
                                              textEditingController:
                                                  _nisController,
                                              hintText: (data['nis'] ==
                                                      'Data Belum Tervalidasi')
                                                  ? 'Nis'
                                                  : data['nis'],
                                              inputNumber: true,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: DropdownButton(
                                                hint: Text((data[
                                                            'jenis_kelamin'] ==
                                                        'Data Belum Tervalidasi')
                                                    ? 'Jenis Kelamin'
                                                    : data['jenis_kelamin']),
                                                value: jk.jenisKelamin,
                                                onChanged: (value) {
                                                  jk.jenisKelamin = value;
                                                },
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "laki - laki",
                                                    child: Text("Laki - laki"),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "perempuan",
                                                    child: Text("Perempuan"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextField(
                                              readOnly: true,
                                              onTap: () async {
                                                final DateTime picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: (data[
                                                              'tanggal_lahir'] ==
                                                          'Data Belum Tervalidasi')
                                                      ? DateTime.now()
                                                      : DateTime.parse(data[
                                                          'tanggal_lahir']),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2025),
                                                );
                                                if (picked != null) {
                                                  var dateFormatter =
                                                      DateFormat('yyyy-MM-dd');
                                                  String formattedDate =
                                                      dateFormatter
                                                          .format(picked);
                                                  tgl.tanggalLahir =
                                                      formattedDate;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                hintText: (data[
                                                            'tanggal_lahir'] ==
                                                        'Data Belum Tervalidasi')
                                                    ? tgl.tanggalLahir == null
                                                        ? 'Tanggal Lahir'
                                                        : tgl.tanggalLahir
                                                    : data['tanggal_lahir'],
                                              ),
                                            ),
                                            InputField(
                                              textEditingController:
                                                  _tmptLahirController,
                                              hintText: (data['tempat_lahir'] ==
                                                      'Data Belum Tervalidasi')
                                                  ? 'Tempat Lahir'
                                                  : data['tempat_lahir'],
                                            ),
                                            InputField(
                                              textEditingController:
                                                  _alamatController,
                                              hintText: (data['alamat'] ==
                                                      'Data Belum Tervalidasi')
                                                  ? 'Alamat'
                                                  : data['alamat'],
                                            ),
                                            InputField(
                                              textEditingController:
                                                  _asalSekolahController,
                                              hintText: (data['asal_sekolah'] ==
                                                      'Data Belum Tervalidasi')
                                                  ? 'Asal Sekolah'
                                                  : data['asal_sekolah'],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: DropdownButton(
                                                hint: Text((data['kelas'] ==
                                                        'Data Belum Tervalidasi')
                                                    ? 'Kelas'
                                                    : data['kelas']),
                                                value: kls.kelas,
                                                onChanged: (value) {
                                                  kls.kelas = value;
                                                },
                                                items: [
                                                  DropdownMenuItem(
                                                    value: "X",
                                                    child: Text("X"),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "XI",
                                                    child: Text("XI"),
                                                  ),
                                                  DropdownMenuItem(
                                                    value: "XII",
                                                    child: Text("XII"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InputField(
                                              textEditingController:
                                                  _jurusanController,
                                              hintText: (data['jurusan'] ==
                                                      'Data Belum Tervalidasi')
                                                  ? 'Jurusan'
                                                  : data['jurusan'],
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            jk.jenisKelamin = null;
                                            kls.kelas = null;
                                            tgl.tanggalLahir = null;
                                            _namaController.clear();
                                            _nisController.clear();
                                            _tmptLahirController.clear();
                                            _alamatController.clear();
                                            _asalSekolahController.clear();
                                            _jurusanController.clear();
                                          },
                                          child: Text('Clear'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            FirestoreServices.editUser(
                                              uid: data.id,
                                              nama: _namaController.text.isEmpty
                                                  ? data['nama']
                                                  : _namaController.text,
                                              nis: _nisController.text.isEmpty
                                                  ? data['nis']
                                                  : _nisController.text,
                                              jnsKelamin:
                                                  jk.jenisKelamin == null
                                                      ? data['jenis_kelamin']
                                                      : jk.jenisKelamin,
                                              tempLahir: _tmptLahirController
                                                      .text.isEmpty
                                                  ? data['tempat_lahir']
                                                  : _tmptLahirController.text,
                                              tglLahir: tgl.tanggalLahir == null
                                                  ? data['tanggal_lahir']
                                                  : tgl.tanggalLahir,
                                              alamat:
                                                  _alamatController.text.isEmpty
                                                      ? data['alamat']
                                                      : _alamatController.text,
                                              asalSekolah:
                                                  _asalSekolahController
                                                          .text.isEmpty
                                                      ? data['asal_sekolah']
                                                      : _asalSekolahController
                                                          .text,
                                              kelas: kls.kelas == null
                                                  ? data['kelas']
                                                  : kls.kelas,
                                              jurusan: _jurusanController
                                                      .text.isEmpty
                                                  ? data['jurusan']
                                                  : _jurusanController.text,
                                            );
                                            jk.jenisKelamin = null;
                                            kls.kelas = null;
                                            tgl.tanggalLahir = null;
                                            _namaController.clear();
                                            _nisController.clear();

                                            _tmptLahirController.clear();
                                            _alamatController.clear();
                                            _asalSekolahController.clear();
                                            _jurusanController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Edit'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
