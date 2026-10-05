import 'package:flutter/material.dart';

class TelaErro extends StatelessWidget {
  final String erro;
  const TelaErro({super.key, required this.erro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Não foi possível conectar ao Firebase.\n\n'
            'Rode "flutterfire configure" (veja o README.md).\n\n$erro',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
