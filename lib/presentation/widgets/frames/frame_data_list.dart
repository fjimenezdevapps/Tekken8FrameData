import 'package:flutter/material.dart';
import 'package:tekkenframadata/data/models/character_frame_data.dart';
import 'package:go_router/go_router.dart';

class FrameDataList extends StatelessWidget {
  final List<dynamic> characterMoves;

  const FrameDataList({
    super.key,
    required this.characterMoves,
  });

  @override
  Widget build(BuildContext context) {
    const totalWidth = 1600.0;

    if (characterMoves.isEmpty) {
      return const Center(
          child: Text('No moves available for this character.'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: totalWidth,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: characterMoves.length,
                itemBuilder: (context, index) {
                  final move = characterMoves[index];
                  return _buildListItem(context,move);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey[300],
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildHeaderCell('Name', 200),
            _buildHeaderCell('Command', 200),
            _buildHeaderCell('StartUp', 200),
            _buildHeaderCell('Block', 200),
            _buildHeaderCell('Hit', 200),
            _buildHeaderCell('Counter Hit', 200),
            _buildHeaderCell('Hit Level', 200),
            _buildHeaderCell('Damage', 200),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, FramesNormal frameNormal) {
    return GestureDetector(
      onTap: () {
        context.push('/move-details', extra: frameNormal);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          border: const Border(
            bottom: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildListCell(frameNormal.name ?? "", 200),
              _buildListCell(frameNormal.command, 200),
              _buildListCell(frameNormal.startup, 200),
              _buildListCell(frameNormal.block, 200),
              _buildListCell(frameNormal.hit, 200),
              _buildListCell(frameNormal.counterHit, 200),
              _buildListCell(frameNormal.hitLevel, 200),
              _buildListCell(frameNormal.damage, 200),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCell(String text, double width) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
