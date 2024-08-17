import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({required this.title, required this.price, super.key});
  final String title;
  final String price;

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '\$${widget.price}',
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
