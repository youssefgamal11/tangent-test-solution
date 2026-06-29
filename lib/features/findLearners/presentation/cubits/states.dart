part of 'cubit.dart';

sealed class FindLearnersState extends Equatable {
  const FindLearnersState();
}

class FindLearnersInitial extends FindLearnersState {
  const FindLearnersInitial();
  @override
  List<Object?> get props => [];
}

class FindLearnersFormState extends FindLearnersState {
  const FindLearnersFormState();
  @override
  List<Object?> get props => [];
}
