import 'package:dio/dio.dart';

class PlacesInterceptor extends Interceptor {
  final accessToken =
      'pk.eyJ1Ijoic2VqYXMyNCIsImEiOiJjbTA0MjEwNHYwM3gxMmpxMGZ6OXM4Z3A2In0.BlzNwtPEVmC6MbaC5FwK4w';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'autocomplete': true,
      'access_token': accessToken,
    });
    super.onRequest(options, handler);
  }
}
