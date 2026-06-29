import 'package:equatable/equatable.dart';

class LearnerModel extends Equatable {
  const LearnerModel({
    required this.name,
    required this.phone,
    required this.level,
    required this.wordsLearned,
  });

  final String name;
  final String phone;
  final String level;
  final int wordsLearned;

  @override
  List<Object?> get props => [name, phone, level, wordsLearned];
}
