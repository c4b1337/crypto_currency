class CryptoCurrency {
  final String name;  // Name of the cryptocurrency (e.g., BTC, ETH)
  final double price; // Current price of the cryptocurrency

  // Constructor
  CryptoCurrency({required this.name, required this.price});

  // Factory constructor to create an instance from a JSON map
  factory CryptoCurrency.fromJson(Map<String, dynamic> json) {
    return CryptoCurrency(
      name: json['asset_id_quote'] ?? 'Unknown',  // Use asset_id_quote for the currency name
      price: (json['rate'] as num?)?.toDouble() ?? 0.0, // Use rate for the price, with a default of 0.0
    );
  }
}
