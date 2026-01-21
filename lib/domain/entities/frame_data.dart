class FrameData {
  final int moveNumber;
  final String command;
  final String? name;
  final String hitLevel;
  final String damage;
  final String startup;
  final String block;
  final String hit;
  final String counterHit;
  final String notes;
  final String wavuId;
  final Map<String, String?>? tags;
  final String? recovery;

  const FrameData({
    required this.moveNumber,
    required this.command,
    this.name,
    required this.hitLevel,
    required this.damage,
    required this.startup,
    required this.block,
    required this.hit,
    required this.counterHit,
    required this.notes,
    required this.wavuId,
    this.tags,
    this.recovery,
  });
}
