import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemService ownerServices = ItemService();
    Item item = Item(
        id: 'id',
        name: 'name',
        category: 'category',
        value: 0,
        description: '',
        disponibility: '');
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: ownerServices.getItems(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Text("Text" + docSnap[index].get('name'),
                          textAlign: TextAlign.left),
                      Text('Nome: ' + docSnap[index].get('name')),
                      Text('Descrição: ' + docSnap[index].get('description')),
                      Text('Categoria: ' + docSnap[index].get('category')),
                      Text('Valor: ' + docSnap[index].get('value')),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: docSnap.length,
              shrinkWrap: true,
              reverse: true,
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: const [
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text("Não há dados disponíveis"),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
