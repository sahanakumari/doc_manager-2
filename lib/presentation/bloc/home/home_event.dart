part of 'home_bloc.dart';

abstract class DoctorsEvent extends Equatable {
  const DoctorsEvent();

  @override
  List<Object> get props => [];
}

class DoctorsEventImpl extends DoctorsEvent {
  final Map<String, dynamic> params;

  const DoctorsEventImpl(this.params);

  @override
  List<Object> get props => [params];
}

class DoctorsChangeOrientation extends DoctorsEvent {
  final List<Doctor> doctors;
  final bool isgridView;

  const DoctorsChangeOrientation(this.doctors,this.isgridView);

  @override
  List<Object> get props => [doctors];
}
