import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class OrdersScreen extends StatefulWidget {
  final String userId;

  const OrdersScreen({super.key, required this.userId});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Map<String, dynamic>>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = fetchOrders(widget.userId);
  }

  Future<List<Map<String, dynamic>>> fetchOrders(String userId) async {
    final url = Uri.parse(
      "https://backend-bumm.onrender.com/orders/user/$userId",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body["success"] == true) {
        return List<Map<String, dynamic>>.from(body["orders"]);
      } else {
        return [];
      }
    } else {
      throw Exception("Erreur API: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header custom sans AppBar
          Container(
            margin: const EdgeInsets.only(top: 22),
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.blue[700]),
                ),
                const SizedBox(width: 16),
                Text(
                  "Mes Commandes",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 FutureBuilder pour charger les commandes
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _ordersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Lottie.asset(
                      "assets/lottie/Trail loading.json",
                      width: 100,
                      height: 100,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("Erreur: ${snapshot.error.toString()}"),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      "Aucune commande trouvée.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                final orders = snapshot.data!;
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final createdAt = DateTime.tryParse(
                      order['createdAt'] ?? "",
                    );
                    final formattedDate =
                        createdAt != null
                            ? DateFormat("dd/MM/yyyy HH:mm").format(createdAt)
                            : order['createdAt'];

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          "Package: ${order['packageId']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Date: $formattedDate"),
                        trailing: Icon(
                          order['status'] == "pending"
                              ? Icons.schedule
                              : order['status'] == "completed"
                              ? Icons.check_circle
                              : Icons.error,
                          color:
                              order['status'] == "completed"
                                  ? Colors.green
                                  : order['status'] == "pending"
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderDetailScreen(order: order),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "pending":
        return Icons.schedule;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.tryParse(order['createdAt'] ?? "");
    final formattedDate =
        createdAt != null
            ? DateFormat("dd/MM/yyyy HH:mm").format(createdAt)
            : order['createdAt'];

    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header custom
          Container(
            margin: const EdgeInsets.only(top: 22),
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.blue[700]),
                ),
                const SizedBox(width: 16),
                Text(
                  "Détails de la commande",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Contenu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.numbers),
                      title: const Text("ID"),
                      subtitle: Text(order['id'] ?? "N/A"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.padding),
                      title: const Text("Package"),
                      subtitle: Text(order['packageId'] ?? "N/A"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        _getStatusIcon(order['status'] ?? ""),
                        color: _getStatusColor(order['status'] ?? ""),
                      ),
                      title: const Text("Status"),
                      subtitle: Text(order['status'] ?? "N/A"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text("Date"),
                      subtitle: Text(formattedDate ?? "N/A"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}







/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrdersScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 Header custom sans AppBar
          Container(
            margin: const EdgeInsets.only(top: 22),
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "kONNECTI",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Liste des commandes
          orders.isEmpty
              ? const Expanded(
                child: Center(
                  child: Text(
                    "Aucune commande trouvée.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              )
              : Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final createdAt = DateTime.tryParse(
                      order['createdAt'] ?? "",
                    );
                    final formattedDate =
                        createdAt != null
                            ? DateFormat("dd/MM/yyyy HH:mm").format(createdAt)
                            : order['createdAt'];

                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          "Package: ${order['packageName'] ?? order['packageId']}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Date: $formattedDate"),
                        trailing: Icon(
                          order['status'] == "pending"
                              ? Icons.schedule
                              : order['status'] == "completed"
                              ? Icons.check_circle
                              : Icons.error,
                          color:
                              order['status'] == "completed"
                                  ? Colors.green
                                  : order['status'] == "pending"
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OrderDetailScreen(order: order),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 👉 Rafraîchir depuis API
        },
        child: const Icon(Icons.refresh, color: Colors.blue),
      ),
    );
  }
}

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({super.key, required this.order});

  Color _getStatusColor(String status) {
    switch (status) {
      case "completed":
        return Colors.green;
      case "pending":
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "completed":
        return Icons.check_circle;
      case "pending":
        return Icons.schedule;
      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final createdAt = DateTime.tryParse(order['createdAt'] ?? "");
    final formattedDate =
        createdAt != null
            ? DateFormat("dd/MM/yyyy HH:mm").format(createdAt)
            : order['createdAt'];

    return Scaffold(
      body: Column(
        children: [
          // 🔹 Header custom
          Container(
            margin: const EdgeInsets.only(top: 22),
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.blue[700]),
                ),
                const SizedBox(width: 16),
                Text(
                  "Détails de la commande",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),

          // 🔹 Contenu
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.numbers),
                      title: const Text("ID"),
                      subtitle: Text(order['id'] ?? "N/A"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.padding),
                      title: const Text("Package"),
                      subtitle: Text(
                        order['packageName'] ?? order['packageId'] ?? "N/A",
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        _getStatusIcon(order['status'] ?? ""),
                        color: _getStatusColor(order['status'] ?? ""),
                      ),
                      title: const Text("Status"),
                      subtitle: Text(order['status'] ?? "N/A"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: const Text("Date"),
                      subtitle: Text(formattedDate ?? "N/A"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Exemple de données mock (à remplacer par ton API)
final mockOrders = [
  {
    "id": "ORD001",
    "packageName": "eSIM 5GB",
    "createdAt": "2025-09-10T12:30:00Z",
    "status": "completed",
  },
  {
    "id": "ORD002",
    "packageName": "eSIM 10GB",
    "createdAt": "2025-09-12T08:45:00Z",
    "status": "pending",
  },
  {
    "id": "ORD003",
    "packageName": "eSIM Unlimited",
    "createdAt": "2025-09-14T20:10:00Z",
    "status": "failed",
  },
];
*/