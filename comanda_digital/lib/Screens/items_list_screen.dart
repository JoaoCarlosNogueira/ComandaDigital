import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Screens/itemEdit_screen.dart';
import 'package:flutter/material.dart';

class ItemslistScreen extends StatelessWidget {
  const ItemslistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemService ownerServices = ItemService();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        stream: ownerServices.getItems(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                var item = Item(
                    id: (docSnap[index].id),
                    name: (docSnap[index].get('name')),
                    category: (docSnap[index].get('category')),
                    description: (docSnap[index].get('description')),
                    value: (docSnap[index].get('value')),
                    disponibility: (docSnap[index].get('disponibility')));
                return Card(
                  child: Column(
                    children: [
                      Text(item.id),
                      Text(item.name),
                      Text(item.description),
                      Text(item.category),
                      Text(item.value),
                      Text(item.disponibility),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ItemEditScreen(item: item)));
                        },
                        child: const Text(
                          'Editar Itens',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
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
