import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tekkenframadata/presentation/providers/character/character_frame_data_provider.dart';
import 'package:tekkenframadata/presentation/providers/character/selected_character_provider.dart';
import 'package:tekkenframadata/presentation/widgets/frames/frame_data_list.dart';
import 'package:tekkenframadata/presentation/widgets/help/legend_help_dialog.dart';
class FrameDataScreen extends ConsumerWidget {
  static const name = 'frame-data';

  const FrameDataScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          selectedCharacter.name.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white)
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
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                const SliverToBoxAdapter(
                  child: ConteinerWeakSideCharacter(),
                ),
              ];
            },
            body: _FrameDataView(
              characterName: selectedCharacter.apiName,
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const HelpDialogWidget(),
          );
        },
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFB71C1C),
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

class ConteinerWeakSideCharacter extends ConsumerWidget {
  const ConteinerWeakSideCharacter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String iconPath(String avatarName) =>
        'assets/characters_avatar/${avatarName}_avatar_tekken8.jpg';
    final selectedCharacter = ref.watch(selectedCharacterProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: screenWidth * 0.65,
        child: Card(
          elevation: 4.0,
          margin: const EdgeInsets.only(
            left: 8.0,
            top: 8.0,
            bottom: 8.0,
            right: 0.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.redAccent, Color(0xFF1B263B), Colors.black87],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      iconPath(selectedCharacter.apiName),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weak Side',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: 'MonsterBites',
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        selectedCharacter.weakSide.toUpperCase(),
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color:
                              selectedCharacter.weakSide.toUpperCase() == 'SSR'
                                  ? Colors.red
                                  : Colors.blue,
                          fontFamily: 'MonsterBites',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
