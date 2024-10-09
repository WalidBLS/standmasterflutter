import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/api/api_service.dart';
import 'package:standmaster/data/kermesse_create_request.dart';
import 'package:standmaster/data/kermesse_details_response.dart';
import 'package:standmaster/data/kermesse_edit_request.dart';
import 'package:standmaster/data/kermesse_list_response.dart';
import 'package:standmaster/data/kermesse_stand_invite_request.dart';
import 'package:standmaster/data/kermesse_user_invite_request.dart';

class KermesseService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<KermesseListItem>>> list() {
    return _apiService.get<List<KermesseListItem>>(
      "kermesses",
      null,
      (data) {
        KermesseListResponse kermesseListResponse =
            KermesseListResponse.fromJson(data);
        return kermesseListResponse.kermesses;
      },
    );
  }

  Future<ApiResponse<KermesseDetailsResponse>> details({
    required int kermesseId,
  }) async {
    return _apiService.get<KermesseDetailsResponse>(
      "kermesse/$kermesseId",
      null,
      (data) {
        KermesseDetailsResponse kermesseDetailsResponse =
            KermesseDetailsResponse.fromJson(data);
        return kermesseDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required String name,
    required String description,
  }) async {
    KermesseCreateRequest body = KermesseCreateRequest(
      name: name,
      description: description,
    );

    return _apiService.post(
      "kermesse",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required int id,
    required String name,
    required String description,
  }) async {
    KermesseEditRequest body = KermesseEditRequest(
      name: name,
      description: description,
    );

    return _apiService.patch(
      "kermesse/$id",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> end({required int id}) async {
    return _apiService.patch(
      "kermesse/$id/finish",
      "",
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> inviteStand({
    required int kermesseId,
    required int standId,
  }) async {
    KermesseStandInviteRequest body = KermesseStandInviteRequest(
      standId: standId,
    );

    return _apiService.patch(
      "kermesse/$kermesseId/addstand",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> inviteUser({
    required int kermesseId,
    required int userId,
  }) async {
    KermesseUserInviteRequest body = KermesseUserInviteRequest(
      userId: userId,
    );

    return _apiService.patch(
      "kermesse/$kermesseId/adduser",
      body.toJson(),
      (_) => null,
    );
  }
}
