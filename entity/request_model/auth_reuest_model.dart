// Project imports:
class AuthRequestModel {
  static loginRequestData(
      {String? email,
      String? password,
      String? deviceToken,
      String? deviceType,
      String? deviceName}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LoginForm[username]'] = email;
    data['LoginForm[password]'] = password;
    data['LoginForm[device_token]'] = deviceToken;
    data['LoginForm[device_type]'] = deviceType;
    data['LoginForm[device_name]'] = deviceName;
    return data;
  }
}
