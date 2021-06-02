import 'package:http_interceptor/http_interceptor.dart';

class WledHttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (!data.headers.keys.contains("Content-Length")) {
      data.headers["Content-Length"] = "${data.body.length}";
    }

    return data;
  }
}
