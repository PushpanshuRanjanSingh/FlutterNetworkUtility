// Package imports:
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:printreader/components/custom_flashbar.dart';
import 'package:printreader/constants/strings.dart';
import 'package:printreader/service/remote_service/entity/error_model/error_response_model.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return messageData = stringRequestCancelled;
            case DioErrorType.connectTimeout:
              return messageData = stringConnectionTimeout;
            case DioErrorType.other:
              List<String> dateParts = error.message.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == stringConnectionRefused) {
                return messageData = stringServerMaintenance;
              } else if (message[0].trim() == stringNetworkUnreachable) {
                return messageData = stringNetworkUnreachable;
              } else if (dateParts[1].trim() == stringFailedToConnect) {
                return messageData = stringInternetConnection;
              } else {
                return messageData = dateParts[1];
              }
            case DioErrorType.receiveTimeout:
              return messageData = stringTimeOut;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 400:
                  Map<String, dynamic> data = error.response!.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response!.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = dataValue!;
                      } else {
                        return messageData = stringUnAuthRequest;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }
                case 401:
                  toast('Please define method');
                  Map<String, dynamic> data = error.response!.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    if (data.values.elementAt(0) == "Unauthorized") {
                      return messageData = "Session expired";
                    } else {
                      return messageData = data.values.elementAt(0);
                    }
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response!.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = dataValue!;
                      } else {
                        return messageData = stringUnAuthRequest;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }
                case 403:
                  toast('Please define method');
                  Map<String, dynamic> data = error.response!.data;
                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response!.data)
                          .message;
                      if (dataValue == null) {
                        return messageData = dataValue!;
                      } else {
                        return messageData = stringUnAuthRequest;
                      }
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }

                case 404:
                  return messageData = stringNotFound;
                case 408:
                  return messageData = stringRequestTimeOut;
                case 500:
                  return messageData = stringInternalServerError;
                case 503:
                  return messageData = stringInternetServiceUnavail;
                default:
                  return messageData = stringSomethingsIsWrong;
              }
            case DioErrorType.sendTimeout:
              return messageData = stringTimeOut;
          }
        } else if (error is SocketException) {
          return messageData = socketExceptions;
        } else {
          return messageData = stringUnexpectedException;
        }
      } on FormatException catch (_) {
        return messageData = stringFormatException;
      } catch (_) {
        return messageData = stringUnexpectedException;
      }
    } else {
      if (error.toString().contains(stringNotSubtype)) {
        return messageData = stringUnableToProcessData;
      } else {
        return messageData = stringUnexpectedException;
      }
    }
  }
}
