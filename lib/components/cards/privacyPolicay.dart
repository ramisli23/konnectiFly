part of component;

class Privacypolicay extends StatelessWidget {
  const Privacypolicay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(),

              const SizedBox(height: 20),
              _Title(AppLocalizations.of(context)!.privacy1Title),
              const SizedBox(height: 10),
              _Text(AppLocalizations.of(context)!.privacy1a),
              _Text(AppLocalizations.of(context)!.privacy1a),
              _Text(AppLocalizations.of(context)!.privacy1bList),

              const SizedBox(height: 20),
              _Title(AppLocalizations.of(context)!.privacy2Title),
              const SizedBox(height: 10),
              _Text(AppLocalizations.of(context)!.privacy1b),

              const SizedBox(height: 20),
              _Title(AppLocalizations.of(context)!.privacy3Title),
              const SizedBox(height: 10),
              _Text(AppLocalizations.of(context)!.privacy1c),

              const SizedBox(height: 20),
              _Title(AppLocalizations.of(context)!.privacy4Title),
              const SizedBox(height: 10),
              _Text(AppLocalizations.of(context)!.privacy1c),

              const SizedBox(height: 30),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.privacy,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Title(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _Text(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.black87, fontSize: 14, height: 1.5),
    );
  }
}
