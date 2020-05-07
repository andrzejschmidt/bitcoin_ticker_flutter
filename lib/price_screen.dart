import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'rate_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String bitcoinRate = '? ';
  String ethereumRate = '? ';
  String litecoinRate = '? ';

  String selectedCurrency = currenciesList[0];
  CoinData coinData = CoinData();

  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    dynamic dataBTC = await coinData.getCoinData('BTC', selectedCurrency);
    dynamic dataETH = await coinData.getCoinData('ETH', selectedCurrency);
    dynamic dataLTC = await coinData.getCoinData('LTC', selectedCurrency);

    setState(() {
      bitcoinRate = dataBTC.toStringAsFixed(2);
      ethereumRate = dataETH.toStringAsFixed(2);
      litecoinRate = dataLTC.toStringAsFixed(2);
    });
  }

  CupertinoPicker iOSpicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
        });
        updateUI();
      },
      children: currenciesList
          .map((currency) => Text(
                currency,
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
          .toList(),
    );
  }

  DropdownButton androidPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      //with for in loop
      // items: [
      //   for (String currency in currenciesList)
      //     DropdownMenuItem(child: Text(currency), value: currency),
      // ],
      //or with map
      items: currenciesList
          .map(
            (currency) =>
                DropdownMenuItem(child: Text(currency), value: currency),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        updateUI();
      },
    );
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RateCard(
                crypto: 'BTC',
                rate: bitcoinRate,
                selectedCurrency: selectedCurrency,
              ),
              RateCard(
                crypto: 'ETH',
                rate: ethereumRate,
                selectedCurrency: selectedCurrency,
              ),
              RateCard(
                crypto: 'LTC',
                rate: litecoinRate,
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSpicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
