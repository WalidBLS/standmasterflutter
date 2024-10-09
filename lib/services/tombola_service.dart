import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/api/api_service.dart';
import 'package:standmaster/data/tombola_create_request.dart';
import 'package:standmaster/data/tombola_details_response.dart';
import 'package:standmaster/data/tombola_edit_request.dart';
import 'package:standmaster/data/tombola_list_response.dart';

class TombolaService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TombolaListItem>>> list({int? kermesseId}) {
    return _apiService.get<List<TombolaListItem>>(
      "tombolas",
      {
        'kermesse_id': kermesseId?.toString() ?? '',
      },
      (data) {
        TombolaListResponse tombolaListResponse =
            TombolaListResponse.fromJson(data);
        return tombolaListResponse.tombolas;
      },
    );
  }

  Future<ApiResponse<TombolaDetailsResponse>> details({
    required int tombolaId,
  }) async {
    return _apiService.get<TombolaDetailsResponse>(
      "tombola/$tombolaId",
      null,
      (data) {
        TombolaDetailsResponse tombolaDetailsResponse =
            TombolaDetailsResponse.fromJson(data);
        return tombolaDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required int kermesseId,
    required String name,
    required int price,
    required String gift,
  }) async {
    TombolaCreateRequest body = TombolaCreateRequest(
      kermesseId: kermesseId,
      name: name,
      price: price,
      gift: gift,
    );

    return _apiService.post(
      "tombola",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required int id,
    required String name,
    required int price,
    required String gift,
  }) async {
    TombolaEditRequest body = TombolaEditRequest(
      name: name,
      price: price,
      gift: gift,
    );

    return _apiService.patch(
      "tombola/$id",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> end({required int tombolaId}) async {
    return _apiService.patch(
      "tombola/$tombolaId/finish",
      "",
      (_) => null,
    );
  }
}
