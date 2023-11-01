import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';
import 'package:focusmi/constants/stripe_keys.dart';

class StripeService {
  static String secretKey = seckey.toString();
  static String pubKey = pubkey.toString();

  static Future<dynamic> createCheckoutSession(
    List<dynamic> productItems,
    totalAmount,
  ) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");
    String lineItems = "";
    int index = 0;

    productItems.forEach(
      (element) {
        var productPrice = ((element["productPrice"]) * 100).round().toString();
        lineItems +=
            "&line_items[$index][price_data][product_data][name]=${element['productName']}&line_items[$index][price_data][unit_amount]=$productPrice&line_items[$index][price_data][currency]=USD&line_items[$index][quantity]=${element['qty'].toString()}";
        index++;
      },
    );

    final response = await http.post(url,
        body:
            'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'Application/x-www-form-urlencoded'
        });
    print(json.decode(response.body));
    return json.decode(response.body)["id"];
  }

  static Future<dynamic> stripePaymentCheckout(
      productItems, subTotal, context, mounted,
      {onSuccess, onCancel, onError}) async {
    final String sessionID = await createCheckoutSession(
      productItems,
      subTotal,
    );

    final result = await redirectToCheckout(
        context: context,
        sessionId: sessionID,
        publishableKey: pubKey,
        successUrl: "https://checkout.stripe.dev/success",
        canceledUrl: "https://checkout.stripe.dev/cancel");
    if (mounted) {
      final text = result.when(
          redirected: () => 'Redirected Successfully',
          success: () => onSuccess(),
          canceled: () => onCancel(),
          error: (e) => onError(e));

      return text;
    }
  }
}
