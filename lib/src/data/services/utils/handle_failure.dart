import '../../../domain/either.dart';
import '../../../domain/failures/http_requets/http_request_failure.dart';
import '../http/http.dart';

Either<HttpRequestFailure, R> handleFailure<R>(HttpFailure httpFailure) {
  final HttpRequestFailure failure = () {
    final int? statusCode = httpFailure.statusCode;
    switch (statusCode) {
      case 404:
        return HttpRequestFailure.notFound();
      case 401:
        return HttpRequestFailure.unauthorized();
      default:
        if (httpFailure is NetworkException) {
          return HttpRequestFailure.network();
        }
        return HttpRequestFailure.unknow();
    }
  }();
  return Left<HttpRequestFailure, R>(failure);
}
