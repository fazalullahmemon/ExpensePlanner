import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text('No transactions added yet',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.4,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover)),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                            child: Text('Rs ${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            color: Theme.of(context).errorColor,
                            icon: Icon(Icons.delete),
                            onPressed: () =>
                                deleteTransaction(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
