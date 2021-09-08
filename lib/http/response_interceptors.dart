import 'package:dio/dio.dart';

///网络数据返回加工预处理
class ResponseInterceptors extends Interceptor {
  // 回调将在请求初始化之前执行。
  // 如果您想继续请求，请调用[handler.next]。
  // 如果您想用一些自定义数据完成请求，
  // 你可以使用[handler.resolve]解析[Response]对象。
  // 如果您想用错误消息完成请求，
  // 你可以使用[handler.reject]来拒绝[DioError]对象。
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print("HttpDataInterceptor  onRequest");
    super.onRequest(options, handler);
  }

  //

  // 回调将在成功时执行。
  // 如果想继续响应，请调用[handler.next]。
  // 如果您想用一些自定义数据直接完成响应，
  // 您可以使用[handler.resolve]解析[Response]对象，其他响应拦截器将不会被执行。
  // 如果您想用错误消息完成响应，
  // 你可以使用[handler.reject]来拒绝[DioError]对象。
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print("HttpDataInterceptor  onResponse");
    super.onResponse(response, handler);
  }

  //
  // 当出现错误时，回调函数将被执行。
  // 如果你想继续这个错误，调用[handler.next]。
  // 如果您想用一些自定义数据直接完成响应，
  // 您可以使用[handler.resolve]解析[Response]对象，而其他错误拦截器将被跳过。
  // 如果您想用错误消息直接完成响应，可以使用[handler.reject]拒绝[DioError]对象，其他错误拦截器将被跳过。
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("HttpDataInterceptor  onError");
    super.onError(err, handler);
  }
}
