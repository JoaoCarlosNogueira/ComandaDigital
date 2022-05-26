import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:flutter/material.dart';

class ItemslistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ItemService ownerServices = ItemService();
    Item item = Item(
        id: 'id',
        name: 'name',
        category: 'category',
        value: 'value',
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
                  child: Column(children: [
                    Text(docSnap[index].id),
                    Text(docSnap[index].get('name')),
                    Text(docSnap[index].get('description')),
                    Text(docSnap[index].get('category')),
                    Text(docSnap[index].get('value')),
                  ]),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: docSnap.length,
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
