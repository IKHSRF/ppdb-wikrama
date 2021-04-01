import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<String> loginWithEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> signUpWithEmailandPassword(
    String email,
    String password,
    String status,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = _firebaseAuth.currentUser.uid;

      await _firebaseFirestore.collection('users').doc(uid).set(
        {
          'status': status,
        },
      );

      await _firebaseFirestore.collection('siswa').doc(uid).set({
        'nama': "Data Belum Tervalidasi",
        'nis': "Data Belum Tervalidasi",
        'jenis_kelamin': "Data Belum Tervalidasi",
        'tempat_lahir': "Data Belum Tervalidasi",
        'tanggal_lahir': "Data Belum Tervalidasi",
        'alamat': "Data Belum Tervalidasi",
        'asal_sekolah': "Data Belum Tervalidasi",
        'kelas': "Data Belum Tervalidasi",
        'jurusan': "Data Belum Tervalidasi",
      });
      return 'success';
    } catch (error) {
      print(error);
      return error.message;
    }
  }
}
