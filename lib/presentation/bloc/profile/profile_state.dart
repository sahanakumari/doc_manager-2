part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class DataLoading extends ProfileState{}

class DataLoaded extends ProfileState{}

class DataError extends ProfileState{}

