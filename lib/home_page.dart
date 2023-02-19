import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gsheet_credentials.dart';
import 'loading_circle.dart';
import 'plus_button.dart';
import 'top_card.dart';
import 'transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // collect user input
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isIncome = false;

  // enter the new transaction into the spreadsheet
  void _enterTransaction() {
    GoogleSheetsApi.insert(
      _textcontrollerITEM.text,
      _textcontrollerAMOUNT.text,
      _isIncome,
    );
    setState(() {});
  }

  void _deleteTransaction(int index) {
    setState(() {
      GoogleSheetsApi.deleteUser(index + 2);
      GoogleSheetsApi.currentTransactions.removeAt(index);
    });
  }

  // new transaction
  void _newTransaction() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: Colors.indigo.shade400,
              title: const Text('NEW  TRANSACTION',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Expense',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        Switch(
                          inactiveThumbColor: Colors.redAccent,
                          activeColor: Colors.greenAccent,
                          value: _isIncome,
                          onChanged: (newValue) {
                            setState(() {
                              _isIncome = newValue;
                            });
                          },
                        ),
                        const Text('Income',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Amount?',
                              ),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Enter an amount';
                                }
                                return null;
                              },
                              controller: _textcontrollerAMOUNT,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'For what?',
                            ),
                            controller: _textcontrollerITEM,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.grey[600],
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                MaterialButton(
                  color: Colors.grey[600],
                  child: const Text('Enter',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _enterTransaction();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  // wait for the data to be fetched from google sheets
  bool timerHasStarted = false;
  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (GoogleSheetsApi.loading == false) {
          setState(() {});
          timer.cancel();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true && timerHasStarted == false) {
      startLoading();
    }

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          "EXPENSE TRACKE₹",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: 35,
        backgroundColor: Colors.indigo,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TopNeuCard(
                balance: (GoogleSheetsApi.calculateIncome() -
                        GoogleSheetsApi.calculateExpense())
                    .toString(),
                income: GoogleSheetsApi.calculateIncome().toString(),
                expense: GoogleSheetsApi.calculateExpense().toString(),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Text('Transactions',
                            style: GoogleFonts.roboto(
                                textStyle: const TextStyle(fontSize: 24),
                                fontWeight: FontWeight.w400,
                                color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                    ],
                  ),
                  // To check git push
                  Row(
                    children: [
                      PlusButton(
                        cond: GoogleSheetsApi.currentTransactions.isEmpty
                            ? false
                            : true,
                        bgcolor: GoogleSheetsApi.currentTransactions.isEmpty
                            ? false
                            : true,
                        function: _newTransaction,
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GoogleSheetsApi.loading == true
                          ? const LoadingCircle()
                          : SingleChildScrollView(
                              child: GoogleSheetsApi.currentTransactions.isEmpty
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 150,
                                        ),
                                        Column(
                                          children: [
                                            PlusButton(
                                              cond: true,
                                              bgcolor: true,
                                              function: _newTransaction,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              width: 300,
                                              // decoration: BoxDecoration(
                                              //   color:
                                              //       Colors.indigo.withOpacity(0.5),
                                              //   borderRadius:
                                              //       const BorderRadius.only(
                                              //           topLeft:
                                              //               Radius.circular(25),
                                              //           bottomLeft:
                                              //               Radius.circular(25),
                                              //           bottomRight:
                                              //               Radius.circular(25)),
                                              // ),
                                              child: const Text(
                                                "Import Data",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Column(children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        physics:
                                            const ScrollPhysics(parent: null),
                                        itemCount: GoogleSheetsApi
                                            .currentTransactions.length,
                                        itemBuilder: (context, index) {
                                          return Slidable(
                                            endActionPane: ActionPane(
                                              motion: const StretchMotion(),
                                              children: [
                                                SlidableAction(
                                                  autoClose: true,
                                                  label: 'Delete',
                                                  onPressed: (context) {
                                                    print('$index');
                                                    _deleteTransaction(index);
                                                  },
                                                  icon: Icons.delete,
                                                  foregroundColor: Colors
                                                      .red.shade400
                                                      .withOpacity(0.9),
                                                  backgroundColor: Colors.black
                                                      .withOpacity(0.1),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ],
                                            ),
                                            child: MyTransaction(
                                              transactionName: GoogleSheetsApi
                                                      .currentTransactions[
                                                  index][0],
                                              money: GoogleSheetsApi
                                                      .currentTransactions[
                                                  index][1],
                                              expenseOrIncome: GoogleSheetsApi
                                                      .currentTransactions[
                                                  index][2],
                                            ),
                                          );
                                        },
                                      ),
                                    ]),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
