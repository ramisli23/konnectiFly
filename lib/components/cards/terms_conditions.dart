part of component;

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.terms,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),*/
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(),
              _Title(AppLocalizations.of(context)!.terms1Title),
              _Text(AppLocalizations.of(context)!.terms1Content),

              _Title(AppLocalizations.of(context)!.terms2Title),
              _Text(AppLocalizations.of(context)!.terms2Content),

              _Title(AppLocalizations.of(context)!.terms3Title),
              _Text(AppLocalizations.of(context)!.terms3Content),

              _Title(AppLocalizations.of(context)!.terms4Title),
              _Text(AppLocalizations.of(context)!.terms4Content),

              _Title(AppLocalizations.of(context)!.terms5Title),
              _Text(AppLocalizations.of(context)!.terms5Content),

              _Title(AppLocalizations.of(context)!.terms6Title),
              _Text(AppLocalizations.of(context)!.terms6Content),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Title(String title) {
    return Text(
      "$title",
      style: TextStyle(
        color: Colors.black,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _Text(String text) {
    return Text("$text", style: TextStyle(color: Colors.black, fontSize: 14));
  }
}
