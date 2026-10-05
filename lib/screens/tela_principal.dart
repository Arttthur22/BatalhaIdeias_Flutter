import 'package:flutter/material.dart';

import '../models/ideia.dart';
import '../services/ideia_service.dart';
import '../widgets/form_ideia_dialog.dart';
import '../widgets/ideia_card.dart';
import '../widgets/ranking_card.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  Future<void> _excluir(
    BuildContext context,
    IdeiaService service,
    Ideia ideia,
  ) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir ideia?'),
        content:
            Text('"${ideia.titulo}" será removida para todos os usuários.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    if (confirmar == true) {
      await service.excluir(ideia.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = IdeiaService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('⚔️ Batalha de Ideias'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => FormIdeiaDialog(service: service),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Nova ideia'),
      ),
      body: StreamBuilder<List<Ideia>>(
        stream: service.ideias(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final ideias = snapshot.data!;
          if (ideias.isEmpty) {
            return const Center(
              child: Text('Nenhuma ideia ainda. Cadastre a primeira!'),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                children: [
                  RankingCard(ideia: ideias.first),
                  const SizedBox(height: 16),
                  for (final ideia in ideias)
                    IdeiaCard(
                      ideia: ideia,
                      onVotar: () => service.votar(ideia.id),
                      onExcluir: () => _excluir(context, service, ideia),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
