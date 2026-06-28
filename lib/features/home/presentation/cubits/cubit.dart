import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';

part 'states.dart';

class HomeCubit extends Cubit<HomeState> {
  final PageController pageController = PageController(viewportFraction: 0.75);

  static const _sessionWords = [
    WordCard(
      word: 'Altruistic',
      partOfSpeech: 'adjective',
      pronunciation: '/ æltruˈɪstɪk/',
      definition: 'Caring for others without expecting anything in return',
    ),
    WordCard(
      word: 'Ephemeral',
      partOfSpeech: 'adjective',
      pronunciation: '/ ɪˈfem(ə)r(ə)l/',
      definition: 'Lasting for a very short time',
    ),
    WordCard(
      word: 'Eloquent',
      partOfSpeech: 'adjective',
      pronunciation: '/ ˈeləkwənt/',
      definition: 'Fluent or persuasive in speaking or writing',
    ),
    WordCard(
      word: 'Resilient',
      partOfSpeech: 'adjective',
      pronunciation: '/ rɪˈzɪlɪənt/',
      definition: 'Able to recover quickly from difficulties',
    ),
    WordCard(
      word: 'Sanguine',
      partOfSpeech: 'adjective',
      pronunciation: '/ ˈsæŋɡwɪn/',
      definition: 'Optimistic, especially in a difficult situation',
    ),
  ];

  HomeCubit()
      : super(const HomeState(
          streak: 0,
          wordsCompleted: 1,
          dailyGoal: 5,
          weeklyProgress: [false, false, false, false, false, false, false],
          sessionWords: _sessionWords,
          currentCardIndex: 0,
        ));

  static String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  static List<bool> _buildWeeklyProgress(List<String> completedDates) {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(
      7,
      (i) => completedDates.contains(_dateKey(monday.add(Duration(days: i)))),
    );
  }

  static int _calculateStreak(List<String> completedDates) {
    int streak = 0;
    final now = DateTime.now();
    for (int i = 0; i < 365; i++) {
      if (completedDates.contains(_dateKey(now.subtract(Duration(days: i))))) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  Future<void> init() async {
    final completedDates = await StorageService.getCompletedDates();
    final todayKey = _dateKey(DateTime.now());
    final isNewDay = !completedDates.contains(todayKey);

    if (isNewDay) {
      completedDates.add(todayKey);
      await StorageService.saveCompletedDates(completedDates);
    }

    emit(state.copyWith(
      streak: _calculateStreak(completedDates),
      weeklyProgress: _buildWeeklyProgress(completedDates),
      showStreakToast: isNewDay,
    ));

  
  }

  void resetStreakToast() => emit(state.copyWith(showStreakToast: false));

  void onCardChanged(int index) => emit(state.copyWith(
        currentCardIndex: index,
        wordsCompleted: index + 1,
      ));

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
