import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/api/api_service.dart';
import 'package:standmaster/data/stand_create_request.dart';
import 'package:standmaster/data/stand_details_response.dart';
import 'package:standmaster/data/stand_edit_request.dart';
import 'package:standmaster/data/stand_list_response.dart';

class StandService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<StandListItem>>> list({
    int? kermesseId,
    bool? isFree,
  }) {
    Map<String, String> params = {};
    if (kermesseId != null) {
      params['kermesse_id'] = kermesseId.toString();
    }
    if (isFree != null) {
      params['is_free'] = isFree.toString();
    }

    return _apiService.get<List<StandListItem>>(
      "stands",
      params,
      (data) {
        StandListResponse standListResponse = StandListResponse.fromJson(data);
        return standListResponse.stands;
      },
    );
  }

  Future<ApiResponse<StandDetailsResponse>> details({
    required int standId,
  }) async {
    return _apiService.get<StandDetailsResponse>(
      "stand/$standId",
      null,
      (data) {
        StandDetailsResponse standDetailsResponse =
            StandDetailsResponse.fromJson(data);
        return standDetailsResponse;
      },
    );
  }

  Future<ApiResponse<StandDetailsResponse>> current() async {
    return _apiService.get<StandDetailsResponse>(
      "stand/current",
      null,
      (data) {
        StandDetailsResponse standDetailsResponse =
            StandDetailsResponse.fromJson(data);
        return standDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required String type,
    required String name,
    required String description,
    required int price,
    required int stock,
  }) async {
    StandCreateRequest body = StandCreateRequest(
      type: type,
      name: name,
      description: description,
      price: price,
      stock: stock,
    );

    return _apiService.post(
      "stand",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required String name,
    required String description,
    required int price,
    required int stock,
  }) async {
    StandEditRequest body = StandEditRequest(
      name: name,
      description: description,
      price: price,
      stock: stock,
    );

    return _apiService.patch(
      "stand",
      body.toJson(),
      (_) => null,
    );
  }
}
