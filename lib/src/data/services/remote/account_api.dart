import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/models/user/user_model.dart';
import '../http/http.dart';

class AccountApi {
  AccountApi(this._http);

  final Http _http;

  Future<UserModel?> getAccount(String sessionId) async {
    final Either<HttpFailure, UserModel> result = await _http.request(
      '3/account',
      queryParameters: <String, String>{
        ...kQueryParameters,
        'session_id': sessionId,
      },
      onSuccess: (String responseBody) {
        final Map<String, dynamic> json = Map<String, dynamic>.from(
          jsonDecode(responseBody) as Map<dynamic, dynamic>,
        );

        return UserModel.fromJson(json);
      },
    );
    return result.when((_) => null, (UserModel user) => user);
  }
}
