import 'package:flutter/material.dart';

import '../../../models/Cardview.dart';
import '../../../models/NotificacionCard.dart';


class Colum extends StatelessWidget {
  const Colum({
    super.key,
    required this.Cards,
    required this.CardList,
  });

  final List Cards;
  final List CardList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 93),
        const Padding(
          padding: EdgeInsets.only(left: 21.0),
          child: Text(
            'Instituto Técnico Ricaldone',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
        ),
        const SizedBox(height: 25),
        Container(
          height: 160,
          child: ListView.builder(
              itemCount: Cards.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardviewScreen(
                  companyName: Cards[index][0],
                  JobTItle: Cards[index][1],
                  Logo: Cards[index][2],
                  hour: Cards[index][3],
                );
              }),
        ),
        const SizedBox(height: 30),
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text(
            'Notificaciones',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: ListView.builder(
              itemCount: CardList.length,
              itemBuilder: (context, index) {
                return NotificacionScreen(
                  companyName: CardList[index][0],
                  JobTItle: CardList[index][1],
                  Logo: CardList[index][2],
                  hour: CardList[index][3],
                  color: CardList[index][4],
                );
              }),
        )),
      ],
    );
  }
}
