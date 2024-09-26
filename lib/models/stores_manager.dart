import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_marketplace/models/store.dart';

// Remova a importação duplicada: 'package:virtual_marketplace/models/store.dart';

class StoresManager extends ChangeNotifier {

  StoresManager() {
    _loadStoreList();
    _startTimer();
  }

  List<Store> stores = [];

  Timer? _timer;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadStoreList() async {
    final snapshot = await firestore.collection('stores').get();

    stores = snapshot.docs.map((e) => Store.fromDocument(e)).toList();

    notifyListeners();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (final store in stores) {
      store.updateStatus();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
