import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ppdb_wikrama/pages/admin/admin_page.dart';
import 'package:ppdb_wikrama/pages/siswa/siswa_page.dart';

class UserValidation extends StatelessWidget {
  static const String id = '/validation';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.data['status'] == 'admin') {
          return AdminPage();
        }
        return SiswaPage();
      },
    );
  }
}
