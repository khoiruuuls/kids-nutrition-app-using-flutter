import '../components/components_individual_bar.dart';

class Bar {
  final double amountOne;
  final double amountTwo;
  final double amountThree;
  final double amountFour;
  final double amountFive;
  final double amountSix;
  final double amountSeven;

  Bar({
    required this.amountOne,
    required this.amountTwo,
    required this.amountThree,
    required this.amountFour,
    required this.amountFive,
    required this.amountSix,
    required this.amountSeven,
  });

  List<ComponentsIndividualBar> dataBar = [];

  void initialDataBar() {
    // Adjust values if they exceed 9000
    double adjustValue(double value) {
      return (value > 10000) ? 10000 : value;
    }

    dataBar = [
      ComponentsIndividualBar(x: 0, y: adjustValue(amountOne)),
      ComponentsIndividualBar(x: 1, y: adjustValue(amountTwo)),
      ComponentsIndividualBar(x: 2, y: adjustValue(amountThree)),
      ComponentsIndividualBar(x: 3, y: adjustValue(amountFour)),
      ComponentsIndividualBar(x: 4, y: adjustValue(amountFive)),
      ComponentsIndividualBar(x: 5, y: adjustValue(amountSix)),
      ComponentsIndividualBar(x: 6, y: adjustValue(amountSeven)),
    ];
  }
}
