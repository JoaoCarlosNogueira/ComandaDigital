import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comanda_digital/Model/units/itemservice.dart';
import 'package:comanda_digital/Model/units/request.dart';
import 'package:comanda_digital/Model/units/request_service.dart';
import 'package:comanda_digital/Model/units/restaurant_command.dart';
import 'package:comanda_digital/Model/units/restaurante_command_service.dart';
import 'package:comanda_digital/RestaurantCommandListScreen.dart';
import 'package:flutter/material.dart';
import '../Model/units/item.dart';

class RequestAddScreen extends StatefulWidget {
  final RestaurantCommand command;
  const RequestAddScreen({Key? key, required this.command}) : super(key: key);
  @override
  State<RequestAddScreen> createState() => RequestAddScreenState();
}

class RequestAddScreenState extends State<RequestAddScreen> {
  final GlobalKey<ScaffoldState> Keyzinho = GlobalKey<ScaffoldState>();
  ItemService itemService = ItemService();
  RequestService requestService = RequestService();
  RestaurantCommandService serviceCommand = RestaurantCommandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keyzinho,
      appBar: AppBar(
        title: const Text('Tela de pedidos'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: itemService.getItems(),
        builder: (BuildContext context, snapshot) {
          //Stream<QuerySnapshot<Object?>>
          if (snapshot.hasData) {
            List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return ListView.separated(
              itemBuilder: (context, index) {
                var item = Item(
                    id: (docSnap[index].id),
                    name: (docSnap[index].get('name')),
                    category: (docSnap[index].get('category')),
                    value: (docSnap[index].get('value')),
                    description: (docSnap[index].get('description')),
                    disponibility: '');

                final GlobalKey<FormState> formKey = GlobalKey<FormState>();
                Request request = Request(
                  id: '',
                  quantity: 0,
                  subtotal: 0,
                  item: item,
                );
                return Card(
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      Text(
                        item.id,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.start),
                      Text(item.id),
                      Text(item.name),
                      Text(item.category),
                      Text(item.description),
                      Text(item.value.toString()),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        onSaved: (quantity) =>
                            request.quantity = int.parse(quantity!),
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Quantidade de Pedido'),
                        validator: (value) {
                          if (value == null) {
                            return 'Digite um valor valor válido';
                          } else if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          formKey.currentState!.save();
                          request.subtotal = item.value * request.quantity;
                          requestService.addpedido(request, widget.command);

                          for (int i = 0;
                              i < widget.command.requests!.length;
                              i++) {
                            widget.command.total = widget.command.total +
                                widget.command.requests![i].subtotal;
                          }
                          serviceCommand
                              .updateRestaurantCommand(widget.command);
                        },
                        child: const Text(
                          'Adicionar Pedido',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CommandListScreen()));
                        },
                        child: const Text(
                          'Comandas Abertas',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                          textStyle: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ]),
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
