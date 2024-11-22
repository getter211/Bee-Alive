class SensorData {
  final int id;
  final double temperature;
  final double humidity;
  final DateTime timestamp;

  SensorData({
    required this.id,
    required this.temperature,
    required this.humidity,
    required this.timestamp,
  });

  // Método para crear una instancia de SensorData desde un JSON
  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      id: json['id'],
      temperature: json['temperature'].toDouble(),
      humidity: json['humidity'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  get isNotEmpty => null;

  // Método para convertir una instancia de SensorData a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temperature': temperature,
      'humidity': humidity,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
