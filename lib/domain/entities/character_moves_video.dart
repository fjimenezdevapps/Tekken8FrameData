class CharacterMoveVideo {
  final String command;
  final String initialVideoId;
  final int startAt;
  final int? endAt;

  CharacterMoveVideo({
    required this.command,
    required this.initialVideoId,
    required this.startAt,
    this.endAt,
  });

  @override
  String toString() {
    return 'Command: $command, Video: $initialVideoId, StartAt: $startAt, EndAt: ${endAt ?? 'N/A'}';
  }
}