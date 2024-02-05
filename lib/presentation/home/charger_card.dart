import 'package:ev_charger_app/domain/model/charger_model.dart';
import 'package:ev_charger_app/domain/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

final List<String> chargerTypes = [
  'DC 차데모',
  'AC 완속',
  'DC차데모+AC3상',
  'DC콤보',
  'DC차데모+DC콤보',
  'DC차데모+AC3상',
  '+DC콤보',
  'AC3상'
];

final List<String> status = ['통신이상', '충전가능', '충전중', '운영중지', '점검중', '상태미확인'];

class ChargerCard extends StatelessWidget {
  final ChargerModel charger;
  final UserModel user;

  const ChargerCard({
    super.key,
    required this.charger,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '/charger-detail?userId=${user.id}&chargerId=${charger.id}',
        );
      },
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                charger.location,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    chargerTypes[charger.chargeType],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    _getStatusText(charger.status),
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          charger.status == 1 ? Colors.green : Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '출력: ${charger.output} kW',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              if (charger.lastStartChargingTimestamp != null)
                Text(
                  _getChargeTimeInfoText(charger.lastStartChargingTimestamp!,
                      charger.lastEndChargingTimestamp),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _getStatusText(int statusIndex) {
    if (statusIndex >= 0 && statusIndex < status.length) {
      return status[statusIndex];
    }
    return '알 수 없음';
  }

  String _getChargeTimeInfoText(
      int lastStartChargingTimestamp, int? lastEndChargingTimestamp) {
    final dateFormat = DateFormat('yy.MM.dd HH:mm:ss'); // 날짜 형식 지정

    if (lastEndChargingTimestamp == null ||
        lastStartChargingTimestamp >= lastEndChargingTimestamp) {
      DateTime startDate = DateTime.fromMillisecondsSinceEpoch(
          lastStartChargingTimestamp * 1000);
      return '마지막 충전 시작 시간: ${dateFormat.format(startDate)}';
    }
    DateTime endDate =
        DateTime.fromMillisecondsSinceEpoch(lastEndChargingTimestamp * 1000);
    return '마지막 충전 완료 시간: ${dateFormat.format(endDate)}';
  }
}
