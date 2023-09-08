import 'package:flutter/cupertino.dart';

class AnimalLegend extends StatelessWidget {
  final Color color;
  final String animalString;
  final String rainDropString;
  final int price;
  const AnimalLegend({
    super.key,
    required this.color,
    required this.animalString,
    required this.rainDropString,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Image.asset('assets/images/$animalString'
                  '.png'),
            ),
            Expanded(
              child: Image.asset('assets/images/$rainDropString'
                  '.png'),
            ),
          ],
        ),
      ),
    );
  }
}
