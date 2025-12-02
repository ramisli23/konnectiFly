import 'package:konnecti/modules/Esim/Coverage.dart';

class EsimPackage {
  final String id;
  final String name;
  final int dataQuantity;
  final String dataUnit;
  final int voiceQuantity;
  final String voiceUnit;
  final int smsQuantity;
  final int packageValidity;
  final String packageValidityUnit;
  final String packageType;
  final List<Coverage> coverage;
  final bool unlimited;

  EsimPackage({
    required this.id,
    required this.name,
    required this.dataQuantity,
    required this.dataUnit,
    required this.voiceQuantity,
    required this.voiceUnit,
    required this.smsQuantity,
    required this.packageValidity,
    required this.packageValidityUnit,
    required this.packageType,
    required this.coverage,
    required this.unlimited,
  });
}
