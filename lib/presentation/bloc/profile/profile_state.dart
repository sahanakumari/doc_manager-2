part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class DataLoading extends ProfileState{
  @override
  List<Object> get props => [];
}

class DataLoaded extends ProfileState{
  @override
  List<Object> get props => [];
}

class DataError extends ProfileState{
  @override
  List<Object> get props => [];
}

