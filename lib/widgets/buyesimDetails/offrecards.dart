/*import 'package:flutter/material.dart';
import 'package:konnecti/providers/offer_provider.dart';
import 'package:konnecti/widgets/buyesimDetails/ViewDetail.dart';
import 'package:provider/provider.dart';

class Offrecards extends StatefulWidget {
  final String data;
  final String days;
  final String price;
  final String country;
  final String mainImagePath; // nouvelle prop
  final String mainPrice; // nouvelle prop

  const Offrecards({
    super.key,
    required this.data,
    required this.days,
    required this.price,
    required this.country,
    required this.mainImagePath,
    required this.mainPrice,
    required bool isUnlimited,
    required bool isSelected,
  });

  @override
  State<Offrecards> createState() => _OffrecardsState();
}

class _OffrecardsState extends State<Offrecards> {
  bool isChecked = false;
  bool playAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox + 5G Row
          Row(
            children: [
              Checkbox(
                value: isChecked,
                activeColor: Colors.teal,
                shape: const CircleBorder(),
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                    playAnimation = value;
                  });
                },
              ),
              const Spacer(),
              Row(
                children: const [
                  Icon(Icons.network_wifi, size: 16, color: Colors.teal),
                  SizedBox(width: 4),
                  Text(
                    "5G",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ✅ Lottie animation if checked
          /*  if (playAnimation)
            Lottie.asset(
              'assets/lottie/success.json',
              width: 80,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  setState(() {
                    playAnimation = false;
                  });
                });
              },
            ),*/
          const SizedBox(height: 4),

          // Data
          Text(
            widget.data,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),

          // Duration
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 5),
              Text(widget.days, style: const TextStyle(color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),

          // Price
          Row(
            children: [
              Text(
                widget.price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const Text(
                " DZ",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Country
          Row(
            children: [
              const Icon(Icons.public, color: Colors.grey, size: 14),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  widget.country,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis, // coupe le texte avec "…"
                  maxLines: 1, // force une seule ligne
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          GestureDetector(
            onTap: () {
              Provider.of<OfferProvider>(context, listen: false).setOffer(
                newData: widget.data,
                newDays: widget.days,
                newPrice: widget.price,
                newCountry: widget.country,
              );
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.8,
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
                    builder:
                        (_, scrollController) => SingleChildScrollView(
                          controller: scrollController,
                          child: const Viewdetail(),
                        ),
                  );
                },
              );
            },
            child: Row(
              children: const [
                Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.open_in_new, color: Colors.teal, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:konnecti/providers/offer_provider.dart';
import 'package:konnecti/widgets/buyesimDetails/ViewDetail.dart';
import 'package:provider/provider.dart';

class Offrecards extends StatelessWidget {
  final String data;
  final String days;
  final String price;
  final String country;
  final String mainImagePath;
  final String mainPrice;
  final bool isUnlimited;
  final bool isSelected;

  const Offrecards({
    super.key,
    required this.data,
    required this.days,
    required this.price,
    required this.country,
    required this.mainImagePath,
    required this.mainPrice,
    required this.isUnlimited,
    this.isSelected = false, // ✅ DEFAULT
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),

        // ✅ BORDURE DYNAMIQUE
        border: Border.all(
          color: isSelected ? Colors.teal : Colors.grey.shade300,
          width: isSelected ? 2.2 : 1,
        ),

        // ✅ OMBRE DYNAMIQUE
        boxShadow: [
          BoxShadow(
            color:
                isSelected
                    ? Colors.teal.withOpacity(0.15)
                    : Colors.black.withOpacity(0.05),
            blurRadius: isSelected ? 12 : 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ TOP ROW
          Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child:
                    isSelected
                        ? const Icon(
                          Icons.check_circle,
                          color: Colors.teal,
                          size: 22,
                          key: ValueKey("selected"),
                        )
                        : const Icon(
                          Icons.circle_outlined,
                          color: Colors.grey,
                          size: 22,
                          key: ValueKey("unselected"),
                        ),
              ),
              const Spacer(),
              const Row(
                children: [
                  Icon(Icons.network_wifi, size: 16, color: Colors.teal),
                  SizedBox(width: 4),
                  Text(
                    "5G",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 📦 DATA
          Text(
            data,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          // ⏱ DURATION
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 5),
              Text(days, style: const TextStyle(color: Colors.grey)),
            ],
          ),

          const SizedBox(height: 10),

          // 💰 PRICE
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
                " DZ",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // 🌍 COUNTRY
          Row(
            children: [
              const Icon(Icons.public, color: Colors.grey, size: 14),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  country,
                  style: const TextStyle(color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 🔍 VIEW DETAILS
          GestureDetector(
            onTap: () {
              Provider.of<OfferProvider>(context, listen: false).setOffer(
                newData: data,
                newDays: days,
                newPrice: price,
                newCountry: country,
              );
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                builder:
                    (context) => DraggableScrollableSheet(
                      expand: false,
                      initialChildSize: 0.8,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      builder:
                          (_, scrollController) => SingleChildScrollView(
                            controller: scrollController,
                            child: const Viewdetail(),
                          ),
                    ),
              );
            },
            child: const Row(
              children: [
                Text(
                  "View Details",
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.open_in_new, color: Colors.teal, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
