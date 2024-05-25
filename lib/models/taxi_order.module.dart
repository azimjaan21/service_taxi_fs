class TaxiOrder {
  final int? id;
  final String phoneNumber;
  final String name;
  final String startLocation;
  final String finalLocation;
  final String comment;
  final String service;
  final String waitingTime;
  final DateTime orderTime;

  TaxiOrder({
    this.id,
    required this.phoneNumber,
    required this.name,
    required this.startLocation,
    required this.finalLocation,
    required this.comment,
    required this.service,
    required this.waitingTime,
    required this.orderTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'name': name,
      'startLocation': startLocation,
      'finalLocation': finalLocation,
      'comment': comment,
      'service': service,
      'waitingTime': waitingTime,
      'orderTime': orderTime.toIso8601String(),
    };
  }

  factory TaxiOrder.fromMap(Map<String, dynamic> map) {
    return TaxiOrder(
      id: map['id'],
      phoneNumber: map['phoneNumber'],
      name: map['name'],
      startLocation: map['startLocation'],
      finalLocation: map['finalLocation'],
      comment: map['comment'],
      service: map['service'],
      waitingTime: map['waitingTime'],
      orderTime: DateTime.parse(map['orderTime']),
    );
  }
}
