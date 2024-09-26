import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_marketplace/models/address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserData {
  UserData(
      { this.email,
       this.password,
       this.name,
       this.id,
       this.cpf,
       this.confirmPassword});

  UserData.fromDocument(DocumentSnapshot document, this.email, this.password,
      this.name, this.id, this.cpf, this.confirmPassword) {
    final data = document.data() as Map<String, dynamic>;

    id = document.id;
    name = data['name'] as String;
    email = data['email'] as String;
    cpf = data['cpf'] as String;

    if (data.containsKey('address')) {
      address = Address.fromMap(data['address'] as Map<String, dynamic>);
    }
  }

  String? email;
  String? password;
  String? name;
  String? id;
  String? cpf;
  String? confirmPassword;

  bool admin = false;
  Address? address;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  CollectionReference get tokensReference => firestoreRef.collection('tokens');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address!.toMap(),
      if (cpf != null) 'cpf': cpf,
    };
  }

  void setAddress(Address newAddress) {
    address = newAddress;
    saveData();
  }

  void setCpf(String newCpf) {
    cpf = newCpf;
    saveData();
  }

  Future<void> saveToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await tokensReference.doc(token).set({
        'token': token,
        'updatedAt': FieldValue.serverTimestamp(),
        'platform': Platform.operatingSystem,
      });
    }
  }
}
