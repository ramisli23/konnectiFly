part of component;
// 👉 Assure-toi que le chemin est correct

class BottomBarOnlyPage extends StatefulWidget {
  const BottomBarOnlyPage({super.key});

  @override
  State<BottomBarOnlyPage> createState() => _BottomBarOnlyPageState();
}

class _BottomBarOnlyPageState extends State<BottomBarOnlyPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(), // 👈 Ta vraie page d'accueil
    BuyEsimScreen(),
    Myesim(),
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
          Icon(Icons.credit_card, size: 30, color: Colors.white), // Profil
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
