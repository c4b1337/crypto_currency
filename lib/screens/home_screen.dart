import 'package:flutter/material.dart';
import 'package:flutter_web_project/models/crypto_model.dart';
import 'package:flutter_web_project/services/crypto_service.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final CryptoService _cryptoService = CryptoService();
  late Future<List<CryptoCurrency>> _cryptoList;
  String _selectedFilter = 'All'; 

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
        actions: [
          DropdownButton<String>(
            value: _selectedFilter,
            items: <String>['All', 'Top 10', 'Top 50']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
                // Apply filter logic here if needed
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCarousel(),
          Expanded(child: _buildCryptoList()),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      height: 200,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
          enlargeCenterPage: true,
        ),
        items: [
          'https://your-real-image-url.com/image1.jpg',
          'https://your-real-image-url.com/image2.jpg',
          'https://your-real-image-url.com/image3.jpg',
          'https://your-real-image-url.com/image4.jpg',
          'https://your-real-image-url.com/image5.jpg',
        ].map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: 1000.0,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: const Center(child: Text('Image not found')),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCryptoList() {
    return FutureBuilder<List<CryptoCurrency>>(
      future: _cryptoList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final cryptos = snapshot.data ?? [];
          return CryptoList(cryptos: cryptos);
        }
      },
    );
  }
}

class CryptoList extends StatelessWidget {
  final List<CryptoCurrency> cryptos;

  const CryptoList({Key? key, required this.cryptos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cryptos.length,
      itemBuilder: (context, index) {
        final crypto = cryptos[index];
        return CryptoListItem(crypto: crypto);
      },
    );
  }
}

class CryptoListItem extends StatelessWidget {
  final CryptoCurrency crypto;

  const CryptoListItem({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      child: ListTile(
        title: Text(crypto.name), 
        trailing: Text(            
          '\$${crypto.price.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
