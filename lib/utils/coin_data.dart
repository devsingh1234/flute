import 'package:bitcoin_ticker_flutter/utils/app_constants.dart';
import 'package:bitcoin_ticker_flutter/utils/network_helper.dart';
import 'package:flutter/material.dart';

class CoinData {
  Future<dynamic> getCurrentRate({@required String fromCurrency, @required String toCurrency}) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$kBaseUrl/$fromCurrency/$toCurrency?apiKey=$kCoinApiKey');

    print('$kBaseUrl/$fromCurrency/$toCurrency?apiKey=$kCoinApiKey');

    var currencyData = await networkHelper.getData();
    print('Response : $currencyData');
    return currencyData;
  }


}
