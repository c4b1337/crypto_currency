import 'package:flutter/material.dart';
import 'package:flutter_web_project/models/crypto_model.dart';
import 'package:flutter_web_project/services/crypto_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
      ),
      body: FutureBuilder<List<CryptoCurrency>>(
        future: _cryptoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cryptos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                return ListTile(
                  title: Text(crypto.name),  // Назва зліва
                  trailing: Text(            // Ціна справа
                    '\$${crypto.price.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
