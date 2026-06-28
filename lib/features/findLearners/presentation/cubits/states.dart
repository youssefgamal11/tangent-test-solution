import 'package:equatable/equatable.dart';

enum FindLearnersStatus { form, results }

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

class FindLearnersState extends Equatable {
  const FindLearnersState({
    required this.name,
    required this.phoneNumber,
    required this.agreedToShare,
    required this.status,
    required this.learners,
  });

  final String name;
  final String phoneNumber;
  final bool agreedToShare;
  final FindLearnersStatus status;
  final List<LearnerModel> learners;

  bool get isFormValid =>
      name.trim().isNotEmpty &&
      phoneNumber.trim().isNotEmpty &&
      agreedToShare;

  int get foundCount => learners.length;

  FindLearnersState copyWith({
    String? name,
    String? phoneNumber,
    bool? agreedToShare,
    FindLearnersStatus? status,
    List<LearnerModel>? learners,
  }) {
    return FindLearnersState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      agreedToShare: agreedToShare ?? this.agreedToShare,
      status: status ?? this.status,
      learners: learners ?? this.learners,
    );
  }

  @override
  List<Object?> get props =>
      [name, phoneNumber, agreedToShare, status, learners];
}
