
class CharacterFrameData {
  final String characterName;
  final String editUrl;
  final String game;
  final List<FramesNormal> framesNormal;
  final List<String> stances;

  CharacterFrameData({
    required this.characterName,
    required this.editUrl,
    required this.game,
    required this.framesNormal,
    required this.stances,
  });

  factory CharacterFrameData.fromJson(Map<String, dynamic> json) {
    return CharacterFrameData(
      characterName: json["characterName"] ?? "Unknown Character",
      editUrl: json["editUrl"] ?? "",
      game: json["game"] ?? "",
      framesNormal: json["framesNormal"] != null
          ? List<FramesNormal>.from(json["framesNormal"].map((x) => FramesNormal.fromJson(x)))
          : [],
      stances: json["stances"] != null ? List<String>.from(json["stances"].map((x) => x)) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "characterName": characterName,
    "editUrl": editUrl,
    "game": game,
    "framesNormal": List<dynamic>.from(framesNormal.map((x) => x.toJson())),
    "stances": List<dynamic>.from(stances.map((x) => x)),
  };
}

class FramesNormal {
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
  final Tags? tags;
  final String? recovery;

  FramesNormal({
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

  factory FramesNormal.fromJson(Map<String, dynamic> json) {
    try {
      return FramesNormal(
        moveNumber: json["moveNumber"] ?? 0,
        command: json["command"] ?? "",
        name: json["name"],
        hitLevel: json["hitLevel"] ?? "",
        damage: json["damage"] ?? "",
        startup: json["startup"] ?? "",
        block: json["block"] ?? "",
        hit: json["hit"] ?? "",
        counterHit: json["counterHit"] ?? "",
        notes: json["notes"] ?? "",
        wavuId: json["wavuId"] ?? "",
        tags: json["tags"] == null ? null : Tags.fromJson(json["tags"]),
        recovery: json["recovery"],
      );
    } catch (e) {
      throw Exception("Error al mapear FramesNormal: $e");
    }
  }

  Map<String, dynamic> toJson() => {
    "moveNumber": moveNumber,
    "command": command,
    "name": name,
    "hitLevel": hitLevel,
    "damage": damage,
    "startup": startup,
    "block": block,
    "hit": hit,
    "counterHit": counterHit,
    "notes": notes,
    "wavuId": wavuId,
    "tags": tags?.toJson(),
    "recovery": recovery,
  };
}


class Tags {
  final Map<String, String?> values;

  Tags({required this.values});

  factory Tags.fromJson(Map<String, dynamic> json) {
    return Tags(
      values: Map<String, String?>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return values;
  }

}
