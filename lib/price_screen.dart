import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedOps = 'USD';
  String p = '?';
  String p1 = '?';
  String p2 = '?';
  int i=0;

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> listAnd = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      listAnd.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedOps,
        items: listAnd,
        onChanged: (value) {
          setState(() {
            selectedOps = value;
            getPrice(cryptoList[0]);
            getPrice(cryptoList[1]);
            getPrice(cryptoList[2]);
          });
        });
  }

  CupertinoPicker iosDropdown() {
    List<Text> listIos = [];
    for (String currency in currenciesList) {
      listIos.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: listIos,
    );
  }
 bool isWaiting=false;
  void getPrice(String c) async {
    try {
      isWaiting=true;
      double price = await CoinData().getCoinData(selectedOps,c);
      isWaiting=false ;
      setState(() {
        if(c=='BTC')
           p = price.toStringAsFixed(0);
        else if(c=='ETH')
           p1 = price.toStringAsFixed(0);
        else if(c=='LTC')
           p2 = price.toStringAsFixed(0);

      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPrice(cryptoList[0]);
    getPrice(cryptoList[1]);
    getPrice(cryptoList[2]);
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: NewWidget(i: 0, p: isWaiting?'Getting':p , selectedOps: selectedOps),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: NewWidget(i: 1, p:  isWaiting?'Getting':p1, selectedOps: selectedOps),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: NewWidget(i:2 , p:  isWaiting?'Getting':p2, selectedOps: selectedOps),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropdown() : iosDropdown(),
          )
        ],
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
    @required this.i,
    @required this.p,
    @required this.selectedOps,
  }) : super(key: key);

  final int i;
  final String p;
  final String selectedOps;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 ${cryptoList[i]} = $p $selectedOps',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
