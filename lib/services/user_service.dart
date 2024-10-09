import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/api/api_service.dart';
import 'package:standmaster/data/user_credit_send_request.dart';
import 'package:standmaster/data/user_details_response.dart';
import 'package:standmaster/data/user_edit_request.dart';
import 'package:standmaster/data/user_invite_request.dart';
import 'package:standmaster/data/user_list_response.dart';

class UserService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<UserListItem>>> list({int? kermesseId}) {
    return _apiService.get<List<UserListItem>>(
      "users",
      {
        'kermesse_id': kermesseId?.toString() ?? '',
      },
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }

  Future<ApiResponse<List<UserListItem>>> listInviteKermesse({
    required int kermesseId,
  }) {
    return _apiService.get<List<UserListItem>>(
      "kermesse/$kermesseId/users",
      null,
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }

  Future<ApiResponse<List<UserListItem>>> listChildren({
    int? kermesseId,
  }) {
    Map<String, String> params = {};
    if (kermesseId != null) {
      params['kermesse_id'] = kermesseId.toString();
    }
    return _apiService.get<List<UserListItem>>(
      "user/children",
      params,
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }

  Future<ApiResponse<UserDetailsResponse>> details({
    required int userId,
  }) async {
    return _apiService.get<UserDetailsResponse>(
      "user/$userId",
      null,
      (data) {
        UserDetailsResponse userDetailsResponse =
            UserDetailsResponse.fromJson(data);
        return userDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> edit({
    required int userId,
    required String password,
    required String newPassword,
  }) async {
    UserEditRequest body = UserEditRequest(
      password: password,
      newPassword: newPassword,
    );

    return _apiService.patch(
      "user/$userId",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> sendCredit({
    required int childId,
    required int amount,
  }) async {
    UserCreditSendRequest body = UserCreditSendRequest(
      childId: childId,
      amount: amount,
    );

    return _apiService.patch(
      "user/pay",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> invite({
    required String name,
    required String email,
  }) async {
    UserInviteRequest body = UserInviteRequest(
      name: name,
      email: email,
    );

    return _apiService.post(
      "user/invite",
      body.toJson(),
      (_) => null,
    );
  }
}
