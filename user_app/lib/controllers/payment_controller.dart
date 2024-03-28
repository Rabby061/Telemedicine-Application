import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as https;
import 'dart:convert';

class PaymentController {
      Map<String,dynamic>? paymentIntentData;

      Future<void> makePayment(
        {required String amount, required String currency}) async { 
      try {
        print('click2');
        paymentIntentData = await createPaymentIntent(amount, currency); 
        if (paymentIntentData != null) {
        
        await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
        
        
        
        
        merchantDisplayName: 'Rabby',
        customerId: paymentIntentData! ['customer'],
        paymentIntentClientSecret: paymentIntentData! ['client_secret'], 
        customerEphemeralKeySecret: paymentIntentData!['ephemeralkey'],
      ));
      print('click3');
      displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception: $e$s');
    }
  }
  displayPaymentSheet() async {
  try {
    print('click4');
    await Stripe.instance.presentPaymentSheet(); 
    print('click5');
    print("Payment Successful");
  } on Exception catch (e) {
    if (e is StripeException) {
  
    print("Error from Stripe: ${e.error.localizedMessage}"); 
    } else {
      print("Unforeseen error: ${e}");
    }
  
  } catch (e) {
    print("exception: $e");
  }
  }

  createPaymentIntent(String amount, String currency) async {
  try {
  Map<String,dynamic>body = {
    'amount': amount, 
    'currency': currency,
    'payment_method_types[]': 'card'
  };
  
  var response = await https.post(
  Uri.parse('https://api.stripe.com/v1/payment_intents'),
  body: body, 
  headers: {
    'Authorization': 'Bearer sk_test_51OFsCPE1fmwNrbV1IYGTtpCYxrk4PQKEJ57QQYttO5nFBJo69Flg42A8LJ0nN5K0NO8EcRVyga8reb56LdTF0k0u00FVoKRwhb',
    'Content-Type': 'application/x-www-form-urlencoded'
  });
  
  return jsonDecode(response.body);
  } catch (err) {
      print('err charging user: ${err.toString()}');
  }
  }
}