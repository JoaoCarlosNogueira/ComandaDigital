import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:flutter/material.dart';

class ItemService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  add(Item item) async {
    var itemMap = item.toMap();
    // await _firestore.collection("itens").add(itemMap);
    _firestore.collection("itens").doc(item.id).set(itemMap);
  }

  getItems() {
    var employeeCollection = _firestore.collection("itens");
    return employeeCollection.snapshots();
  }

  Future<DocumentSnapshot> getItem(String itemId) async {
    var employeeCollection =
        await _firestore.collection("itens").doc(itemId).get();
    return employeeCollection;
  }

  deleteItem(String id) {
    DocumentReference docRef = _firestore.collection('itens').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  updateItem(Item item) {
    DocumentReference docRef = _firestore.collection('itens').doc(item.id);
    docRef
        .update(item.toMap())
        .whenComplete(
            () => debugPrint("Dado(s) do ${item.id} editato(s) com sucesso!!"))
        .catchError(
            (erro) => debugPrint("Erro ao deletar o ${item.id} -> $erro!!"));
  }
}
