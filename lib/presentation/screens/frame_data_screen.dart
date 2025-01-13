import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
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
          child: const Icon(Icons.help_outline_rounded)),
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
  late FrameDataSource _frameDataSource;

  List<FramesNormal> _originalData = [];
  List<FramesNormal> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _frameDataSource = FrameDataSource(frameMoves: List.empty());
  }
  

  void _filterItems(String query) {
    setState(() {
      _filteredData = _originalData
          .where((move) =>
              move.name!.toLowerCase().contains(query.toLowerCase()) ||
              move.command.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _frameDataSource.updateData(_filteredData);
    });
  }

  @override
  Widget build(BuildContext context) {
    final frameDataAsyncValue =
        ref.watch(characterFrameDataProvider(widget.characterName));

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _searchController,
            onChanged: (query) => _filterItems(query),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search move...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: frameDataAsyncValue.when(
              data: (frameData) {
                if (frameData.framesNormal.isEmpty) {
                  return const Center(
                      child: Text('No moves available for this character.'));
                }
                _originalData = frameData.framesNormal;
                _filteredData = _filteredData.isEmpty
                    ? _originalData
                    : _filteredData; // Para mantener los filtros activos.
                _frameDataSource.updateData(_filteredData);

                return SfDataGrid(
                  source: _frameDataSource,
                  columnWidthMode: ColumnWidthMode.fill,
                  onCellTap: (details){
                    if (details.rowColumnIndex.rowIndex != 0){
                      //final rowIndex = details.rowColumnIndex.rowIndex - 1;
                      //final move = _frameDataSource[rowIndex];
                      context.push('/move-details');
                    }
                  },
                  columns: [
                    GridColumn(
                      columnName: 'name',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'command',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Command',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'startup',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Startup',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'block',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Block',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'hit',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'hit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'properties',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Properties',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'damage',
                      label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Damage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: ${error.toString()}'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
