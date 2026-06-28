part of 'cubit.dart';

class HomeState extends Equatable {
  final int streak;
  final int wordsCompleted;
  final int dailyGoal;
  final List<bool> weeklyProgress;
  final List<WordCard> sessionWords;
  final int currentCardIndex;
  final bool showStreakToast;

  const HomeState({
    required this.streak,
    required this.wordsCompleted,
    required this.dailyGoal,
    required this.weeklyProgress,
    required this.sessionWords,
    required this.currentCardIndex,
    this.showStreakToast = false,
  });

  HomeState copyWith({
    int? streak,
    int? wordsCompleted,
    int? dailyGoal,
    List<bool>? weeklyProgress,
    List<WordCard>? sessionWords,
    int? currentCardIndex,
    bool? showStreakToast,
  }) {
    return HomeState(
      streak: streak ?? this.streak,
      wordsCompleted: wordsCompleted ?? this.wordsCompleted,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      sessionWords: sessionWords ?? this.sessionWords,
      currentCardIndex: currentCardIndex ?? this.currentCardIndex,
      showStreakToast: showStreakToast ?? this.showStreakToast,
    );
  }

  @override
  List<Object> get props => [
        streak,
        wordsCompleted,
        dailyGoal,
        weeklyProgress,
        sessionWords,
        currentCardIndex,
        showStreakToast,
      ];
}

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
