import 'package:flutter/material.dart';

import '../models/ideia.dart';

class IdeiaCard extends StatelessWidget {
  final Ideia ideia;
  final VoidCallback onVotar;
  final VoidCallback onExcluir;

  const IdeiaCard({
    super.key,
    required this.ideia,
    required this.onVotar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('🎮 ${ideia.titulo}',
                      style: tema.textTheme.titleMedium),
                ),
                IconButton(
                  tooltip: 'Excluir',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onExcluir,
                ),
              ],
            ),
            Text(ideia.autor,
                style: tema.textTheme.labelLarge
                    ?.copyWith(color: tema.colorScheme.primary)),
            const SizedBox(height: 8),
            Text(ideia.descricao),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                    '❤️ ${ideia.votos} ${ideia.votos == 1 ? 'voto' : 'votos'}',
                    style: tema.textTheme.titleSmall),
                const Spacer(),
                FilledButton.icon(
                  onPressed: onVotar,
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  label: const Text('VOTAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
