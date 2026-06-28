import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/core/routing/navigation_services.dart';
import 'package:tangent_test_solution/core/routing/route_names.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';

part 'states.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final PageController pageController = PageController();

  static const int totalPages = 4;

  static const List<String> buttonLabels = [
    'Get started',
    'Continue',
    'Continue',
    'Start Learning',
  ];

  OnboardingCubit()
      : super(OnboardingState(
          currentPage: 0,
          showSkip: false,
          buttonLabel: buttonLabels[0],
        ));

  void onPageChanged(int index) => emit(state.copyWith(
        currentPage: index,
        showSkip: index == 1 || index == 2,
        buttonLabel: buttonLabels[index],
      ));

  void updateUserName(String name) => emit(state.copyWith(userName: name));

  void toggleTopic(String topic) {
    final updated = List<String>.from(state.selectedTopics);
    updated.contains(topic) ? updated.remove(topic) : updated.add(topic);
    emit(state.copyWith(selectedTopics: updated));
  }

  Future<void> nextPage() async {
    final page = state.currentPage;
    if (page == 1) await _saveUserName(state.userName);
    if (page == 2) await _saveSelectedTopics(state.selectedTopics);
    if (page == totalPages - 1) {
      await _saveOnboardingCompleted();
      NavigationService.navigatorKey.currentState?.pushNamedAndRemoveUntil(
       RouteName.homePage,
        (route) => false,
      );
      return;
    }
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skipToLast() => pageController.jumpToPage(totalPages - 1);

  Future<void> _saveUserName(String name) =>
      StorageService.setString('user_name', name);

  Future<void> _saveSelectedTopics(List<String> topics) =>
      StorageService.setStringList('selected_topics', topics);

  Future<void> _saveOnboardingCompleted() =>
      StorageService.setBool('onboarding_completed', true);

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
