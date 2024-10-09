import "dart:convert";

import "package:http/http.dart" as http;
import "package:stripe_checkout/stripe_checkout.dart";

class StripeService {
  final String _secretKey = "sk_test_51Q6ytDC4fIPQzkOE4wVVdh2EymfaKppA2vrNdpZiXv3jJsx4S7CH22GAWBxljbUiH9Ss0EiQMRii3WSxEytUYWVp00N8kjtZXu";
  final String _publishableKey = "pk_test_51Q6ytDC4fIPQzkOENpT2wXPZPkH3j0EtN0vLs2Qjsu4OKNV6AUYYN0gPgz9vCkL3H6K1ZQsFKmLcGSeSjxvUlPiA00mGW0xuht";

  Future<dynamic> createCheckoutSession(
    int userId,
    int credit,
  ) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

    String lineItems = "";
    lineItems += "&line_items[0][price_data][product_data][name]=Credit";
    lineItems += "&line_items[0][price_data][unit_amount]=1";
    lineItems += "&line_items[0][price_data][currency]=EUR";
    lineItems += "&line_items[0][quantity]=$credit";

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $_secretKey",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body:
          "success_url=https://example.com/success&mode=payment$lineItems&metadata[user_id]=$userId&metadata[credit]=$credit",
    );

    return json.decode(response.body)["id"];
  }

  Future<dynamic> stripePaymentCheckout(
    userId,
    credit,
    context, {
    onSuccess,
    onCancel,
    onError,
  }) async {
    final String checkoutId = await createCheckoutSession(
      userId,
      credit,
    );

    final result = await redirectToCheckout(
      context: context,
      sessionId: checkoutId,
      publishableKey: _publishableKey,
      successUrl: "https://example.com/success",
      canceledUrl: "https://example.com/cancel",
    );

    final text = result.when(
      redirected: () => "Redirected to checkout",
      success: () => onSuccess(),
      canceled: () => onCancel(),
      error: (e) => onError(e),
    );

    return text;
  }
}
