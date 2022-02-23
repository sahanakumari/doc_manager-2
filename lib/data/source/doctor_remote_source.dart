import 'package:doc_manager/core/services/logger.dart';
import 'package:doc_manager/core/services/networking.dart';
import 'package:doc_manager/data/models/doctor.dart';
import 'package:doc_manager/data/models/networking.dart';

abstract class DoctorRemoteSource {

  Future<List<Doctor>> getDoctors(Map<String, dynamic> params);
}

class DoctorRemoteSourceImpl extends DoctorRemoteSource {
  final Networking networking;
  DoctorRemoteSourceImpl({ required this.networking});
  @override
  Future<List<Doctor>> getDoctors(Map<String, dynamic> params) {
    return networking.get(
      "/contacts",
      enableCaching: true,
      queryParams: {for (var e in params.keys) e: "${params[e]}"},
    ).then((value) {
      if (value.response is List) {
        appLog(value.response, tag: "DOC_RESPONSE");
        List<Doctor> items =
            value.response.map<Doctor>((e) => Doctor.fromJson(e))?.toList() ??
                [];
        return items;
      }
      throw ErrorResponse(value.statusCode, value.response);
    }).catchError((err) {
      throw err;
    });
  }
}
