import 'package:flutter/cupertino.dart';

import 'color_palette.dart';
import 'legend_widget.dart';

class FieldsMainPage extends StatelessWidget {
  const FieldsMainPage({
    super.key,
    required this.topRowList,
    required this.bottomRowList,
  });

  final List<Widget> topRowList;
  final List<Widget> bottomRowList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 12,
            child: Container(
              decoration: BoxDecoration(
                color: ColorPalette().fieldBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Row(
                      // creates row with list of fields
                      children: topRowList,
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Row(
                      children: bottomRowList,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: AnimalLegend(
                    color: ColorPalette().seedEarlyMaturing,
                    animalString: 'zebra',
                    rainDropString: 'drop',
                    price: 2,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: AnimalLegend(
                    color: ColorPalette().seedNormalMaturing,
                    animalString: 'lion',
                    rainDropString: 'drops',
                    price: 3,
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: AnimalLegend(
                    color: ColorPalette().seedNormalMaturingHighYield,
                    animalString: 'elephant',
                    rainDropString: 'dropsandplus',
                    price: 5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
