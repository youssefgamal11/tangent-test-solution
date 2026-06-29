import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/core/routing/navigation_services.dart';
import 'package:tangent_test_solution/core/routing/route_names.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';
import 'package:tangent_test_solution/features/shared/data/words_data.dart';
import 'package:tangent_test_solution/features/shared/models/word_card.dart';

part 'states.dart';

class HomeCubit extends Cubit<HomeState> {
  final PageController pageController = PageController(viewportFraction: 0.75);

  HomeCubit()
      : super(const HomeState(
          streak: 0,
          wordsCompleted: 1,
          dailyGoal: 5,
          weeklyProgress: [false, false, false, false, false, false, false],
          sessionWords: [],
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

    final selectedTopics = await StorageService.getSelectedTopics() ?? [];

    emit(state.copyWith(
      streak: _calculateStreak(completedDates),
      weeklyProgress: _buildWeeklyProgress(completedDates),
      showStreakToast: isNewDay,
      sessionWords: _pickDailyWords(selectedTopics, todayKey),
    ));
  }

  static List<WordCard> _pickDailyWords(
      List<String> selectedTopics, String dateKey) {
    final activeTopics = selectedTopics.isEmpty
        ? wordsByTopic.keys.toList()
        : selectedTopics.where(wordsByTopic.containsKey).toList();

    final pool = activeTopics
        .expand((t) => wordsByTopic[t] ?? <WordCard>[])
        .toList();

    if (pool.isEmpty) {
      return wordsByTopic.values.expand((w) => w).take(5).toList();
    }

    final seed = int.parse(dateKey.replaceAll('-', ''));
    return (List<WordCard>.from(pool)..shuffle(Random(seed))).take(5).toList();
  }

  void resetStreakToast() => emit(state.copyWith(showStreakToast: false));

  Future<void> navigateToFindLearners() async {
    final name = await StorageService.getUserName();
    final phone = await StorageService.getUserPhone();
    final hasData = (name?.isNotEmpty ?? false) && (phone?.isNotEmpty ?? false);
    NavigationService.navigatorKey.currentState?.pushNamed(
      hasData ? RouteName.connections : RouteName.findLearners,
    );
  }

  void onCardChanged(int index) {
    if (index + 1 == state.dailyGoal) HapticFeedback.heavyImpact();
    emit(state.copyWith(
      currentCardIndex: index,
      wordsCompleted: index + 1,
    ));
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
