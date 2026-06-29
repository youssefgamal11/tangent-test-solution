import 'package:equatable/equatable.dart';

class WordCard extends Equatable {
  final String word;
  final String partOfSpeech;
  final String pronunciation;
  final String definition;

  const WordCard({
    required this.word,
    required this.partOfSpeech,
    required this.pronunciation,
    required this.definition,
  });

  @override
  List<Object> get props => [word, partOfSpeech, pronunciation, definition];
}
