import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangent_test_solution/core/routing/navigation_services.dart';
import 'package:tangent_test_solution/core/routing/route_names.dart';
import 'package:tangent_test_solution/core/storage/storage_service.dart';

part 'states.dart';

class FindLearnersCubit extends Cubit<FindLearnersState> {
  final bool editMode;

  FindLearnersCubit({this.editMode = false}) : super(const FindLearnersInitial());

  Future<void> init() async {
    final savedName = await StorageService.getUserName();
    final savedPhone = await StorageService.getUserPhone();
    final hasData =
        (savedName?.isNotEmpty ?? false) && (savedPhone?.isNotEmpty ?? false);

    if (hasData && !editMode) {
      _goToConnections();
    } else {
      emit(const FindLearnersFormState());
    }
  }

  Future<void> submit(String name, String phone) async {
    HapticFeedback.mediumImpact();
    await StorageService.saveUserName(name);
    await StorageService.saveUserPhone(phone);
    _goToConnections();
  }

  void _goToConnections() {
    NavigationService.navigatorKey.currentState?.pushReplacementNamed(RouteName.connections);
  }
}
