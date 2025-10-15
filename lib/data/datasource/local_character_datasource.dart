import 'package:tekkenframadata/data/datasource/characters_moves_videos_youtube_darasource.dart';
import 'package:tekkenframadata/domain/entities/character.dart';

class LocalCharacterDataSource {
  final List<Character> _characters = [
    const Character(
      name: "Jin",
      apiName: 'jin',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Kazuya",
      apiName: 'kazuya',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Devil Jin",
      apiName: 'devil-jin',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Paul",
      apiName: 'paul',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "King",
      apiName: 'king',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Law",
      apiName: 'law',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Lee",
      apiName: 'lee',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Lars",
      apiName: 'lars',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Asuka",
      apiName: 'asuka',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Hwoarang",
      apiName: 'hwoarang',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Zafina",
      apiName: 'zafina',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    Character(
      name: "Bryan",
      apiName: 'bryan',
      weakSide: "SSR",
      videoListMoves: CharactersMovesVideosYoutubeDarasource().bryanVideoMoves,
    ),
    const Character(
      name: "Alisa",
      apiName: 'alisa',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Xiaoyu",
      apiName: 'xiaoyu',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Jack-8",
      apiName: 'jack-8',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Steve",
      apiName: 'steve',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Jun",
      apiName: 'jun',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    Character(
      name: "Reina",
      apiName: 'reina',
      weakSide: "SSL",
      videoListMoves: CharactersMovesVideosYoutubeDarasource().reinaVideoMoves,
    ),
    const Character(
      name: "Nina",
      apiName: 'nina',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Lili",
      apiName: 'lili',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Claudio",
      apiName: 'claudio',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    Character(
      name: "Shaheen",
      apiName: 'shaheen',
      weakSide: "SSR",
      videoListMoves:
          CharactersMovesVideosYoutubeDarasource().shaheenVideoMoves,
    ),
    const Character(
      name: "Dragunov",
      apiName: 'dragunov',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Feng",
      apiName: 'feng',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    Character(
      name: "Leo",
      apiName: 'leo',
      weakSide: "SSR",
      videoListMoves: CharactersMovesVideosYoutubeDarasource().leoVideoMoves,
    ),
    const Character(
      name: "Raven",
      apiName: 'raven',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Azucena",
      apiName: 'azucena',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Victor",
      apiName: 'victor',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Leroy",
      apiName: 'leroy',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Kuma",
      apiName: 'kuma',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Panda",
      apiName: 'panda',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Yoshimitsu",
      apiName: 'yoshimitsu',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Eddy",
      apiName: 'eddy',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Lidia",
      apiName: 'lidia',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Heihachi",
      apiName: 'heihachi',
      weakSide: "SSL",
      videoListMoves: [],
    ),
    const Character(
      name: "Clive",
      apiName: 'clive',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Anna",
      apiName: 'anna',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Fahkumram",
      apiName: 'fahkumram',
      weakSide: "SSR",
      videoListMoves: [],
    ),
    const Character(
      name: "Armor King",
      apiName: 'armor-king',
      weakSide: "SSR",
      videoListMoves: [],
    ),
  ];

  List<Character> getCharacters() => _characters;
}
