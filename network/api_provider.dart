import 'package:dio/dio.dart';
import '../../../export.dart' hide FormData;
import 'dio_client.dart';
import 'endpoint.dart';
import 'network_exceptions.dart';

class APIRepository {
  static late DioClient? dioClient;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
  }

  /*===================================================================== login API Call  ==========================================================*/
  static Future loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['LoginForm[username]'] = "ranjansingh@gmail.com";
      data['LoginForm[password]'] = "12345678@";
      data['LoginForm[device_token]'] = "alphaBetaGamma";
      data['LoginForm[device_type]'] = 1;
      data['LoginForm[device_name]'] = " ";

      FormData formData = FormData.fromMap(data);
      final response = await dioClient!.post(loginEndPoint, data: formData);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
}
