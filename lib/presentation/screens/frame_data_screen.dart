import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/presentation/cubit/selected_character/selected_character_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/selected_character/selected_character_state.dart';
import 'package:tekkenframadata/presentation/cubit/character_frame_data/character_frame_data_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/character_frame_data/character_frame_data_state.dart';
import 'package:tekkenframadata/presentation/widgets/frames/frame_data_list.dart';
import 'package:tekkenframadata/presentation/widgets/help/legend_help_dialog.dart';

class FrameDataScreen extends StatelessWidget {
  static const name = 'frame-data';

  const FrameDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCharacterCubit, SelectedCharacterState>(
      builder: (context, state) {
        final selectedCharacter = state.character;

        // OJO: esto se ejecuta en cada build; valora moverlo a un listener/efecto
        if (selectedCharacter.apiName.isNotEmpty) {
          context
              .read<CharacterFrameDataCubit>()
              .loadFrameData(selectedCharacter.apiName);
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              selectedCharacter.name.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                tooltip: 'Ayuda',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const HelpDialogWidget(),
                  );
                },
                icon: const Icon(Icons.help_outline_rounded),
              ),
            ],
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
                  return const [
                    SliverToBoxAdapter(
                      child: ConteinerWeakSideCharacter(),
                    ),
                  ];
                },
                body: _FrameDataView(
                  characterName: selectedCharacter.apiName,
                ),
              ),
            ),
          ),
          // <- Eliminado el FloatingActionButton
        );
      },
    );
  }
}

class _FrameDataView extends StatefulWidget {
  final String characterName;

  const _FrameDataView({required this.characterName});

  @override
  _FrameDataViewState createState() => _FrameDataViewState();
}

class _FrameDataViewState extends State<_FrameDataView> {
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
    return BlocBuilder<CharacterFrameDataCubit, CharacterFrameDataState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSearchField(),
                const SizedBox(height: 16),
                Expanded(child: _buildFrameDataTable(state)),
              ],
            ),
          ),
        );
      },
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

  Widget _buildFrameDataTable(CharacterFrameDataState state) {
    if (state is CharacterFrameDataLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CharacterFrameDataError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is CharacterFrameDataLoaded) {
      final frameData = state.frameData;
      final searchQuery = _searchController.text.trim().toLowerCase();
      final filteredData = _filterData(frameData.framesNormal);
      if (searchQuery.isNotEmpty && filteredData.isEmpty) {
        return const Center(child: Text('No moves match your search'));
      }
      return FrameDataList(characterMoves: filteredData);
    }
    return const SizedBox.shrink();
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

class ConteinerWeakSideCharacter extends StatelessWidget {
  const ConteinerWeakSideCharacter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedCharacterCubit, SelectedCharacterState>(
      builder: (context, state) {
        String iconPath(String avatarName) =>
            'assets/characters_avatar/${avatarName}_avatar_tekken8.jpg';
        final selectedCharacter = state.character;
        final screenWidth = MediaQuery.of(context).size.width;

        return Center(
          // <-- centramos el hijo
          child: SizedBox(
            width: screenWidth * (screenWidth < 380 ? 0.80 : 0.70),
            child: Card(
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(
                // <-- márgenes iguales
                horizontal: 8.0,
                vertical: 8.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.redAccent,
                      Color(0xFF1B263B),
                      Colors.black87
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          iconPath(selectedCharacter.apiName),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Weak Side',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  fontFamily: 'MonsterBites',
                                ),
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            Text(
                              selectedCharacter.weakSide.toUpperCase(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                color:
                                    selectedCharacter.weakSide.toUpperCase() ==
                                            'SSR'
                                        ? Colors.red
                                        : Colors.blue,
                                fontFamily: 'MonsterBites',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
