class Address {
  Address(
      {required this.street,
      required this.number,
      required this.complement,
      required this.district,
      required this.zipCode,
      required this.city,
      required this.state,
      required this.lat,
      required this.longitude});  // Corrigido de long para longitude

  String street;
  String number;
  String complement;
  String district;
  String zipCode;
  String city;
  String state;
  double lat;
  double longitude;  // Corrigido de long para longitude

  Address.fromMap(Map<String, dynamic> map)
      : street = map['street'] as String,
        number = map['number'] as String,
        complement = map['complement'] as String,
        district = map['district'] as String,
        zipCode = map['zipCode'] as String,
        city = map['city'] as String,
        state = map['state'] as String,
        lat = map['lat'] as double,
        longitude = map['longitude'] as double;  // Corrigido aqui também

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'complement': complement,
      'district': district,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'lat': lat,
      'longitude': longitude,  // Corrigido aqui também
    };
  }
}
