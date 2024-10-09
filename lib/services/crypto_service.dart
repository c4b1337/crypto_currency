import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class CryptoService {
  final String apiKey = 'D4DA212D-8676-4084-B006-8A97C3309DC9';

  Future<List<CryptoCurrency>> fetchCryptoData() async {
  final response = await http.get(
    Uri.parse('https://rest.coinapi.io/v1/exchangerate/USD?apikey=$apiKey'),
  );

  if (response.statusCode == 200) {
    print('Response body: ${response.body}');
    final List<dynamic> data = jsonDecode(response.body)['rates'];
    return data.map((json) => CryptoCurrency.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

}
