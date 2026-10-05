import 'package:flutter/material.dart';

import '../models/ideia.dart';

class RankingCard extends StatelessWidget {
  final Ideia ideia;
  const RankingCard({super.key, required this.ideia});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🏆 IDEIA MAIS VOTADA',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(ideia.titulo, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text('${ideia.votos} ${ideia.votos == 1 ? 'voto' : 'votos'}'),
          ],
        ),
      ),
    );
  }
}
