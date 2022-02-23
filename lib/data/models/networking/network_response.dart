part of '../networking.dart';
class NetworkResponse {
  final int? statusCode;
  final dynamic response;

  bool get isSuccess => statusCode != null && statusCode! ~/ 200 == 1;

  NetworkResponse(this.statusCode, [this.response]);
}