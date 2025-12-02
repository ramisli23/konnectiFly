import 'package:flutter/material.dart';
import 'package:konnecti/l10n/app_localizations.dart';
import 'package:konnecti/providers/BalanceProvider.dart';
import 'package:provider/provider.dart';

class EsimDataCard extends StatelessWidget {
  const EsimDataCard({super.key});

  static const double total = 10;
  static const double remaining = 3.5;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    final balanceProvider = Provider.of<BalanceProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 🔵 Colonne avec les indicateurs
          Container(
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildCard(
                  tr.data,
                  "${balanceProvider.balance.toStringAsFixed(2)} GB",
                  Colors.blue,
                  balanceProvider.balance / total,
                ),
                const SizedBox(height: 12),
                _buildCard(tr.call, "160 Min", Colors.purple, 1),
                const SizedBox(height: 12),
                _buildCard(tr.sms, "30 SMS", Colors.green, 0.9),
              ],
            ),
          ),

          // 🔷 Colonne avec les infos totales
          Column(
            children: [
              _buildInfoContainer(
                "${balanceProvider.balance.toStringAsFixed(2)}", // Affichage USD
                tr.totalData,
                Colors.blue,
              ),
              const SizedBox(height: 12),
              _buildInfoContainer("160", tr.totalMinutes, Colors.purple),
              const SizedBox(height: 12),
              _buildInfoContainer("30", tr.totalSms, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String value, Color color, double progress) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildInfoContainer(String value, String label, Color color) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
