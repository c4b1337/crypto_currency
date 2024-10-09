import 'package:flutter/material.dart';
import 'package:flutter_web_project/screens/startpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Prices',
      home: CryptoListScreen(),
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final CryptoService _cryptoService = CryptoService();
  late Future<List<CryptoCurrency>> _cryptoList;

  @override
  void initState() {
    super.initState();
    _cryptoList = _cryptoService.fetchCryptoData();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreens(),
    );
  }
}
