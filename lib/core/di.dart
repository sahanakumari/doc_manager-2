import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:doc_manager/data/repositories_impl/doctor_repo_impl.dart';
import 'package:doc_manager/data/repositories_impl/login_repo_impl.dart';
import 'package:doc_manager/data/repositories_impl/profile_repo_impl.dart';
import 'package:doc_manager/data/source/doctor_remote_source.dart';
import 'package:doc_manager/data/source/login_remote_source.dart';
import 'package:doc_manager/data/source/profile_local_source.dart';
import 'package:doc_manager/domain/repositories/doctor_repo.dart';
import 'package:doc_manager/domain/repositories/login_repo.dart';
import 'package:doc_manager/domain/repositories/profile_repo.dart';
import 'package:doc_manager/domain/use_case/doctors_use_case.dart';
import 'package:doc_manager/domain/use_case/login_use_case.dart';
import 'package:doc_manager/domain/use_case/profile_use_case.dart';
import 'package:doc_manager/presentation/bloc/Home/home_bloc.dart';
import 'package:doc_manager/presentation/bloc/Login/login_bloc.dart';
import 'package:doc_manager/presentation/bloc/Profile/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton(() => Connectivity());

  di.registerLazySingleton<NetworkConnectivity>(
    () => NetworkConnectivityImpl(di()),
  );

  di.registerFactory(
    () => HomeBloc(doctorsUseCase: di()),
  );
  di.registerFactory(
        () => ProfileBloc(di()),
  );

  di.registerLazySingleton(() => DoctorsUseCase(di()));
  di.registerLazySingleton(() => ProfileUseCase(di()));

  di.registerLazySingleton<DoctorRepo>(
    () => DoctorRepoImpl(remoteSource: di(), connectivity: di(), dbHelper: di()),
  );
  di.registerLazySingleton<ProfileRepo>(
        () => ProfileRepoImpl(localSource: di(), connectivity: di()),
  );
  di.registerLazySingleton<DoctorRemoteSource>(
    () => DoctorRemoteSourceImpl(networking: di()),
  );
  di.registerLazySingleton(() => FirebaseAuth.instance);
  di.registerLazySingleton(() => LoginUseCase(di()));

  di.registerFactory(
    () => LoginBloc(loginUseCase: di()),
  );
  di.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(remoteSource: di(), connectivity: di()),
  );

  di.registerLazySingleton<LoginRemoteSource>(
    () => LoginRemoteSourceImpl(firebaseAuth: di()),
  );
  di.registerLazySingleton<ProfileLocalSource>(
        () => ProfileLocalSourceImpl(),
  );
}
