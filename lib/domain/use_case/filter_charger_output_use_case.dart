import 'package:ev_charger_app/domain/model/charger_model.dart';

class FilterChargerOutputUseCase {
  List<ChargerModel> execute(
      List<ChargerModel> inputChargers, int minOutput, int maxOutput) {
    return inputChargers
        .where((charger) =>
            charger.output >= minOutput && charger.output <= maxOutput)
        .toList();
  }
}
