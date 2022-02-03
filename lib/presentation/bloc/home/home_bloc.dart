import 'package:bloc/bloc.dart';
import 'package:doc_manager/core/utils/constants.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/data/source/errors/failure.dart';
import 'package:doc_manager/domain/use_case/impl/doctors_use_case.dart';

import 'package:equatable/equatable.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<DoctorsEvent, DoctorsState> {
  final DoctorsUseCase doctorsUseCase;

  HomeBloc({required this.doctorsUseCase}) : super(DoctorsInitial());

  @override
  Stream<DoctorsState> mapEventToState(DoctorsEvent event) async* {
    if (event is DoctorsEventImpl) {
      yield* _mapToState(event);
    }
    else if(event is DoctorsChangeOrientation){
    yield DoctorsLoaded(event.doctors,event.isgridView);
    }
  }



  Stream<DoctorsState> _mapToState(DoctorsEventImpl event) async* {
    yield const DoctorsLoading();
    final failureOrAuthStatus = await doctorsUseCase(event.params);
    yield failureOrAuthStatus.fold(
      (failure) => DoctorsError(_failureToString(failure)),
      (data) => DoctorsLoaded(data,false),
    );
  }

  String _failureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
      case CacheFailure:
        return Constants.cacheError.toString();
      default:
        return Constants.unknownError;
    }
  }
}
