import 'package:flights_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketTile extends StatelessWidget {
  final String? badge;
  final int price;
  final DateTime departureDate;
  final DateTime arrivalDate;
  final String departureAirport;
  final String arrivalAirport;
  final bool hasTransfer;
  const TicketTile({
    super.key,
    this.badge,
    required this.price,
    required this.departureDate,
    required this.arrivalDate,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.hasTransfer,
  });

  @override
  Widget build(BuildContext context) {
    double timeDiff = double.parse(
        (arrivalDate.difference(departureDate).inMinutes / 60)
            .toStringAsFixed(1));
    final width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          height: 120,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: grey8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$price ₽',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: red),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(DateFormat.Hm().format(departureDate)),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 10,
                              child: Divider(
                                color: grey6,
                              ),
                            ),
                            Text(DateFormat.Hm().format(arrivalDate))
                          ],
                        ),
                        Row(
                          children: [
                            Text(arrivalAirport),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(departureAirport)
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('$timeDiffч в пути'),
                        if (!hasTransfer) const Text('/Без пересадок')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            child: Container(
              height: 30,
              width: 130,
              decoration: BoxDecoration(
                  color: blue, borderRadius: BorderRadius.circular(50)),
              child: Center(
                  child: Text(
                badge!,
                style: TextStyle(color: white, fontWeight: FontWeight.w500),
              )),
            ),
          ),
      ],
    );
  }
}
