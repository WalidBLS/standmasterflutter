import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/api/api_service.dart';
import 'package:standmaster/data/get_me_response.dart';
import 'package:standmaster/data/sign_in_request.dart';
import 'package:standmaster/data/sign_in_response.dart';
import 'package:standmaster/data/sign_up_request.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<Null>> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    SignUpRequest body = SignUpRequest(
      name: name,
      email: email,
      password: password,
      role: role,
    );

    return _apiService.post(
      "register",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<SignInResponse>> signIn({
    required String email,
    required String password,
  }) async {
    SignInRequest body = SignInRequest(
      email: email,
      password: password,
    );

    return _apiService.post(
      "login",
      body.toJson(),
      (data) {
        SignInResponse signInResponse = SignInResponse.fromJson(data);
        return signInResponse;
      },
    );
  }

  Future<ApiResponse<GetMeResponse>> getMe() async {
    return _apiService.get<GetMeResponse>(
      "profile",
      null,
      (data) {
        GetMeResponse getMeResponse = GetMeResponse.fromJson(data);
        return getMeResponse;
      },
    );
  }
}
