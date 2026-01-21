import 'package:flutter/material.dart';
import 'package:tekkenframadata/presentation/dto/move_details_dto.dart';
import 'package:tekkenframadata/presentation/widgets/commons/elevated_card.dart';

class DetailsCharacterMoveScreen extends StatefulWidget {
  static const name = 'move-details';
  final MoveDetailsDto move;

  const DetailsCharacterMoveScreen({super.key, required this.move});

  @override
  State<DetailsCharacterMoveScreen> createState() =>
      _DetailsCharacterMoveScreenState();
}

class _DetailsCharacterMoveScreenState extends State<DetailsCharacterMoveScreen> {
  // Controladores explícitos para asegurar dispose() al volver atrás.
  final ScrollController _outerScrollController = ScrollController();
  final ScrollController _innerScrollController = ScrollController();

  @override
  void dispose() {
    _outerScrollController.dispose();
    _innerScrollController.dispose();
    super.dispose();
  }

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
          child: _DetailsMoveView(
            move: widget.move,
            outerScrollController: _outerScrollController,
            innerScrollController: _innerScrollController,
          ),
        ),
      ),
    );
  }
}

class _DetailsMoveView extends StatelessWidget {
  final MoveDetailsDto move;
  final ScrollController outerScrollController;
  final ScrollController innerScrollController;

  const _DetailsMoveView({
    required this.move,
    required this.outerScrollController,
    required this.innerScrollController,
  });

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
      controller: outerScrollController,
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
                    // Video player removed
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
            controller: innerScrollController,
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
                    if (move.notes.isNotEmpty)
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
    return AppElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoveDetailsCard extends StatelessWidget {
  final List<_MoveDetail> details;

  const _MoveDetailsCard({required this.details});

  @override
  Widget build(BuildContext context) {
    return AppElevatedCard(
      child: Column(
        children: details.map((detail) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 130,
                  child: Text(
                    detail.label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    detail.value,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white70,
                      height: 1.25,
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
