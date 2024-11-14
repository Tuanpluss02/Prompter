import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:base/app/utils/log.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioClient {
  late Dio _dio;

  final String baseUrl;
  final String? token;
  final String? id;

  final List<Interceptor>? interceptors;

  DioClient(
    Dio dio, {
    required this.baseUrl,
    this.interceptors,
    this.token,
    this.id,
  }) {
    _dio = dio;

    _dio
      ..options.baseUrl = baseUrl
      ..options.headers = getHeader()
      ..options.connectTimeout = const Duration(seconds: 10)
      ..options.receiveTimeout = const Duration(seconds: 0)
      ..options.followRedirects = false
      ..options.receiveDataWhenStatusError = false
      ..httpClientAdapter;

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (
        RequestOptions options,
        RequestInterceptorHandler handler,
      ) {
        handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
    ));

    _dio.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          // All http responses enabled for console logging
          printResponseData: true,
          // All http requests disabled for console logging
          printRequestData: true,
          // Reposnse logs including http - headers
          printResponseHeaders: false,
          // Request logs without http - headersa
          printRequestHeaders: true,
        ),
      ),
    );
    _dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        // You can test the intermediate / root cert here. We just ignore it.
        client.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return client;
      },
    );
  }

  Map<String, dynamic> getHeader() {
    return {};
  }

  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      Log.console('Unable to process the data',
          where: 'GET $baseUrl$uri', level: LogLevel.error);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      Log.console('Unable to process the data',
          where: 'POST $baseUrl$uri', level: LogLevel.error);
    } on DioException catch (_) {
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      Log.console('Unable to process the data',
          where: 'PATCH $baseUrl$uri', level: LogLevel.error);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      Log.console('Unable to process the data',
          where: 'PUT $baseUrl$uri', level: LogLevel.error);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on FormatException catch (_) {
      Log.console('Unable to process the data',
          where: 'DELETE $baseUrl$uri', level: LogLevel.error);
    } catch (e) {
      rethrow;
    }
  }

  Stream<String> connectToSSE(String uri) async* {
    try {
      final response = await _dio.get<ResponseBody>(
        uri,
        options: Options(responseType: ResponseType.stream),
      );

      await for (var event in response.data!.stream.transform(
        StreamTransformer<Uint8List, String>.fromHandlers(
          handleData: (data, sink) {
            final decodedString = utf8.decode(data);
            sink.add(decodedString);
          },
        ),
      ).transform(const LineSplitter())) {
        if (event.isNotEmpty) {
          Log.console('SSE Event: $event');
          yield event;
        }
      }
    } catch (e) {
      Log.console('Failed to connect to SSE: ${e.toString()}');
      rethrow;
    }
  }
}

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.extra['start_time'] = DateTime.now().millisecondsSinceEpoch;
    return handler.next(options);
  }

  @override
  void onError(err, ErrorInterceptorHandler handler) {
    Log.console(err,
        where: '${err.requestOptions.method} ${err.requestOptions.uri}',
        level: LogLevel.error);
    // var msg = 'URI: ${err.requestOptions.uri}\\n';
    // msg += 'METHOD:${err.requestOptions.method}\\n';
    // msg += 'REQUEST HEADER:${err.requestOptions.headers.toString()}\\n';
    // if (err.response != null) {
    //   msg += 'STATUS CODE:${err.response?.statusCode?.toString()}\\n';
    // }
    // if (err.response != null) {
    //   msg += 'BODY:${err.response?.data.toString() ?? ''}\\n';
    // }
    // msg += 'ERROR: ${err.toString()}';
    // UDPLog.instance.sendMessage(_msg);

    return handler.next(err);
  }

  @override
  Future onResponse(response, ResponseInterceptorHandler handler) async {
    Log.console(response.data,
        where:
            '${response.requestOptions.method} ${response.requestOptions.uri}',
        level: LogLevel.info);
    if ((response.statusCode ?? 200) != 200) {
      // var msg = 'URI: ${response.requestOptions.uri}\\n';
      // msg += 'METHOD:${response.requestOptions.method}\\n';
      // msg += 'REQUEST HEADER:${response.requestOptions.headers.toString()}\\n';
      // msg += 'STATUS CODE:${response.statusCode ?? ''}\\n';
      // msg += 'BODY: ${response.data ?? ''}';
      //UDPLog.instance.sendMessage(_msg);
      //Log.d(_msg);
    } else {
      /// có kết quả trả về nhưng lớn hơn ??? giây
      var startTime = response.requestOptions.extra['start_time'] as int;
      if (DateTime.now().millisecondsSinceEpoch - startTime >= 2000) {
        // var _msg = 'URI: ${response.requestOptions.uri}\\n';
        // _msg += 'METHOD:${response.requestOptions.method}\\n';
        // _msg += 'REQUEST TIME :${DateTime.now().millisecondsSinceEpoch - startTime}ms\\n';
        // UDPLog.instance.sendMessage(_msg);
        // Log.d(_msg.toString());
      }
    }
    return handler.next(response);
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void logPrint(String s) {
    debugPrint(s);
  }
}
