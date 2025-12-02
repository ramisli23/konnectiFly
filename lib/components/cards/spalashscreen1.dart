part of component;

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: heightScreen * 0.2),
            Center(
              child: Image.asset(
                "assets/images/png/splash.png",
                height: heightScreen * 0.22,
                width: widthScreen * 0.8,
              ),
            ),
            SizedBox(height: heightScreen * 0.08),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "Explore The \nworld Easly",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "To your desire",
                    style: TextStyle(color: Colors.black, fontSize: 36),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/png/Rectangle 2.png",
                    width: 16,
                    height: 6,
                  ),
                  SizedBox(width: 2),
                  Image.asset(
                    "assets/images/png/Rectangle 3.png",
                    width: 16,
                    height: 6,
                  ),
                  SizedBox(width: 2),
                  Image.asset(
                    "assets/images/png/Rectangle 3.png",
                    width: 16,
                    height: 6,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SplashScreen2(),
                        ),
                      );
                    },
                    child: Image.asset(
                      "assets/images/png/Next Button.png",
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
