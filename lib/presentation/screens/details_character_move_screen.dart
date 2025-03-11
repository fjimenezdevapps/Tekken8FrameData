import 'package:flutter/material.dart';
import 'package:tekkenframadata/domain/entities/character_frame_data.dart';
import 'package:tekkenframadata/presentation/widgets/video%20player/video_player.dart';

class DetailsCharacterMoveScreen extends StatelessWidget {
  static const name = 'move-details';
  final FramesNormal move;

  const DetailsCharacterMoveScreen({super.key, required this.move});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Moves Details',
          style: TextStyle(
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
        child: SafeArea(
          child: _DetailsMoveView(move: move),
        ),
      ),
    );
  }
}

class _DetailsMoveView extends StatelessWidget {
  final FramesNormal move;

  const _DetailsMoveView({required this.move});

  @override
  Widget build(BuildContext context) {
    final moveDetails = [
      _MoveDetail(
        label: 'COMMAND :',
        value: move.command.isNotEmpty ? move.command : 'None',
      ),
      _MoveDetail(
        label: 'DAMAGE :',
        value: move.damage.isNotEmpty ? move.damage : 'None',
      ),
      _MoveDetail(
        label: 'STARTUP :',
        value: move.startup.isNotEmpty ? move.startup : 'None',
      ),
      _MoveDetail(
        label: 'BLOCK :',
        value: move.block.isNotEmpty ? move.block : 'None',
      ),
      _MoveDetail(
        label: 'HIT :',
        value: move.hit.isNotEmpty ? move.hit : 'None',
      ),
      _MoveDetail(
        label: 'COUNTER HIT :',
        value: move.counterHit.isNotEmpty ? move.counterHit : 'None',
      ),
      _MoveDetail(
        label: 'HIT LEVEL :',
        value: move.hitLevel.isNotEmpty ? move.hitLevel : 'None',
      ),
    ];

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    VideoPlayer(move: move),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
            ),
          ),
        ];
      },
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _MoveDetailsCard(details: moveDetails),
                    const SizedBox(height: 16),
                    if (move.notes.isNotEmpty == true)
                      _DetailCard(
                        label: 'NOTES',
                        content: move.notes,
                      ),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _MoveDetail {
  final String label;
  final String value;

  const _MoveDetail({required this.label, required this.value});
}

class _DetailCard extends StatelessWidget {
  final String label;
  final String content;

  const _DetailCard({
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoveDetailsCard extends StatelessWidget {
  final List<_MoveDetail> details;

  const _MoveDetailsCard({required this.details});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.black.withOpacity(0.6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: details.map((detail) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label (ej: "COMMAND :", "DAMAGE :", etc.)
                  SizedBox(
                    width: 130,
                    child: Text(
                      detail.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Valor (ej: "df+2", "12", etc.)
                  Expanded(
                    child: Text(
                      detail.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
