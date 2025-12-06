import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tekkenframadata/presentation/cubit/character/character_cubit.dart';
import 'package:tekkenframadata/presentation/cubit/character/character_state.dart';
import 'package:tekkenframadata/presentation/widgets/characters/character_card.dart';
import 'package:tekkenframadata/presentation/widgets/commons/search_bar_widget.dart';

enum SortOrder { none, ascending, descending }

class CharacterSelectionScreen extends StatefulWidget {
  static const String name = 'character-selection';
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() =>
      _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  late final TextEditingController _searchController;
  SortOrder _sortOrder = SortOrder.none;

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
    // Load characters when screen is built
    context.read<CharacterCubit>().loadCharacters();

    return BlocBuilder<CharacterCubit, CharacterState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Character Selection',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'MonsterBites',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              iconTheme: const IconThemeData(color: Colors.white)),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBarWidget(
                            controller: _searchController,
                            hintText: 'Search character...',
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildSortButton(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildCharacterList(state),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCharacterList(CharacterState state) {
    if (state is CharacterLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CharacterError) {
      return Center(child: Text('Error: ${state.message}'));
    } else if (state is CharacterLoaded) {
      final characters = _filterCharacters(state.characters);

      if (characters.isEmpty) {
        return Center(
          child: Text(
            'No characters found',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 16,
            ),
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(4.0),
        itemCount: (characters.length / 2).ceil(),
        itemBuilder: (context, rowIndex) {
          int firstItemIndex = rowIndex * 2;
          int secondItemIndex = firstItemIndex + 1;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double buttonWidth = (constraints.maxWidth - 16) / 2;
                return Row(
                  children: [
                    SizedBox(
                      width: buttonWidth,
                      child: ClipPath(
                        clipper: ParallelogramClipper(),
                        child: ConteinerCharacter(
                          character: characters[firstItemIndex],
                        ),
                      ),
                    ),
                    if (secondItemIndex < characters.length) ...[
                      const SizedBox(width: 12.0),
                      SizedBox(
                        width: buttonWidth,
                        child: ClipPath(
                          clipper: ParallelogramClipper(),
                          child: ConteinerCharacter(
                            character: characters[secondItemIndex],
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  List<dynamic> _filterCharacters(List<dynamic> characters) {
    final query = _searchController.text.trim().toLowerCase();

    // Filter by search query
    List<dynamic> filtered = query.isEmpty
        ? List.from(characters)
        : characters.where((character) {
            return character.name.toLowerCase().contains(query);
          }).toList();

    // Apply sorting
    if (_sortOrder == SortOrder.ascending) {
      filtered
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (_sortOrder == SortOrder.descending) {
      filtered
          .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    }

    return filtered;
  }

  Widget _buildSortButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.1),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: IconButton(
        icon: Transform.rotate(
          angle: _sortOrder == SortOrder.descending ? 3.14159 : 0,
          child: Icon(
            Icons.sort_by_alpha,
            color: _sortOrder == SortOrder.none
                ? Colors.white.withValues(alpha: 0.5)
                : Colors.white,
            size: 24,
          ),
        ),
        onPressed: () {
          setState(() {
            _sortOrder = _sortOrder == SortOrder.none
                ? SortOrder.ascending
                : _sortOrder == SortOrder.ascending
                    ? SortOrder.descending
                    : SortOrder.none;
          });
        },
        tooltip: _sortOrder == SortOrder.none
            ? 'Sort A-Z'
            : _sortOrder == SortOrder.ascending
                ? 'Sort Z-A'
                : 'Clear sort',
      ),
    );
  }
}
