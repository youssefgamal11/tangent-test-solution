part of 'cubit.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final bool showSkip;
  final String buttonLabel;
  final String userName;
  final List<String> selectedTopics;

  const OnboardingState({
    required this.currentPage,
    required this.showSkip,
    required this.buttonLabel,
    this.userName = '',
    this.selectedTopics = const [],
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? showSkip,
    String? buttonLabel,
    String? userName,
    List<String>? selectedTopics,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      showSkip: showSkip ?? this.showSkip,
      buttonLabel: buttonLabel ?? this.buttonLabel,
      userName: userName ?? this.userName,
      selectedTopics: selectedTopics ?? this.selectedTopics,
    );
  }

  @override
  List<Object> get props => [currentPage, showSkip, buttonLabel, userName, selectedTopics];
}
