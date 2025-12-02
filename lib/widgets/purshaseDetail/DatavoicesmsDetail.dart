/*import 'package:flutter/material.dart';
import 'package:konnecti/modules/puechase/datavoicesms.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Datavoicesmsdetail extends StatelessWidget {
  final List<Datavoicesms> esims;
  const Datavoicesmsdetail({super.key, required this.esims});

  @override
  Widget build(BuildContext context) {
    // Exemple de données (à remplacer par API)
    /*final esims = [
      {
        "name": "Espagne 10 Go – 30 jours",
        "status": "Active",
        "validity": "02/09/2025 → 02/10/2025",
        "dataUsed": 2.5,
        "dataTotal": 10.0,
        "minutesUsed": 20,
        "minutesTotal": 100,
        "smsUsed": 5,
        "smsTotal": 50,
        "lpa": "LPA:1\$rsp-3104.idemia.io\$H11ZH-YZZEE-DDHRS-OUPMU",
        "ID": "80ff0456-c3df-4c96-b402-804ea704c3fa",
        "ICCID": "8943108165024278611",
        "SMDP Address": "rsp-3104.idemia.io",
        "Activation Code": "H11ZH-YZZEE-DDHRS-OUPMU",
        "PUK Code": "42637040",
        "Bundles Bought": 1,
      },
      {
        "name": "France 5 Go – 15 jours",
        "status": "Expirée",
        "validity": "01/08/2025 → 15/08/2025",
        "dataUsed": 5.0,
        "dataTotal": 5.0,
        "minutesUsed": 50,
        "minutesTotal": 50,
        "smsUsed": 50,
        "smsTotal": 50,
        "lpa": "LPA:1\$rsp-3104.idemia.io\$H22AB-ZZZEE-DDHRS-XYZ12",
        "ID": "12ab3456-c3df-4c96-b402-123456789abc",
        "ICCID": "8943108165024278612",
        "SMDP Address": "rsp-3104.idemia.io",
        "Activation Code": "H22AB-ZZZEE-DDHRS-XYZ12",
        "PUK Code": "98765432",
        "Bundles Bought": 1,
      },
    ];*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: esims.length,
        itemBuilder: (context, index) {
          final esim = esims[index];

           final String name = esim.data.packageName ?? "Unnamed SIM";
          final String status = esim.data.status ?? "Unknown";
          final String validity = esim.data. ?? "N/A";
          final String lpa = esim.lpa ?? "";

          final String package_type_id = esim.package_type_id;
          final String sim_id = esim.sim_id;

          final String package = esim.package;
          final String date_created = esim.date_created;
          final String date_activated = esim.date_activated;
          final String date_expiry = esim.date_expiry;
          final bool activated = esim.activated;

          final String status = esim.status ?? "Unknown";
          final double dataRemaining =
              (esim["dataTotal"] as double) - (esim["dataUsed"] as double);
          final int minutesRemaining =
              (esim["minutesTotal"] as int) - (esim["minutesUsed"] as int);
          final int smsRemaining =
              (esim["smsTotal"] as int) - (esim["smsUsed"] as int);

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nom + statut
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                      name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Chip(
                      label: Text(
                        status,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor:
                          status == "Active" ? Colors.green : Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Validité :$date_created $date_expiry"),
                const SizedBox(height: 12),

                // QR Code
                Center(
                  child: QrImageView(
                    data: "${esim["lpa"]}",
                    size: 120,
                    version: QrVersions.auto,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: SizedBox(
                    width: 190,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => _downloadQr(esim),
                      icon: const Icon(Icons.download, color: Colors.white),
                      label: const Text(
                        "Télécharger QR Code",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Cartes graphiques Data / Minutes / SMS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCard(
                      "Data",
                      "${dataRemaining.toStringAsFixed(1)} GB",
                      Colors.blue,
                      dataRemaining / (esim["dataTotal"] as double),
                    ),
                    _buildCard(
                      "Minutes",
                      "$minutesRemaining Min",
                      Colors.orange,
                      minutesRemaining / (esim["minutesTotal"] as int),
                    ),
                    _buildCard(
                      "SMS",
                      "$smsRemaining SMS",
                      Colors.purple,
                      smsRemaining / (esim["smsTotal"] as int),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Boutons actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _rechargerEsim(esim),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      label: const Text(
                        "Recharger",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _voirDetailsEsim(context, esim),
                      icon: const Icon(Icons.info, color: Colors.blue),
                      label: const Text(
                        "Voir détails",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 📌 Fonctions actions
  void _rechargerEsim(Map<String, dynamic> esim) =>
      print("Rechargement pour : ${esim['name']}");
  void _downloadQr(Map<String, dynamic> esim) =>
      print("Téléchargement QR pour : ${esim['name']}");
  void _voirDetailsEsim(BuildContext context, Map<String, dynamic> esim) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EsimDetailPage(esim: esim)),
    );
  }

  // Widget carte graphique
  Widget _buildCard(String title, String value, Color color, double progress) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(color),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Page détail complet
class EsimDetailPage extends StatelessWidget {
  final Map<String, dynamic> esim;
  const EsimDetailPage({super.key, required this.esim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(esim["name"])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildInfoRows(esim),
            const SizedBox(height: 20),
            Center(
              child: QrImageView(
                data: esim["lpa"],
                size: 180,
                version: QrVersions.auto,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildInfoRows(Map<String, dynamic> esim) {
    final infoKeys = [
      "ID",
      "ICCID",
      "LPA",
      "SMDP Address",
      "Activation Code",
      "PUK Code",
      "Status",
      "Bundles Bought",
    ];
    return infoKeys
        .map(
          (key) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140,
                  child: Text(
                    "$key :",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: Text(esim[key].toString())),
              ],
            ),
          ),
        )
        .toList();
  }
}
*/
