import 'package:flutter/material.dart';
import 'package:ppdb_wikrama/pages/admin/admin_page.dart';
import 'package:ppdb_wikrama/pages/admin/laporan_page.dart';
import 'package:ppdb_wikrama/pages/login_page.dart';
import 'package:ppdb_wikrama/pages/register_page.dart';
import 'package:ppdb_wikrama/pages/siswa/siswa_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'services/firebase/user_validation.dart';
import 'services/provider/jenis_kelamin_provider.dart';
import 'services/provider/kelas_provider.dart';
import 'services/provider/tanggal_lahir_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<JenisKelaminProvider>(
          create: (context) => JenisKelaminProvider(),
        ),
        ChangeNotifierProvider<KelasProvider>(
          create: (context) => KelasProvider(),
        ),
        ChangeNotifierProvider<TanggalLahirProvider>(
          create: (context) => TanggalLahirProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          UserValidation.id: (_) => UserValidation(),
          AdminPage.id: (_) => AdminPage(),
          LaporanPage.id: (_) => LaporanPage(),
          SiswaPage.id: (_) => SiswaPage(),
          LoginPage.id: (_) => LoginPage(),
          RegisterPage.id: (_) => RegisterPage(),
        },
      ),
    );
  }
}
