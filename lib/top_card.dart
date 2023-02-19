import 'package:first_app/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;
  final String income;
  final String expense;

  const TopNeuCard({
    super.key,
    required this.balance,
    required this.expense,
    required this.income,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: GlassBox(
          blur: 255.0,
          color: Colors.blue,
          height: 200.0,
          width: 400.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Total Balance',
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 28),
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                '\₹ ' + balance,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(fontSize: 34),
                  fontWeight: FontWeight.w500,
                  color: balance.contains('-') ? Colors.red : Colors.green,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlassBox(
                      blur: 0.0,
                      height: 60.0,
                      width: 140.0,
                      color: Colors.green,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.keyboard_double_arrow_up_rounded,
                            size: 40,
                            color: Color.fromARGB(255, 48, 246, 61),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Income',
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(fontSize: 18),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.greenAccent)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '\₹ ' + income,
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(fontSize: 18),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.greenAccent),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    GlassBox(
                      height: 60.0,
                      width: 140.0,
                      blur: 5.0,
                      color: const Color.fromARGB(255, 252, 85, 85),
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_double_arrow_down_rounded,
                            size: 40,
                            color: Colors.redAccent.shade400,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Expense',
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(fontSize: 18),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.redAccent)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '₹ $expense',
                                style: GoogleFonts.roboto(
                                    textStyle: const TextStyle(fontSize: 18),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.redAccent),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
