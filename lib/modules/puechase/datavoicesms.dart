class Datavoicesms {
  final bool status;
  final Data data;
  final String message;
  final List<dynamic> error;

  Datavoicesms({
    required this.status,
    required this.data,
    required this.message,
    required this.error,
  });

  factory Datavoicesms.fromJson(Map<String, dynamic> json) {
    return Datavoicesms(
      status: json['status'] ?? false,
      data: Data.fromJson(json['data']),
      message: json['message'] ?? '',
      error: json['error'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "data": data.toJson(),
      "message": message,
      "error": error,
    };
  }
}

class Data {
  final bool simApplied;
  final String id;
  final String packageTypeId;
  final String simId;
  final String packageName;
  final String dateCreated;
  final String dateActivated;
  final String dateExpiry;
  final bool activated;
  final String status;
  final Sim sim;
  final bool unlimited;
  final int initialDataQuantity;
  final String initialDataUnit;
  final int remDataQuantity;
  final String remDataUnit;

  Data({
    required this.simApplied,
    required this.id,
    required this.packageTypeId,
    required this.simId,
    required this.packageName,
    required this.dateCreated,
    required this.dateActivated,
    required this.dateExpiry,
    required this.activated,
    required this.status,
    required this.sim,
    required this.unlimited,
    required this.initialDataQuantity,
    required this.initialDataUnit,
    required this.remDataQuantity,
    required this.remDataUnit,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      simApplied: json['sim_applied'] ?? false,
      id: json['id'] ?? '',
      packageTypeId: json['package_type_id'] ?? '',
      simId: json['sim_id'] ?? '',
      packageName: json['package'] ?? '',
      dateCreated: json['date_created'] ?? '',
      dateActivated: json['date_activated'] ?? '',
      dateExpiry: json['date_expiry'] ?? '',
      activated: json['activated'] ?? false,
      status: json['status'] ?? '',
      sim: Sim.fromJson(json['sim']),
      unlimited: json['unlimited'] ?? false,
      initialDataQuantity: json['initial_data_quantity'] ?? 0,
      initialDataUnit: json['initial_data_unit'] ?? '',
      remDataQuantity: json['rem_data_quantity'] ?? 0,
      remDataUnit: json['rem_data_unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "sim_applied": simApplied,
      "id": id,
      "package_type_id": packageTypeId,
      "sim_id": simId,
      "package": packageName,
      "date_created": dateCreated,
      "date_activated": dateActivated,
      "date_expiry": dateExpiry,
      "activated": activated,
      "status": status,
      "sim": sim.toJson(),
      "unlimited": unlimited,
      "initial_data_quantity": initialDataQuantity,
      "initial_data_unit": initialDataUnit,
      "rem_data_quantity": remDataQuantity,
      "rem_data_unit": remDataUnit,
    };
  }
}

class Sim {
  final String id;
  final String? iccid;
  final String? qrCodeText;
  final String? smdpAddress;
  final String? matchingId;
  final String createdAt;
  final String lastBundle;
  final String status;
  final int totalBundles;
  final String? pukCode;
  final String? installedAt;
  final String? number;
  final String apn;
  final String imei;

  Sim({
    required this.id,
    this.iccid,
    this.qrCodeText,
    this.smdpAddress,
    this.matchingId,
    required this.createdAt,
    required this.lastBundle,
    required this.status,
    required this.totalBundles,
    this.pukCode,
    this.installedAt,
    this.number,
    required this.apn,
    required this.imei,
  });

  factory Sim.fromJson(Map<String, dynamic> json) {
    return Sim(
      id: json['id'] ?? '',
      iccid: json['iccid'],
      qrCodeText: json['qr_code_text'],
      smdpAddress: json['smdp_address'],
      matchingId: json['matching_id'],
      createdAt: json['created_at'] ?? '',
      lastBundle: json['last_bundle'] ?? '',
      status: json['status'] ?? '',
      totalBundles: json['total_bundles'] ?? 0,
      pukCode: json['puk_code'],
      installedAt: json['installed_at'],
      number: json['number'],
      apn: json['apn'] ?? '',
      imei: json['imei'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "iccid": iccid,
      "qr_code_text": qrCodeText,
      "smdp_address": smdpAddress,
      "matching_id": matchingId,
      "created_at": createdAt,
      "last_bundle": lastBundle,
      "status": status,
      "total_bundles": totalBundles,
      "puk_code": pukCode,
      "installed_at": installedAt,
      "number": number,
      "apn": apn,
      "imei": imei,
    };
  }
}
