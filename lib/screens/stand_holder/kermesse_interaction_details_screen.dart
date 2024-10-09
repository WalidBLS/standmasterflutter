import 'package:flutter/material.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/interaction_details_response.dart';
import 'package:standmaster/services/interaction_service.dart';
import 'package:standmaster/widgets/screen.dart';
import 'package:standmaster/widgets/text_input.dart';

class KermesseInteractionDetailsScreen extends StatefulWidget {
  final int kermesseId;
  final int interactionId;

  const KermesseInteractionDetailsScreen({
    super.key,
    required this.kermesseId,
    required this.interactionId,
  });

  @override
  State<KermesseInteractionDetailsScreen> createState() =>
      _KermesseInteractionDetailsScreenState();
}

class _KermesseInteractionDetailsScreenState
    extends State<KermesseInteractionDetailsScreen> {
  final Key _key = UniqueKey();
  final TextEditingController _pointController = TextEditingController();

  final InteractionService _interactionService = InteractionService();

  Future<InteractionDetailsResponse> _get() async {
    ApiResponse<InteractionDetailsResponse> response =
        await _interactionService.details(
      interactionId: widget.interactionId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _end() async {
    ApiResponse<Null> response = await _interactionService.end(
      interactionId: widget.interactionId,
      point: int.parse(_pointController.text),
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Interaction ended successfully'),
        ),
      );
      _refresh();
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Interaction Details",
          ),
          FutureBuilder<InteractionDetailsResponse>(
            key: _key,
            future: _get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
              if (snapshot.hasData) {
                InteractionDetailsResponse data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.id.toString()),
                    Text(data.type),
                    Text(data.status),
                    Text(data.user.name),
                    Text(data.credit.toString()),
                    Text(data.kermesse.name),
                    Text(data.stand.name),
                    data.type == "ACTIVITY" && data.status == "STARTED"
                        ? Column(
                            children: [
                              TextInput(
                                controller: _pointController,
                                defaultValue: "0",
                                hintText: "Point",
                              ),
                              ElevatedButton(
                                onPressed: _end,
                                child: const Text("End"),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            },
          ),
        ],
      ),
    );
  }
}
