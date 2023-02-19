import 'package:first_app/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTransaction extends StatelessWidget {
  final String transactionName;
  final String money;
  final String expenseOrIncome;

  const MyTransaction({
    super.key,
    required this.transactionName,
    required this.money,
    required this.expenseOrIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GlassBox(
          height: 65.0,
          color: Colors.blue,
          blur: 5.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Center(
                        child: expenseOrIncome == 'expense'
                            ? const Icon(
                                Icons.keyboard_double_arrow_down_rounded,
                                color: Colors.red,
                                size: 32,
                              )
                            : const Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: Colors.green,
                                size: 32,
                              )),
                  ),
                  Text(
                    transactionName,
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 18),
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  '${expenseOrIncome == 'expense' ? '-' : '+'} ₹$money',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 18),
                      fontWeight: FontWeight.w600,
                      color: expenseOrIncome == 'expense'
                          ? Colors.redAccent
                          : Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
