import 'dart:developer';
import 'dart:io';

import 'package:base/common/localization/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error.dart';

part '../../../generated/domain/data/local/network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) = UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    ApiError? apiError;

    try {
      apiError = ApiError.fromJson(response?.data);
    } catch (e) {
      log('ApiError.fromJson error: $e', name: 'NetworkExceptions');
    }

    int statusCode = response?.statusCode ?? 0;
    switch (statusCode) {
      case 400:
        return const NetworkExceptions.badRequest();
      case 401:
        return const NetworkExceptions.badRequest();
      case 403:
        return const NetworkExceptions.badRequest();
      case 404:
        return NetworkExceptions.notFound(apiError?.message ?? tr(LocaleKeys.something_went_wrong));
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError(
          apiError?.message ?? tr(LocaleKeys.something_went_wrong),
        );
    }
  }

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.connectionError:
              networkExceptions = const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.badRequest();
              break;
            case DioExceptionType.unknown:
              networkExceptions = NetworkExceptions.handleResponse(error.response);
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = '';
    networkExceptions.when(notImplemented: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, requestCancelled: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, internalServerError: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, methodNotAllowed: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, badRequest: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, unauthorizedRequest: (String error) {
      errorMessage = error;
    }, unexpectedError: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, requestTimeout: () {
      errorMessage = tr(LocaleKeys.no_internet);
    }, noInternetConnection: () {
      errorMessage = tr(LocaleKeys.no_internet);
    }, conflict: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, sendTimeout: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, unableToProcess: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    }, notAcceptable: () {
      errorMessage = tr(LocaleKeys.something_went_wrong);
    });
    return errorMessage;
  }
}
