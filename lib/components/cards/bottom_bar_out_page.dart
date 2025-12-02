part of component;
// 👉 Assure-toi que le chemin est correct

class BottomBarOutPage extends StatefulWidget {
  const BottomBarOutPage({super.key});

  @override
  State<BottomBarOutPage> createState() => _BottomBarOutPagState();
}

class _BottomBarOutPagState extends State<BottomBarOutPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreenOut(), // 👈 Ta vraie page d'accueil
    BuyEsimScreen(),
    LoginScreen(),
    DeveloperProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _pages[_selectedIndex], // 👈 Page dynamique
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.blue,
        buttonBackgroundColor: Colors.blue,
        height: 60,
        animationDuration: Duration(milliseconds: 250),
        index: _selectedIndex,
        items: const [
          Icon(Icons.home, size: 30, color: Colors.white), // Accueil
          Icon(Icons.sim_card, size: 30, color: Colors.white),
          Icon(Icons.login, size: 30, color: Colors.white), // Profil
          Icon(Icons.account_box, size: 30, color: Colors.white), // Paramètres
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
