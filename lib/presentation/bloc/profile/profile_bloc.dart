import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:doc_manager/data/models/models.dart';
import 'package:doc_manager/domain/use_case/impl/profile_use_case.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';


class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase profileUseCase;
  ProfileBloc(this.profileUseCase) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is SaveData) {
      yield* _mapToState(event);
    }
  }

  Stream<ProfileState> _mapToState(SaveData event) async* {
    yield DataLoading();
    final failureOrAuthStatus = await profileUseCase(event.doctors);
    yield failureOrAuthStatus.fold(
          (failure) => DataError(),
          (data) => DataLoaded(),
   );
  }


}
