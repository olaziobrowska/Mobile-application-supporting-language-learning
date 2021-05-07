import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:language_app/views/progress_view/testCardModel.dart';

class TestCard extends StatelessWidget {
  TestCard({this.testCard});

  final TestCardModel testCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(35, 35, 0, 0),
              child: Icon(Icons.lock),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(30, 35, 0, 0),
                child: Text(this.testCard.id.toString() + ".")),
            Container(
                margin: EdgeInsets.fromLTRB(10, 35, 0, 0),
                child: Text(this.testCard.name)),
            Container(
                margin: EdgeInsets.fromLTRB(30, 35, 0, 0),
                child: Text(this.testCard.percentage.toString() + " %")),
          ],
        ),
      ]),
    );
  }
}
