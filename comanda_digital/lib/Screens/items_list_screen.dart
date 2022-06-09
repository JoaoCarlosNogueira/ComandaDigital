import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/item.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Screens/itemEditScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ItemslistScreen extends StatelessWidget {
  const ItemslistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemService itemService = ItemService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listagem de Itens'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemService.getItems(),
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
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Card(
                    color: Colors.orange[200],
                    elevation: 10,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Código:" + item.id),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Item: " + item.name),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Descrição: " + item.description),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Categoria: " + item.category),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Value" + item.value.toString()),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Disponibilidade:" + item.disponibility),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red[400],
                              foregroundColor: Colors.white,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                ),
                                alignment: Alignment.centerRight,

                                // ignore: avoid_returning_null_for_void
                                onPressed: () {
                                  itemService.deleteItem(item.id);
                                  Fluttertoast.showToast(
                                    msg: "Produto deletado com Sucesso!",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: const Color(0x55000000),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
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
