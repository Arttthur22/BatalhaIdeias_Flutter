class Ideia {
  final String id;
  final String titulo;
  final String descricao;
  final String autor;
  final int votos;

  const Ideia({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.autor,
    required this.votos,
  });

  factory Ideia.fromMap(String id, Map<String, dynamic> map) => Ideia(
        id: id,
        titulo: (map['titulo'] ?? '') as String,
        descricao: (map['descricao'] ?? '') as String,
        autor: (map['autor'] ?? '') as String,
        votos: (map['votos'] ?? 0) as int,
      );
}
