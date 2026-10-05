import 'package:flutter/material.dart';

import '../services/ideia_service.dart';

class FormIdeiaDialog extends StatefulWidget {
  final IdeiaService service;
  const FormIdeiaDialog({super.key, required this.service});

  @override
  State<FormIdeiaDialog> createState() => _FormIdeiaDialogState();
}

class _FormIdeiaDialogState extends State<FormIdeiaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  final _autor = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() {
    _titulo.dispose();
    _descricao.dispose();
    _autor.dispose();
    super.dispose();
  }

  String? _obrigatorio(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null;

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);
    try {
      await widget.service.cadastrar(
        titulo: _titulo.text.trim(),
        descricao: _descricao.text.trim(),
        autor: _autor.text.trim(),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => _salvando = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova ideia'),
      content: SizedBox(
        width: 420,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titulo,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: _obrigatorio,
                ),
                TextFormField(
                  controller: _descricao,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  maxLines: 3,
                  validator: _obrigatorio,
                ),
                TextFormField(
                  controller: _autor,
                  decoration: const InputDecoration(labelText: 'Autor'),
                  validator: _obrigatorio,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _salvando ? null : () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _salvando ? null : _salvar,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
