import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:flutter/material.dart';

class RequestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addpedido(Request request, RestaurantCommand command) async {
    var requestMap = request.toMap();
    var requestRef = await _firestore
        .collection('comanda')
        .doc(command.id)
        .collection('pedido')
        .add(requestMap);
    request.id = requestRef.id;
  }

  getRequest(RestaurantCommand command) {
    var pedidoCollection =
        _firestore.collection('comanda').doc(command.id).collection('pedido');
    return pedidoCollection.snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRequests(
      RestaurantCommand command) async {
    var pedidoCollection =
        _firestore.collection('comanda').doc(command.id).collection('pedido');
    return await pedidoCollection.get();
  }

  deleteRequest(String id) {
    DocumentReference docRef = _firestore.collection('pedido').doc(id);
    docRef
        .delete()
        .whenComplete(() => debugPrint("Dados do $id deletado com sucesso!!"))
        .catchError((erro) => debugPrint("Erro ao deletar o $id -> $erro!!"));
  }

  updateRequest(Request request, RestaurantCommand command) {
    print(request.id);
    print('commandId: ${command.id}');
    DocumentReference docRef = _firestore
        .collection('comanda')
        .doc(command.id)
        .collection('pedido')
        .doc(request.id);
    docRef
        .update(request.toMap())
        .whenComplete(
            () => debugPrint("Dados do ${request.id} atualizado com sucesso!!"))
        .catchError((erro) =>
            debugPrint("Erro ao atualizar o ${request.id} -> $erro!!"));
  }
}
