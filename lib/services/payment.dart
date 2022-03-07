import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:ecommerce/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeTransactionResponse {
  bool isSuccess;
  String message;

  StripeTransactionResponse({
    required this.isSuccess,
    required this.message,
  });
}

class StripePaymentServices {
  static String baseUrl = 'https://api.stripe.com/v1';
  static const String secretKey =
      'sk_test_51KZK7YCI0uxqciEYENMKPuwNDk6alwqrs62OCZ1MgYk5o4YilY8V5IigAA7nHn8ZQzCpdVlyzN3Zf6XEvzfzWABU00TKp7uc7I';
  static final client = http.Client();
  static Map<String, String> headers = {
    'Authorization': 'Bearer $secretKey',
    'Content-Type': 'application/x-www-form-urlencoded',
  };

  static void init() {
    Stripe.publishableKey =
        'pk_test_51KZK7YCI0uxqciEY8LD1cfBVT2lmucofaWBNwEZJ0Quf0cG5reSmNfH0uecO3BYqyrh3ATpyEVi95dlmD8vJZTGJ00ef9FZVNv';
  }

  static Future<Map<String, dynamic>> createCustomer() async {
    var response = await client.post(
      Uri.parse('https://api.stripe.com/v1/customers'),
      headers: headers,
      body: {
        'description': 'new customer',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(jsonDecode(response.body));
      throw 'Failed to register as a customer.';
    }
  }

  static Future<Map<String, dynamic>> createPaymentIntents({
    required String amount,
  }) async {
    final String url = '$baseUrl/payment_intents';

    Map<String, dynamic> body = {
      'amount': amount,
      'currency': 'usd',
      'payment_method_types[]': 'card'
    };

    var response =
        await client.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw 'Failed to create PaymentIntents.';
    }
  }

  static Future createCreditCard(
      String customerId, String paymentIntentClientSecret, context) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          style: ThemeMode.dark,
          primaryButtonColor: Colors.deepPurpleAccent,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: customerId,
          paymentIntentClientSecret: paymentIntentClientSecret,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (error) {
      customFlushBar(
        context: context,
        message: error.error.message!,
        title: 'Failed',
        backgroundColor: Colors.red,
      );
    } catch (error) {}
  }
}
