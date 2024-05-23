import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/src/utils/constants.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(BaseOptions(
          validateStatus: (status) {
            return true;
          },
          followRedirects: false,
        ));

  Future<Response<dynamic>> _makeRequest(
      Future<Response<dynamic>> Function() dioRequest) async {
    try {
      return await dioRequest.call();
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          throw noInternetExceptionText;

        case DioExceptionType.cancel:
          throw "Request cancelled";

        case DioExceptionType.unknown:
          throw "An unknown error occurred";

        case DioExceptionType.badResponse:
          if (e.response == null) throw "An unknown error occurred";
          switch (e.response!.statusCode) {
            case 409:
              return throw e.response!.data;
            case 401:
              return throw serverErrorMsg;
            case 404:
              throw "Resource not found";
            case 500:
              throw serverErrorMsg;
            default:
              throw 'Oops something went wrong';
          }

        default:
          throw "An unknown error occurred";
      }
    } catch (e) {
      debugPrint(e.toString());
      throw "An unknown error occurred";
    }
  }

  Future<Response<dynamic>> dioGet(url, {Options? options}) {
    return _makeRequest(() => _dio.get(url, options: options));
  }
}
