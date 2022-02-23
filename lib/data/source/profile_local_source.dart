import 'package:doc_manager/core/services/db_helper.dart';
import 'package:doc_manager/data/models/doctor.dart';

abstract class ProfileLocalSource {
  Future<bool> saveDoctorData(Doctor doctor);
}

class ProfileLocalSourceImpl extends ProfileLocalSource {
  @override
  Future<bool> saveDoctorData(Doctor doctor) async {
    var doc = await DbHelper().addOrUpdateDoctor(doctor);
    if (doc != null) {
      return true;
    }

    return false;
  }
}
