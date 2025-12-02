import 'package:konnecti/modules/Esim/Coverage.dart';
import 'package:konnecti/modules/Esim/Package.dart';
import 'package:konnecti/modules/Esim/usage.dart';

class Esim {
  final String id;
  final String iccid;
  final String qrCodeText;
  final String smdpAddress;
  final String matchingId;
  final DateTime createdAt;
  final String lastBundle;
  final String status;
  final int totalBundles;
  final String universalLink;

  final List<Package> inUsePackages;
  final List<Package> assignedPackages;
  final List<Package> completedPackages;
  final List<Package> revokedPackages;

  final List<Coverage> coverage;
  final Usage overallUsage;

  Esim({
    required this.id,
    required this.iccid,
    required this.qrCodeText,
    required this.smdpAddress,
    required this.matchingId,
    required this.createdAt,
    required this.lastBundle,
    required this.status,
    required this.totalBundles,
    required this.universalLink,
    required this.inUsePackages,
    required this.assignedPackages,
    required this.completedPackages,
    required this.revokedPackages,
    required this.coverage,
    required this.overallUsage,
  });

  factory Esim.fromJson(Map<String, dynamic> json) {
    final simJson = json['data']['sim'];
    return Esim(
      id: simJson['id'],
      iccid: simJson['iccid'],
      qrCodeText: simJson['qr_code_text'] ?? '',
      smdpAddress: simJson['smdp_address'] ?? '',
      matchingId: simJson['matching_id'] ?? '',
      createdAt: DateTime.parse(simJson['created_at']),
      lastBundle: simJson['last_bundle'] ?? '',
      status: simJson['status'] ?? '',
      totalBundles: simJson['total_bundles'] ?? 0,
      universalLink: simJson['universal_link'] ?? '',
      inUsePackages:
          (json['data']['in_use_packages'] as List<dynamic>)
              .map((p) => Package.fromJson(p as Map<String, dynamic>))
              .toList(),
      assignedPackages:
          (json['data']['assigned_packages'] as List<dynamic>)
              .map((p) => Package.fromJson(p as Map<String, dynamic>))
              .toList(),
      completedPackages:
          (json['data']['completed_packages'] as List<dynamic>)
              .map((p) => Package.fromJson(p as Map<String, dynamic>))
              .toList(),
      revokedPackages:
          (json['data']['revoked_packages'] as List<dynamic>)
              .map((p) => Package.fromJson(p as Map<String, dynamic>))
              .toList(),
      coverage:
          (json['data']['coverage'] as List<dynamic>)
              .map((c) => Coverage.fromJson(c as Map<String, dynamic>))
              .toList(),
      overallUsage: Usage.fromJson(
        json['data']['overall_usage'] as Map<String, dynamic>,
      ),
    );
  }
}
