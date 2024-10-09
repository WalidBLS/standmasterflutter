import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/api/api_service.dart';
import 'package:standmaster/data/ticket_create_request.dart';
import 'package:standmaster/data/ticket_details_response.dart';
import 'package:standmaster/data/ticket_list_response.dart';

class TicketService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TicketListItem>>> list() {
    return _apiService.get<List<TicketListItem>>(
      "tickets",
      null,
      (data) {
        TicketListResponse ticketListResponse =
            TicketListResponse.fromJson(data);
        return ticketListResponse.tickets;
      },
    );
  }

  Future<ApiResponse<TicketDetailsResponse>> details({
    required int ticketId,
  }) async {
    return _apiService.get<TicketDetailsResponse>(
      "ticket/$ticketId",
      null,
      (data) {
        TicketDetailsResponse ticketDetailsResponse =
            TicketDetailsResponse.fromJson(data);
        return ticketDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required int tombolaId,
  }) async {
    TicketCreateRequest body = TicketCreateRequest(
      tombolaId: tombolaId,
    );

    return _apiService.post(
      "ticket",
      body.toJson(),
      (_) => null,
    );
  }
}
