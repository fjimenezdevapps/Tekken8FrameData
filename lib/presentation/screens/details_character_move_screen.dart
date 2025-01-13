import 'package:flutter/material.dart';

class DetailsCharacterMoveScreen extends StatelessWidget {
  static const name = 'move-details';

  const DetailsCharacterMoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move details'),
      ),
      body: _DetailsMoveView(),
    );
  }
}

class _DetailsMoveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12.0),
      children: const [
        _ConteinerViewState(name: 'name'),
        _ConteinerViewState(name: 'command'),
        _ConteinerViewState(name: 'startup'),
        _ConteinerViewState(name: 'block'),
        _ConteinerViewState(name: 'hit'),
        _ConteinerViewState(name: 'properties'),
        _ConteinerViewState(name: 'damage'),
        _ConteinerViewState(name: 'Notes'),
        ],
    );
  }
}

class _ConteinerViewState extends StatelessWidget {
  final String name;

  const _ConteinerViewState({required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.toUpperCase(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Contenido de la celda'),
        ],
      ),
    );
  }
}
