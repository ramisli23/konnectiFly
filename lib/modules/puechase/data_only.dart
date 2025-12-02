class DataOnly {
  final bool simApplied;
  final Sim sim;
  final Package package;

  DataOnly({
    required this.simApplied,
    required this.sim,
    required this.package,
  });

  factory DataOnly.fromJson(Map<String, dynamic> json) {
    return DataOnly(
      simApplied: json['sim_applied'] ?? false,
      sim:
          json['sim'] is Map<String, dynamic>
              ? Sim.fromJson(json['sim'])
              : Sim(
                id: '',
                iccid: '',
                qrCodeText: '',
                smdpAddress: '',
                matchingId: '',
                status: '',
                universalLink: '',
                apn: '',
              ),
      package:
          json['package'] is Map<String, dynamic>
              ? Package.fromJson(json['package'])
              : Package(
                id: '',
                packageTypeId: '',
                simId: '',
                packageName: json['package'].toString(),
                activated: false,
                status: '',
                initialDataQuantity: 0,
                initialDataUnit: '',
                remDataQuantity: 0,
                remDataUnit: '',
                unlimited: false,
              ),
    );
  }
}

class Sim {
  final String id;
  final String iccid;
  final String qrCodeText;
  final String smdpAddress;
  final String matchingId;
  final String status;
  final String universalLink;
  final String apn;
  final String? installedAt;
  final String? number;
  final String? pukCode;

  Sim({
    required this.id,
    required this.iccid,
    required this.qrCodeText,
    required this.smdpAddress,
    required this.matchingId,
    required this.status,
    required this.universalLink,
    required this.apn,
    this.installedAt,
    this.number,
    this.pukCode,
  });

  factory Sim.fromJson(Map<String, dynamic> json) {
    return Sim(
      id: json['id'] ?? '',
      iccid: json['iccid'] ?? '',
      qrCodeText: json['qr_code_text'] ?? '',
      smdpAddress: json['smdp_address'] ?? '',
      matchingId: json['matching_id'] ?? '',
      status: json['status'] ?? '',
      universalLink: json['universal_link'] ?? '',
      apn: json['apn'] ?? '',
      installedAt: json['installed_at'],
      number: json['number'],
      pukCode: json['puk_code'],
    );
  }

  /// ✅ Empty constructor for null-safe fallback
  factory Sim.empty() {
    return Sim(
      id: '',
      iccid: '',
      qrCodeText: '',
      smdpAddress: '',
      matchingId: '',
      status: '',
      universalLink: '',
      apn: '',
      installedAt: null,
      number: null,
      pukCode: null,
    );
  }
}

class Package {
  final String id;
  final String packageTypeId;
  final String simId;
  final String packageName;
  final bool activated;
  final String status;
  final double initialDataQuantity;
  final String initialDataUnit;
  final double remDataQuantity;
  final String remDataUnit;
  final bool unlimited;

  Package({
    required this.id,
    required this.packageTypeId,
    required this.simId,
    required this.packageName,
    required this.activated,
    required this.status,
    required this.initialDataQuantity,
    required this.initialDataUnit,
    required this.remDataQuantity,
    required this.remDataUnit,
    required this.unlimited,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'] ?? '',
      packageTypeId: json['package_type_id'] ?? '',
      simId: json['sim_id'] ?? '',
      packageName: json['package'] ?? '',
      activated: json['activated'] ?? false,
      status: json['status'] ?? '',
      initialDataQuantity: (json['initial_data_quantity'] ?? 0).toDouble(),
      initialDataUnit: json['initial_data_unit'] ?? '',
      remDataQuantity: (json['rem_data_quantity'] ?? 0).toDouble(),
      remDataUnit: json['rem_data_unit'] ?? '',
      unlimited: json['unlimited'] ?? false,
    );
  }

  /// ✅ Empty constructor for null-safe fallback
  factory Package.empty() {
    return Package(
      id: '',
      packageTypeId: '',
      simId: '',
      packageName: '',
      activated: true,
      status: '',
      initialDataQuantity: 0,
      initialDataUnit: '',
      remDataQuantity: 0,
      remDataUnit: '',
      unlimited: false,
    );
  }
}
