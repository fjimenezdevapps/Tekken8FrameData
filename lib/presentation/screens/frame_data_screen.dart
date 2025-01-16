import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tekkenframadata/domain/entities/character_frame_data.dart';
import 'package:tekkenframadata/presentation/providers/character/character_provider.dart';
import 'package:tekkenframadata/presentation/widgets/frames/frame_data_source.dart';
import 'package:tekkenframadata/presentation/widgets/help/legend_help_dialog.dart';

class FrameDataScreen extends StatelessWidget {
  static const name = 'frame-data';
  final String characterName;

  const FrameDataScreen({super.key, required this.characterName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(characterName),
      ),
      body: _FrameDataView(characterName: characterName),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showHelpDialog(context);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.help_outline_rounded),
      ),
    );
  }
}

class _FrameDataView extends ConsumerStatefulWidget {
  final String characterName;

  const _FrameDataView({required this.characterName});

  @override
  _FrameDataViewState createState() => _FrameDataViewState();
}

class _FrameDataViewState extends ConsumerState<_FrameDataView> {
  final TextEditingController _searchController = TextEditingController();
  late List<FramesNormal> _originalData;
  late List<FramesNormal> _filteredData;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _originalData = [];
    _filteredData = [];
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredData = _originalData
          .where((move) => move.command.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final frameDataAsyncValue =
        ref.watch(characterFrameDataProvider(widget.characterName));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: frameDataAsyncValue.when(
                data: (frameData) {
                  if (frameData.framesNormal.isEmpty) {
                    return const Center(
                        child: Text('No moves available for this character.'));
                  }

                  _originalData = frameData.framesNormal;
                  _filteredData =
                      _filteredData.isEmpty ? _originalData : _filteredData;

                  final headers = [
                    "Name",
                    "Command",
                    "StartUp",
                    "Block",
                    "Hit",
                    "Counter Hit",
                    "Hit Level",
                    "Damage"
                  ];

                  final rowsCells = _filteredData.map((row) {
                    return [
                      row.name ?? '',
                      row.command,
                      row.startup,
                      row.block,
                      row.hit,
                      row.counterHit,
                      row.hitLevel,
                      row.damage,
                    ];
                  }).toList();

                  return CustomDataTable(
                    headers: headers,
                    rowsCells: rowsCells,
                    borderColor: Colors.grey.shade300,
                    onCellTap: (details) {
                      // Asegúrate de que el índice sea válido
                      if (details.rowIndex >= 0 && 
                          details.rowIndex < _filteredData.length) {
                        final move = _filteredData[details.rowIndex];
                        context.push('/move-details', extra: move);
                      }
                    },
                  );
                },
                error: (error, stack) => Center(
                  child: Text('Error: ${error.toString()}'),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Celda táctil
