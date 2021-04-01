import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppdb_wikrama/pages/admin/laporan_page.dart';
import 'package:ppdb_wikrama/services/firebase/firestore_services.dart';
import 'package:ppdb_wikrama/services/provider/jenis_kelamin_provider.dart';
import 'package:ppdb_wikrama/services/provider/kelas_provider.dart';
import 'package:ppdb_wikrama/services/provider/tanggal_lahir_provider.dart';
import 'package:ppdb_wikrama/widgets/detail_field.dart';
import 'package:ppdb_wikrama/widgets/input_field.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatelessWidget {
  static const String id = '/admin';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Consumer<TanggalLahirProvider>(
                      builder: (context, tgl, _) => Consumer<KelasProvider>(
                        builder: (context, kls, _) =>
                            Consumer<JenisKelaminProvider>(
                          builder: (context, jk, _) => AlertDialog(
                            title: Text('Add Data'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InputField(
                                    textEditingController: _namaController,
                                    hintText: 'Nama',
                                  ),
                                  InputField(
                                    textEditingController: _nisController,
                                    hintText: 'NIS',
                                    inputNumber: true,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: DropdownButton(
                                      hint: Text("Jenis Kelamin"),
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
                                        initialDate: tgl.tanggalLahir == null
                                            ? DateTime.now()
                                            : DateTime.parse(tgl.tanggalLahir),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2025),
                                      );
                                      if (picked != null) {
                                        var dateFormatter =
                                            DateFormat('yyyy-MM-dd');
                                        String formattedDate =
                                            dateFormatter.format(picked);
                                        tgl.tanggalLahir = formattedDate;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: tgl.tanggalLahir == null
                                          ? 'Tanggal Lahir'
                                          : tgl.tanggalLahir,
                                    ),
                                  ),
                                  InputField(
                                    textEditingController: _tmptLahirController,
                                    hintText: 'Tempat Lahir',
                                  ),
                                  InputField(
                                    textEditingController: _alamatController,
                                    hintText: 'Alamat',
                                  ),
                                  InputField(
                                    textEditingController:
                                        _asalSekolahController,
                                    hintText: 'Asal Sekolah',
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: DropdownButton(
                                      hint: Text("Kelas"),
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
                                    textEditingController: _jurusanController,
                                    hintText: 'Jurusan',
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
                                  if (_namaController.text.isEmpty ||
                                      _nisController.text.isEmpty ||
                                      _jurusanController.text.isEmpty ||
                                      _tmptLahirController.text.isEmpty ||
                                      _alamatController.text.isEmpty ||
                                      _asalSekolahController.text.isEmpty ||
                                      _jurusanController.text.isEmpty ||
                                      tgl.tanggalLahir == null ||
                                      jk.jenisKelamin == null ||
                                      kls.kelas == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Harap Isi Semua Field"),
                                      ),
                                    );
                                  } else {
                                    FirestoreServices.adminAddUser(
                                      _namaController.text,
                                      _nisController.text,
                                      jk.jenisKelamin,
                                      _tmptLahirController.text,
                                      tgl.tanggalLahir,
                                      _alamatController.text,
                                      _asalSekolahController.text,
                                      kls.kelas,
                                      _jurusanController.text,
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
                                  }
                                },
                                child: Text('Add'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: Text(
                'Tambah Data',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, LaporanPage.id);
              },
              child: Text("Laporan", style: TextStyle(color: Colors.white)),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: StreamBuilder(
            stream: FirestoreServices.getSiswaList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshot.data.docs[index];
                  return ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Detail data'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DetailField(hintText: data['nis']),
                              DetailField(hintText: data['nama']),
                              DetailField(hintText: data['jenis_kelamin']),
                              DetailField(hintText: data['tempat_lahir']),
                              DetailField(hintText: data['tanggal_lahir']),
                              DetailField(hintText: data['alamat']),
                              DetailField(hintText: data['asal_sekolah']),
                              DetailField(hintText: data['kelas']),
                              DetailField(hintText: data['jurusan']),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Tutup"),
                            )
                          ],
                        ),
                      );
                    },
                    title: Text(snapshot.data.docs[index]['nama']),
                    subtitle: Text(snapshot.data.docs[index]['nis']),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          value: 'menu',
                          child: TextButton(
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Delete?'),
                                    content: Text(
                                        "Are you sure want to delete ${snapshot.data.docs[index]['nama']}"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context, 'menu');
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          FirestoreServices.removeUser(
                                              snapshot.data.docs[index].id);
                                          Navigator.pop(context, 'menu');
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
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
                                        builder: (context, jk, _) =>
                                            AlertDialog(
                                          title: Text('Edit Data'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InputField(
                                                  textEditingController:
                                                      _namaController,
                                                  hintText: data['nama'],
                                                ),
                                                InputField(
                                                  textEditingController:
                                                      _nisController,
                                                  hintText: data['nis'],
                                                  inputNumber: true,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: DropdownButton(
                                                    hint: Text(
                                                        data['jenis_kelamin']),
                                                    value: jk.jenisKelamin,
                                                    onChanged: (value) {
                                                      jk.jenisKelamin = value;
                                                    },
                                                    items: [
                                                      DropdownMenuItem(
                                                        value: "laki - laki",
                                                        child:
                                                            Text("Laki - laki"),
                                                      ),
                                                      DropdownMenuItem(
                                                        value: "perempuan",
                                                        child:
                                                            Text("Perempuan"),
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
                                                      initialDate:
                                                          DateTime.parse(
                                                        data['tanggal_lahir'],
                                                      ),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2025),
                                                    );
                                                    if (picked != null) {
                                                      var dateFormatter =
                                                          DateFormat(
                                                              'yyyy-MM-dd');
                                                      String formattedDate =
                                                          dateFormatter
                                                              .format(picked);
                                                      tgl.tanggalLahir =
                                                          formattedDate;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        data['tanggal_lahir'],
                                                  ),
                                                ),
                                                InputField(
                                                  textEditingController:
                                                      _tmptLahirController,
                                                  hintText:
                                                      data['tempat_lahir'],
                                                ),
                                                InputField(
                                                  textEditingController:
                                                      _alamatController,
                                                  hintText: data['alamat'],
                                                ),
                                                InputField(
                                                  textEditingController:
                                                      _asalSekolahController,
                                                  hintText:
                                                      data['asal_sekolah'],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: DropdownButton(
                                                    hint: Text(data['kelas']),
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
                                                  hintText: data['jurusan'],
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
                                                  nama: _namaController
                                                          .text.isEmpty
                                                      ? data['nama']
                                                      : _namaController.text,
                                                  nis: _nisController
                                                          .text.isEmpty
                                                      ? data['nis']
                                                      : _nisController.text,
                                                  jnsKelamin: jk.jenisKelamin ==
                                                          null
                                                      ? data['jenis_kelamin']
                                                      : jk.jenisKelamin,
                                                  tempLahir:
                                                      _tmptLahirController
                                                              .text.isEmpty
                                                          ? data['tempat_lahir']
                                                          : _tmptLahirController
                                                              .text,
                                                  tglLahir: tgl.tanggalLahir ==
                                                          null
                                                      ? data['tanggal_lahir']
                                                      : tgl.tanggalLahir,
                                                  alamat: _alamatController
                                                          .text.isEmpty
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
              );
            },
          ),
        ),
      ),
    );
  }
}
