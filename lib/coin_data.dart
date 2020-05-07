import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

// class CoinData {
//   getExchangeRate() async {
//     NetworkHelper networkHelper = NetworkHelper(
//         //'https://rest.coinapi.io/v1/exchangerate/BTC/USD?&apiKey=$apiKey'
//         'https://blockchain.info/ticker');

//     return await networkHelper.getData();
//   }
// }

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '0DDC1C6A-A7AA-492C-B707-B62D4CAD42AF';

class CoinData {
  Future getCoinData(String crypto, String currency) async {
    //String requestURL = 'https://blockchain.info/ticker';
    String requestURL = '$coinAPIURL/$crypto/$currency?&apiKey=$apiKey';
    http.Response response = await http.get(requestURL);

    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      //var lastPrice = decodedData[currency]['last'];
      var lastPrice = decodedData['rate'];

      return lastPrice;
    } else {
      print(response.statusCode);

      throw 'Problem with the get request, code ${response.statusCode}';
    }
  }
}
