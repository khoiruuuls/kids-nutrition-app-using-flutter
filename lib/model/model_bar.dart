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
    dataBar = [
      ComponentsIndividualBar(x: 0, y: amountOne),
      ComponentsIndividualBar(x: 1, y: amountTwo),
      ComponentsIndividualBar(x: 2, y: amountThree),
      ComponentsIndividualBar(x: 3, y: amountFour),
      ComponentsIndividualBar(x: 4, y: amountFive),
      ComponentsIndividualBar(x: 5, y: amountSix),
      ComponentsIndividualBar(x: 6, y: amountSeven),
    ];
  }
}
