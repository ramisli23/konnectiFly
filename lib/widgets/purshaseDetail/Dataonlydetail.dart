// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:konnecti/modules/puechase/data_only.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Dataonlydetail extends StatelessWidget {
  final List<DataOnly> esims;
  const Dataonlydetail({super.key, required this.esims});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: esims.length,
        itemBuilder: (context, index) {
          final esim = esims[index];

          final String packageName = esim.package.packageName;
          final String status = esim.package.status;
          final bool activated = esim.package.activated;

          final String simId = esim.sim.id;
          final String iccid = esim.sim.iccid;
          final String lpa = esim.sim.qrCodeText;
          //    final String? expiry = esim.package.expiryDate; // si dispo

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
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
                        packageName,
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
                          esim.package.activated == true
                              ? Colors.green
                              : Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text("SIM ID: $simId"),
                Text("ICCID: $iccid"),
                //  if (expiry != null) Text("Expire le: $expiry"),
                const SizedBox(height: 12),

                // QR Code
                if (lpa.isNotEmpty)
                  Center(
                    child: QrImageView(
                      data: lpa,
                      size: 140,
                      version: QrVersions.auto,
                    ),
                  ),
                const SizedBox(height: 12),
                Padding(padding: EdgeInsets.all(10), child: Divider()),
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

  void _rechargerEsim(DataOnly esim) {
    print("Recharger SIM ${esim.sim.id}");
  }

  void _voirDetailsEsim(BuildContext context, DataOnly esim) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EsimDetailPage(esim: esim)),
    );
  }
}

// Page détail complet
class EsimDetailPage extends StatelessWidget {
  final DataOnly esim;
  const EsimDetailPage({super.key, required this.esim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(esim.package.packageName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("SIM ID: ${esim.sim.id}"),
            Text("ICCID: ${esim.sim.iccid}"),
            Text("Status: ${esim.package.activated}"),
            Text("Activation Code: ${esim.sim.matchingId}"),
            const SizedBox(height: 20),
            if (esim.sim.qrCodeText.isNotEmpty)
              Center(
                child: QrImageView(
                  data: esim.sim.qrCodeText,
                  size: 180,
                  version: QrVersions.auto,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
