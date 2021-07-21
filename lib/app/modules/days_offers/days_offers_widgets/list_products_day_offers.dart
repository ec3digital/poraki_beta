import 'package:flutter/material.dart';
import 'package:poraki/app/modules/days_offers/days_offers_controller.dart';

class ListProductsDayOffers extends StatelessWidget {
  final DaysOffersController controller;
  ListProductsDayOffers({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(top: 5, right: 5, left: 5),
                child: Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        child: Image.asset('assets/images/iphone.png'),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          "Nome Produto",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "R\$ 1.000,00",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: Text(
                          "Cep: 05735030",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 3),
                        child: Text(
                          "Vendedor",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
