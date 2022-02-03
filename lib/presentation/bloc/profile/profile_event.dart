part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class SaveData extends ProfileEvent{
  final Doctor doctors;

  SaveData(this.doctors,);

  @override
  List<Object> get props => [doctors];
}

