import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:flutter/material.dart';

class RestaurantCommandService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  add(RestaurantCommand command) async {
    var commandMap = command.toMap();
    var commandRef = await _firestore.collection("comanda").add(commandMap);
    command.id = commandRef.id;
  }

  getRestaurantCommand() {
    var commandCollection = _firestore.collection("comanda");
    return commandCollection.snapshots();
  }

  getRestaurantCommandsClosed() {
    var commandCollection = _firestore
        .collection("comanda")
        .where("condition", isEqualTo: "Fechada");
    return commandCollection.snapshots();
  }

  getRestaurantCommandOpen() {
    var commandCollection = _firestore
        .collection("comanda")
        .where("condition", isEqualTo: "Aberta");
    return commandCollection.snapshots();
  }

  deleteRestaurantCommand(String id) {
    DocumentReference docRef = _firestore.collection('comanda').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  updateRestaurantCommand(RestaurantCommand command) {
    print('PaymentForm: ${command.paymentForm}');
    DocumentReference docRef = _firestore.collection('comanda').doc(command.id);
    docRef
        .update(command.toMap())
        .whenComplete(
            () => debugPrint("Dados do ${command.id} alterados com sucesso!!"))
        .catchError(
            (erro) => debugPrint("Erro ao alterar o ${command.id} -> $erro!!"));
  }
}
