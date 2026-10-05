import 'package:flutter_test/flutter_test.dart';

import 'package:atividade/models/ideia.dart';

void main() {
  test('Ideia.fromMap lê os campos do documento', () {
    final ideia = Ideia.fromMap('abc', {
      'titulo': 'Torneio de Games',
      'descricao': 'Torneio entre turmas',
      'autor': 'Pedro',
      'votos': 5,
    });
    expect(ideia.id, 'abc');
    expect(ideia.titulo, 'Torneio de Games');
    expect(ideia.autor, 'Pedro');
    expect(ideia.votos, 5);
  });

  test('votos ausentes viram 0', () {
    final ideia = Ideia.fromMap('x', {'titulo': 't', 'descricao': 'd', 'autor': 'a'});
    expect(ideia.votos, 0);
  });
}
