
import 'dart:convert';
import 'package:http/http.dart'as http;

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

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '4D2EC3FC41A3470FB505DA908FBA8CA7';

class CoinData {
   Future getCoinData(String s,String c) async {
     String requestURL = '$coinAPIURL/$c/$s?apikey=$apiKey';
     http.Response response = await http.get(requestURL);

      //7. Use the 'dart:convert' package to decode the JSON data that comes back from coinapi.io.
     if(response.statusCode==200)
       {
         var decodedData = jsonDecode(response.body);
         //8. Get the last price of bitcoin with the key 'last'.
         var lastPrice = decodedData['rate'];
         //9. Output the lastPrice from the method.
         return lastPrice;
       }
     else {
       print(response.statusCode);
       throw 'Problem with the get request';
     }



  }
}

