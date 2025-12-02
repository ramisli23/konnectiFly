part of component;

class DeveloperProfilePage extends StatefulWidget {
  const DeveloperProfilePage({super.key});

  @override
  State<DeveloperProfilePage> createState() => _DeveloperProfilePageState();
}

class _DeveloperProfilePageState extends State<DeveloperProfilePage> {
  bool isLoadingLogout = false;
  final AuthLogout authLogout = AuthLogout();

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String? token = await AuthStorage.getAccessToken();
    if (token != null) {
      Provider.of<AuthProvider>(context, listen: false).setAccessToken(token);
    } else {
      // Naviguer vers SplashScreen si aucun token
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> options = [
      {
        'title': local.languages,
        'subtitle': local.chooseLanguages,
        'icon': Icons.language,
        'route': const Language(),
      },
      {
        'title': local.terms,
        'subtitle': local.readTerms,
        'icon': Icons.rule_folder_outlined,
        'route': const TermsConditions(),
      },
      {
        'title': local.privacy,
        'subtitle': local.readPrivacy,
        'icon': Icons.privacy_tip,
        'route': const InvoiceCreationScreen(),
      },
      {
        'title': local.contact,
        'subtitle': local.getHelp,
        'icon': Icons.help,
        'route': OrdersScreen(userId: "23c8a481-de21-4d98-8297-6f0f8bea75ec"),
      },

      {
        'title': local.deleteAccount,
        'subtitle': local.deleteHelp,
        'icon': Icons.delete,
        'route': const LoginScreen(),
      },
      {
        'title': local.logout,
        'subtitle': local.missed,
        'icon': Icons.logout,
        'route': null,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),
            ...options
                .map((item) => _buildOptionTile(context, item, local))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    Map<String, dynamic> item,
    AppLocalizations local,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.94),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(item['icon'], color: Colors.black),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          item['subtitle'],
          style: const TextStyle(color: Colors.white70),
        ),
        trailing:
            (item['title'] == local.logout && isLoadingLogout)
                ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                : const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: 18,
                ),
        onTap:
            (item['title'] == local.logout && isLoadingLogout)
                ? null
                : () async {
                  if (item['title'] == local.languages) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      builder:
                          (context) => const Padding(
                            padding: EdgeInsets.only(top: 16.0),
                            child: FractionallySizedBox(
                              heightFactor: 0.75,
                              child: Language(),
                            ),
                          ),
                    );
                  } else if (item['title'] == local.logout) {
                    await _handleLogout();
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => item['route']),
                    );
                  }
                },
      ),
    );
  }

  Future<void> _handleLogout() async {
    setState(() {
      isLoadingLogout = true;
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.accessToken;

    if (token == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous n’êtes pas connecté.')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SplashScreen1()),
        (route) => false,
      );
      setState(() {
        isLoadingLogout = false;
      });
      return;
    }

    final result = await authLogout.logout(context, token);

    setState(() {
      isLoadingLogout = false;
    });

    if (result['success']) {
      authProvider.logout();

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const SplashScreen1()),
        (route) => false,
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message'] ?? 'Erreur lors de la déconnexion'),
        ),
      );
    }
  }
}
