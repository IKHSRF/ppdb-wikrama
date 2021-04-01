import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static CollectionReference _siswa = _firestore.collection('siswa');

  static Future<String> removeUser(String id) async {
    try {
      await _siswa.doc(id).delete();
      return 'success';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> editUser({
    String uid,
    String nama,
    String nis,
    String jnsKelamin,
    String tempLahir,
    String tglLahir,
    String alamat,
    String asalSekolah,
    String kelas,
    String jurusan,
  }) async {
    try {
      await _siswa.doc(uid).update({
        'nama': nama,
        'nis': nis,
        'jenis_kelamin': jnsKelamin,
        'tempat_lahir': tempLahir,
        'tanggal_lahir': tglLahir,
        'alamat': alamat,
        'asal_sekolah': asalSekolah,
        'kelas': kelas,
        'jurusan': jurusan,
      });
      return 'success';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> adminAddUser(
    String nama,
    String nis,
    String jnsKelamin,
    String tempLahir,
    String tglLahir,
    String alamat,
    String asalSekolah,
    String kelas,
    String jurusan,
  ) async {
    try {
      await _siswa.add({
        'nama': nama,
        'nis': nis,
        'jenis_kelamin': jnsKelamin,
        'tempat_lahir': tempLahir,
        'tanggal_lahir': tglLahir,
        'alamat': alamat,
        'asal_sekolah': asalSekolah,
        'kelas': kelas,
        'jurusan': jurusan,
      });
      return 'success';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> addUser(
    String uid,
    String nama,
    String nis,
    String jnsKelamin,
    String tempLahir,
    String tglLahir,
    String alamat,
    String asalSekolah,
    String kelas,
    String jurusan,
  ) async {
    try {
      await _siswa.doc(uid).set({
        'nama': nama,
        'nis': nis,
        'jenis_kelamin': jnsKelamin,
        'tempat_lahir': tempLahir,
        'tanggal_lahir': tglLahir,
        'alamat': alamat,
        'asal_sekolah': asalSekolah,
        'kelas': kelas,
        'jurusan': jurusan,
      }, SetOptions(merge: true));
      return 'success';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Stream<dynamic> getSiswaList() => _siswa.snapshots();
}
