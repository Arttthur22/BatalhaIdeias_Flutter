import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ideia.dart';

class IdeiaService {
  CollectionReference<Map<String, dynamic>> get _ref =>
      FirebaseFirestore.instance.collection('ideias');

  Stream<List<Ideia>> ideias() {
    return _ref.orderBy('votos', descending: true).snapshots().map(
          (snap) =>
              snap.docs.map((d) => Ideia.fromMap(d.id, d.data())).toList(),
        );
  }

  Future<void> cadastrar({
    required String titulo,
    required String descricao,
    required String autor,
  }) {
    return _ref.add({
      'titulo': titulo,
      'descricao': descricao,
      'autor': autor,
      'votos': 0,
    });
  }

  Future<void> votar(String id) =>
      _ref.doc(id).update({'votos': FieldValue.increment(1)});

  Future<void> excluir(String id) => _ref.doc(id).delete();
}
