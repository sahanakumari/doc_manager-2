part of 'home_bloc.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {
  const DoctorsLoading();
}
class DoctorsLoaded extends DoctorsState {
  final List<Doctor> doctors;
  final bool gridView;
  const DoctorsLoaded(this.doctors,this.gridView);

  @override
  List<Object> get props => [doctors,gridView];
}

class DoctorsError extends DoctorsState {
  final String message;

  const DoctorsError(this.message);

  @override
  List<Object> get props => [message];
}
