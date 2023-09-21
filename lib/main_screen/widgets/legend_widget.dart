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
    return AspectRatio(
      aspectRatio: 1.6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          color: color,
        ),
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.8,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset('assets/images/$animalString'
                    '.png'),
              ),
              Expanded(
                flex: 2,
                child: Image.asset('assets/images/$rainDropString'
                    '.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
