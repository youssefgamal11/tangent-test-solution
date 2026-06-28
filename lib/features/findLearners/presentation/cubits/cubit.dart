import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';
import 'states.dart';

class FindLearnersCubit extends Cubit<FindLearnersState> {
  static const _mockLearners = [
    LearnerModel(
      name: 'Sara K.',
      phone: '+20 101 *** ****',
      level: 'Intermediate',
      wordsLearned: 342,
    ),
    LearnerModel(
      name: 'Mohamed R.',
      phone: '+20 112 *** ****',
      level: 'Intermediate',
      wordsLearned: 289,
    ),
    LearnerModel(
      name: 'Nour A.',
      phone: '+20 115 *** ****',
      level: 'Intermediate',
      wordsLearned: 401,
    ),
    LearnerModel(
      name: 'Karim T.',
      phone: '+20 106 *** ****',
      level: 'Intermediate',
      wordsLearned: 217,
    ),
  ];

  FindLearnersCubit()
      : super(const FindLearnersState(
          name: '',
          phoneNumber: '',
          agreedToShare: false,
          status: FindLearnersStatus.form,
          learners: [],
        ));

  Future<void> init() async {
    final savedName = await StorageService.getUserName();
    final savedPhone = await StorageService.getUserPhone();

    final hasCompleteData = savedName != null &&
        savedName.isNotEmpty &&
        savedPhone != null &&
        savedPhone.isNotEmpty;

    if (hasCompleteData) {
      emit(state.copyWith(
        name: savedName,
        phoneNumber: savedPhone,
        agreedToShare: true,
        status: FindLearnersStatus.results,
        learners: _mockLearners,
      ));
    } else {
      emit(state.copyWith(
        name: savedName ?? '',
        phoneNumber: savedPhone ?? '',
      ));
    }
  }

  void updateName(String name) => emit(state.copyWith(name: name));

  void updatePhone(String phone) => emit(state.copyWith(phoneNumber: phone));

  void toggleAgreed() =>
      emit(state.copyWith(agreedToShare: !state.agreedToShare));

  Future<void> submit() async {
    HapticFeedback.mediumImpact();
    await StorageService.saveUserName(state.name);
    await StorageService.saveUserPhone(state.phoneNumber);
    emit(state.copyWith(
      status: FindLearnersStatus.results,
      learners: _mockLearners,
    ));
  }

  void resetToForm() => emit(state.copyWith(
        status: FindLearnersStatus.form,
        learners: [],
      ));
}
