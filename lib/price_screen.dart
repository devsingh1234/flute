import 'dart:io' show Platform;
import 'package:bitcoin_ticker_flutter/utils/app_constants.dart';
import 'package:bitcoin_ticker_flutter/utils/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _mSelectedValue = 'USD';
  int _mSelectedIndex = -1;
  String _mBitcoinRate = '?';
  String _mEthereumRate = '?';
  String _mLitecoinRate = '?';
  String _mDogecoinRate = '?';
  CoinData _mCoinData = CoinData();

  ///Android drop down list
  DropdownButton<String> getAndroidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: _mSelectedValue,
      items: dropDownItems,
      onChanged: (value) async {
        setState(() {
          _mSelectedValue = value;
        });
        getBitcoinRate();
      },
    );
  }

  Future<void> getBitcoinRate() async {
    var bitcoin = await _mCoinData.getCurrentRate(fromCurrency: kCryptoList[0], toCurrency: _mSelectedValue);
    updateUi(bitcoin);

    var ethereum = await _mCoinData.getCurrentRate(fromCurrency: kCryptoList[1], toCurrency: _mSelectedValue);
    updateUi(ethereum);

    var litecoin = await _mCoinData.getCurrentRate(fromCurrency: kCryptoList[2], toCurrency: _mSelectedValue);
    updateUi(litecoin);

    var dogecoin = await _mCoinData.getCurrentRate(fromCurrency: kCryptoList[3], toCurrency: _mSelectedValue);
    updateUi(dogecoin);
  }

  ///Cupertino picker for iOS
  NotificationListener iOsPicker() {
    List<Text> cupertinoItems = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      cupertinoItems.add(newItem);
    }

    return NotificationListener<ScrollNotification> (
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification) {
          print(_mSelectedIndex);
          _mSelectedValue = currenciesList[_mSelectedIndex];
          getBitcoinRate();
          return true;
        } else {
          return false;
        }
      },
      child: CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        magnification: 1.2,
        scrollController: FixedExtentScrollController(initialItem: 19),
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            _mSelectedIndex = selectedIndex;
          });
        },
        children: cupertinoItems,
      ),
    );
  }

  ///update ui after api calling
  void updateUi(dynamic newData) {
    setState(() {
      var currency = newData['asset_id_base'];
      if (currency == kCryptoList[0]) {
        _mBitcoinRate = newData['rate'].toStringAsFixed(1);
      } else if(currency == kCryptoList[1]) {
        _mEthereumRate = newData['rate'].toStringAsFixed(1);
      } else if(currency == kCryptoList[2]) {
        _mLitecoinRate = newData['rate'].toStringAsFixed(1);
      } else if(currency == kCryptoList[3]) {
        _mDogecoinRate = newData['rate'].toStringAsFixed(1);
      }
      print('current rate : $_mBitcoinRate');
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              /// bitcoin
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 Bitcoin = $_mBitcoinRate $_mSelectedValue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// Ethereum
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 Ethereum = $_mEthereumRate $_mSelectedValue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// Litecoin
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 Litecoin = $_mLitecoinRate $_mSelectedValue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              /// Dogecoin
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 Dogecoin = $_mDogecoinRate $_mSelectedValue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOsPicker() : getAndroidDropDownButton()),
        ],
      ),
    );
  }
}
