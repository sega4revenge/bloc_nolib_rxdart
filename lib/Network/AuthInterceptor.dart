import 'package:dio/dio.dart';
import 'package:wallpaper/Application/main.dart';

import 'TypeDecodable.dart';

class AuthToken implements Decodable<AuthToken> {

  String? accessToken;
  String? refreshToken;
  int? expiredTime;

  AuthToken({ this.accessToken, this.refreshToken, this.expiredTime });

  @override
  AuthToken decode(dynamic data) {
    expiredTime = data['expired_time'];
    return this;
  }

  Future startRefreshToken() async {
    await Future.delayed(Duration(seconds: 5));
    // assign new access token
    accessToken = 'eyadfj9803924jjdfkasjdfjsdf';
  }

  bool isExpired() {
    return true;
  }
}


class AuthInterceptor extends InterceptorsWrapper {

  @override
  Future onRequest(
    RequestOptions options, 
    RequestInterceptorHandler handler
  ) async {
    final token = spUtil?.getString("token");
    if (token != null) {
      options.headers['Authorization'] = token;
    }


    return super.onRequest(options, handler);

  }

}