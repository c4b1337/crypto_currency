class CryptoCurrency {
  final String name;
  final double price;

  CryptoCurrency({required this.name, required this.price});

  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      name: json['asset_id_quote'] ?? 'Unknown',  // Використовуємо asset_id_quote для назви валюти
      price: (json['rate'] as num?)?.toDouble() ?? 0.0,  // Використовуємо rate для ціни
    );
  }
}
