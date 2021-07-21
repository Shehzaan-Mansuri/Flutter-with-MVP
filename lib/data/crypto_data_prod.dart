import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_with_mvp/data/crypto_data.dart';

class ProdCryptoRepository implements CryptoRepository {
  var cryptoUrl = Uri.parse("https://api.coinmarketcap.com/v1/ticker/?limit=50");
  @override
  Future<List<Crypto>> fetchCurrencies() async {

    http.Response response = await http.get(Uri.https('api.coinmarketcap.com', 'v1/ticker/?limit=50'));
    final List responseBody = json.decode(response.body);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "An error occured : [Status Code : $statusCode]");
    }
    return responseBody.map((c) => new Crypto.fromMap(c)).toList();
  }
}