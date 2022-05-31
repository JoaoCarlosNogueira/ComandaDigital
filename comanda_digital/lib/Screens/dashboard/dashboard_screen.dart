import 'package:comanda_digital/Screens/dashboard/itens_dashboard.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({Key? key}) : super(key: key);

  ItensDashboard item0 = ItensDashboard(
    event: '0',
    image: './assets/images/queue.png',
    title: "item",
  );

  ItensDashboard item1 = ItensDashboard(
      event: '0',
      image: './assets/images/restaurant.png',
      title: "Comanda",
      subtitle: "Adicionar, atualizar e deletar");

  @override
  Widget build(BuildContext context) {
    List<ItensDashboard> myList = [
      item0,
      item1,
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 600,
            child: GridView.builder(
              itemCount: myList.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.deepOrange,
                    ),
                    child: Column(children: [
                      Image.asset(myList[index].image!),
                      Text(myList[index].title!),
                    ]),
                  ),
                  onTap: () => call(context, index),
                );
              },
              shrinkWrap: true,
            ),
          ),
        ),
      ),
    );
  }

  call(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed('/additem');
    }

    if (index == 1) {
      Navigator.of(context).pushNamed('/addcomanda');
    }
  }
}
