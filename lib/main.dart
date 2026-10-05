import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'screens/tela_erro.dart';
import 'screens/tela_principal.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Object? erroInit;
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    erroInit = e;
  }
  runApp(BatalhaApp(erroInit: erroInit));
}

class BatalhaApp extends StatelessWidget {
  final Object? erroInit;
  const BatalhaApp({super.key, this.erroInit});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha de Ideias',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: erroInit == null
          ? const TelaPrincipal()
          : TelaErro(erro: erroInit.toString()),
    );
  }
}
