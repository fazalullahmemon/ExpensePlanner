import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String dayLabel;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.dayLabel, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrainsts) {
      return Column(
        children: [
          Container(
              height: constrainsts.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\Rs ${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(
            height: constrainsts.maxHeight * 0.05,
          ),
          Container(
            height: constrainsts.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(220, 220, 220, 1),
                        border: Border.all(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(20))),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constrainsts.maxHeight * 0.05,
          ),
          Container(
              height: constrainsts.maxHeight * 0.15, child: Text(dayLabel))
        ],
      );
    });
  }
}
