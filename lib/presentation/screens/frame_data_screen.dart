import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/presentation/providers/character/character_frame_data_provider.dart';
import 'package:tekkenframadata/presentation/widgets/frames/frame_data_list.dart';
import 'package:tekkenframadata/presentation/widgets/help/legend_help_dialog.dart';

class FrameDataScreen extends StatelessWidget {
  static const name = 'frame-data';
  final String characterName;

  const FrameDataScreen({super.key, required this.characterName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          characterName.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'MonsterBites',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFB71C1C),
                Color(0xFF1B263B),
                Color(0xFF0D1B2A),
              ],
            ),
          ),
          child: SafeArea(child: _FrameDataView(characterName: characterName))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const HelpDialogWidget(),
          );
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
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final frameDataAsyncValue =
        ref.watch(characterFrameDataProvider(widget.characterName));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 16),
            Expanded(child: _buildFrameDataTable(frameDataAsyncValue)),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Search',
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildFrameDataTable(AsyncValue frameDataAsyncValue) {
    return frameDataAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (frameData) {
        final searchQuery = _searchController.text.trim().toLowerCase();
        final filteredData = _filterData(frameData.framesNormal);
        if (searchQuery.isNotEmpty && filteredData.isEmpty) {
          return const Center(child: Text('No moves match your search'));
        }
        return FrameDataList(characterMoves: filteredData);
      },
    );
  }

  List<dynamic> _filterData(List<dynamic> frameData) {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return frameData;

    return frameData.where((move) {
      return move.name?.toLowerCase().contains(query) == true ||
          move.command.toLowerCase().contains(query);
    }).toList();
  }
}
