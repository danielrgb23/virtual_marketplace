import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_marketplace/models/address.dart';

enum StoreStatus { closed, open, closing }

class Store {
  Store({
    required this.name,
    required this.image,
    required this.phone,
    required this.address,
    required this.opening,
    this.status = StoreStatus.closed,
  }) {
    updateStatus();
  }

  Store.fromDocument(DocumentSnapshot doc)
    : name = (doc.data() as Map<String, dynamic>?)?['name'] as String? ?? '',
      image = (doc.data() as Map<String, dynamic>?)?['image'] as String? ?? '',
      phone = (doc.data() as Map<String, dynamic>?)?['phone'] as String? ?? '',
      address = Address.fromMap((doc.data() as Map<String, dynamic>?)?['address'] as Map<String, dynamic>),
      opening = ((doc.data() as Map<String, dynamic>?)?['opening'] as Map<String, dynamic>? ?? {}).map((key, value) {
        final timesString = value as String?;

        if (timesString != null && timesString.isNotEmpty) {
          final splitted = timesString.split(RegExp("[:-]"));

          return MapEntry(
            key,
            {
              "from": TimeOfDay(
                hour: int.parse(splitted[0]),
                minute: int.parse(splitted[1]),
              ),
              "to": TimeOfDay(
                hour: int.parse(splitted[2]),
                minute: int.parse(splitted[3]),
              ),
            },
          );
        } else {
          return MapEntry(key, {});
        }
      }),
      status = StoreStatus.closed {
  updateStatus();
}


  String name;
  String image;
  String phone;
  Address address;
  Map<String, Map<String, TimeOfDay>> opening;
  StoreStatus status;

  String get addressText =>
      '${address.street}, ${address.number}${address.complement.isNotEmpty ? ' - ${address.complement}' : ''} - '
      '${address.district}, ${address.city}/${address.state}';

  String get openingText {
    return
      'Seg-Sex: ${formattedPeriod(opening['monfri'])}\n'
      'Sab: ${formattedPeriod(opening['saturday'])}\n'
      'Dom: ${formattedPeriod(opening['sunday'])}';
  }

  String formattedPeriod(Map<String, TimeOfDay>? period) {
    if (period == null || period.isEmpty) return "Fechada";
    final from = period['from'];
    final to = period['to'];
    return '${from?.formatted() ?? ''} - ${to?.formatted() ?? ''}';
  }

  String get cleanPhone => phone.replaceAll(RegExp(r"[^\d]"), "");

  void updateStatus() {
    final weekDay = DateTime.now().weekday;

    Map<String, TimeOfDay>? period;
    if (weekDay >= 1 && weekDay <= 5) {
      period = opening['monfri'];
    } else if (weekDay == 6) {
      period = opening['saturday'];
    } else {
      period = opening['sunday'];
    }

    final now = TimeOfDay.now();

    if (period == null || period.isEmpty) {
      status = StoreStatus.closed;
    } else if (period['from']!.toMinutes() < now.toMinutes() &&
        period['to']!.toMinutes() - 15 > now.toMinutes()) {
      status = StoreStatus.open;
    } else if (period['from']!.toMinutes() < now.toMinutes() &&
        period['to']!.toMinutes() > now.toMinutes()) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }

  String get statusText {
    switch (status) {
      case StoreStatus.closed:
        return 'Fechada';
      case StoreStatus.open:
        return 'Aberta';
      case StoreStatus.closing:
        return 'Fechando';
      default:
        return '';
    }
  }
}

extension TimeOfDayExtensions on TimeOfDay {
  int toMinutes() {
    return hour * 60 + minute;
  }

  String formatted() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
