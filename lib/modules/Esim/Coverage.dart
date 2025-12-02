class Coverage {
  final int id;
  final String countryName;
  final String code;
  final String iso;
  final String countryImageUrl;
  final String networkName;
  final String networkCode;
  final bool t2G;
  final bool th3G;
  final bool for4G;
  final bool fiv5G;

  Coverage({
    required this.id,
    required this.countryName,
    required this.code,
    required this.iso,
    required this.countryImageUrl,
    required this.networkName,
    required this.networkCode,
    required this.t2G,
    required this.th3G,
    required this.for4G,
    required this.fiv5G,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) {
    return Coverage(
      id: json['id'] ?? 0,
      countryName: json['country_name'] ?? '',
      code: json['code'] ?? '',
      iso: json['iso'] ?? '',
      countryImageUrl: json['country_image_url'] ?? '',
      networkName: json['network_name'] ?? '',
      networkCode: json['network_code'] ?? '',
      t2G: json['t_2G'] ?? false,
      th3G: json['th_3G'] ?? false,
      for4G: json['for-4G'] ?? false,
      fiv5G: json['fiv_5G'] ?? false,
    );
  }
}
