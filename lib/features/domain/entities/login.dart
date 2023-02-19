class LoginResponse {
  final int? id;
  final String? sign;
  final String? token;
  final bool? success;

  const LoginResponse({this.id, this.sign, this.token, this.success});
}

class LoginResponseData {
  final LoginResponse? data;
  final bool? success;
   const LoginResponseData({this.data, this.success});
}

