class NetworkResponse {
  final int? statusCode;
  final dynamic response;

  bool get isSuccess => statusCode != null && statusCode! ~/ 200 == 1;

  NetworkResponse(this.statusCode, [this.response]);
}

class ErrorResponse implements Exception {
  final int? statusCode;
  final dynamic response;

  bool get appSideError => statusCode == null;

  bool get clientError => statusCode != null && statusCode! ~/ 400 == 1;

  String? get errorCode {
    if (clientError) {
      if (response is Map) {
        return response["errorCode"];
      }
    }
    return null;
  }

  String get errorMessage {
    if (appSideError) {
      return "$response";
    }
    if (clientError) {
      if (response is Map) {
        return response["errors"]
                ?.map((e) => "* ${e["message"]}")
                ?.toList()
                ?.join("\n") ??
            "unknownError";
      }
    }
    return "unknownError";
  }

  ErrorResponse([this.statusCode, this.response]);

  @override
  String toString() => "$response";
}
