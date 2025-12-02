import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:konnecti/components/components.dart';
import 'package:konnecti/dependency_injenction.dart';
import 'package:konnecti/l10n/app_localizations.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:konnecti/providers/BalanceProvider.dart';
import 'package:konnecti/providers/cart/CartProvider.dart';
import 'package:konnecti/providers/languageprovider.dart';
import 'package:konnecti/providers/order/order_provider.dart';
import 'package:konnecti/providers/packages_provider.dart';
import 'package:konnecti/providers/Esim/esim_provider.dart';
import 'package:konnecti/providers/offer_provider.dart';
import 'package:konnecti/providers/purchase/DataOnly_provider.dart';
import 'package:konnecti/services/EsimService/EsimService.dart';
import 'package:konnecti/services/packages_service.dart';
import 'package:konnecti/services/api_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadAuthData();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLanguageCode = prefs.getString('selected_language');
  Locale initialLocale = Locale(savedLanguageCode ?? 'en');

  const BASE_URL = "https://backend-bumm.onrender.com";

  runApp(
    MultiProvider(
      providers: [
        // ✅ Simple Providers
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider(initialLocale)),
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),

        // ✅ AuthProvider global
        ChangeNotifierProvider.value(value: authProvider),

        // ✅ DataOnlyProvider (avec token dynamique)
        ChangeNotifierProxyProvider<AuthProvider, DataonlyProvider>(
          create: (_) => DataonlyProvider(baseUrl: BASE_URL, token: ""),
          update:
              (_, auth, __) => DataonlyProvider(
                baseUrl: BASE_URL,
                token: auth.accessToken ?? "",
              ),
        ),

        // ✅ PackagesProvider
        ChangeNotifierProxyProvider<AuthProvider, PackagesProvider>(
          create:
              (_) => PackagesProvider(
                PackagesService(ApiClient(baseUrl: BASE_URL, token: "")),
              ),
          update:
              (_, auth, __) => PackagesProvider(
                PackagesService(
                  ApiClient(baseUrl: BASE_URL, token: auth.accessToken ?? ""),
                ),
              ),
        ),

        // ✅ OrderProvider
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (_) => OrderProvider(BASE_URL, ""),
          update:
              (_, auth, __) => OrderProvider(BASE_URL, auth.accessToken ?? ""),
        ),

        // ✅ EsimProvider
        ChangeNotifierProxyProvider<AuthProvider, EsimProvider>(
          create:
              (_) => EsimProvider(
                esimService: EsimService(baseUrl: BASE_URL, token: ""),
              ),
          update:
              (_, auth, __) => EsimProvider(
                esimService: EsimService(
                  baseUrl: BASE_URL,
                  token: auth.accessToken ?? "",
                ),
              ),
        ),
      ],

      child: MyApp(isLoggedIn: authProvider.accessToken != null),
    ),
  );

  DependencyInjection.init();
}

// ============================================================

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return GetMaterialApp(
      title: 'Konnecti',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
        Locale('es'),
        Locale('zh'),
      ],
      locale: languageProvider.locale,
      home: isLoggedIn ? const BottomBarOnlyPage() : const BottomBarOutPage(),
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart'; // 👈 Import GetX complet
import 'package:konnecti/components/components.dart';
import 'package:konnecti/dependency_injenction.dart';
import 'package:konnecti/l10n/app_localizations.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:konnecti/providers/BalanceProvider.dart';
import 'package:konnecti/providers/Esim/esim_provider.dart';
import 'package:konnecti/providers/cart/CartProvider.dart';
import 'package:konnecti/providers/languageprovider.dart';
import 'package:konnecti/providers/order/order_provider.dart';
import 'package:konnecti/providers/packages_provider.dart';
import 'package:konnecti/providers/purchase/DataOnly_provider.dart';
import 'package:konnecti/providers/purchase/datavoicesmsServiceProvider.dart';
import 'package:konnecti/services/EsimService/EsimService.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/offer_provider.dart'; // 👈 Assure-toi d’importer ton écran

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadAuthData();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
  String? savedLanguageCode = prefs.getString('selected_language');

  Locale initialLocale = Locale(savedLanguageCode ?? 'en');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider(initialLocale)),
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (_) => OrderProvider("https://backend-bumm.onrender.com", ""),
          update:
              (_, authProvider, previous) => OrderProvider(
                "https://backend-bumm.onrender.com",
                authProvider.accessToken ?? "",
              ),
        ),

        ChangeNotifierProxyProvider<AuthProvider, Datavoicesmsserviceprovider>(
          create:
              (_) => Datavoicesmsserviceprovider(
                "https://backend-bumm.onrender.com",
                "",
              ),
          update:
              (_, authProvider, previous) => Datavoicesmsserviceprovider(
                "https://backend-bumm.onrender.com",
                authProvider.accessToken ?? "",
              ),
        ),

        ChangeNotifierProxyProvider<AuthProvider, DataonlyProvider>(
          create:
              (_) => DataonlyProvider(
                baseUrl: "https://backend-bumm.onrender.com",
                token: "",
              ),
          update: (_, authProvider, previous) {
            previous ??= DataonlyProvider(
              baseUrl: "https://backend-bumm.onrender.com",
              token: "",
            );
            previous.updateToken(authProvider.accessToken ?? "");
            return previous;
          },
        ),

        ChangeNotifierProxyProvider<AuthProvider, PackagesProvider>(
          create:
              (_) => PackagesProvider("https://backend-bumm.onrender.com", ""),
          update:
              (_, authProvider, previous) => PackagesProvider(
                "https://backend-bumm.onrender.com",
                authProvider.accessToken ?? "",
              ),
        ),

        ChangeNotifierProxyProvider<AuthProvider, EsimProvider>(
          create:
              (_) => EsimProvider(
                esimService: EsimService(
                  baseUrl: "https://backend-bumm.onrender.com",
                  token: "",
                ),
              ),
          update:
              (_, authProvider, previous) => EsimProvider(
                esimService: EsimService(
                  baseUrl: "https://backend-bumm.onrender.com",
                  token: authProvider.accessToken ?? "",
                ),
              ),
        ),
      ],
      child: MyApp(isLoggedIn: token != null),
    ),
  );
  DependencyInjection.init();
}*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.loadAuthData(); // charge le token depuis SharedPreferences

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedLanguageCode = prefs.getString('selected_language');
  Locale initialLocale = Locale(savedLanguageCode ?? 'en');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OfferProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider(initialLocale)),
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider.value(
          value: authProvider,
        ), // 👈 utilise celui chargé
        // Les autres proxy providers restent inchangés...
        ChangeNotifierProxyProvider<AuthProvider, OrderProvider>(
          create: (_) => OrderProvider("https://backend-bumm.onrender.com", ""),
          update:
              (_, auth, __) => OrderProvider(
                "https://backend-bumm.onrender.com",
                auth.accessToken ?? "",
              ),
        ),

        // ... etc pour tes autres providers
      ],
      child: MyApp(isLoggedIn: authProvider.accessToken != null),
    ),
  );

  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return GetMaterialApp(
      // 👈 ici on utilise GetMaterialApp (PAS MaterialApp)
      title: 'Konnecti',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
        Locale('es'),
        Locale('zh'),
      ],
      locale: languageProvider.locale,
      home: isLoggedIn ? const BottomBarOnlyPage() : const SplashScreen1(),
      // 👆 SplashScreen2 devient l’écran d’accueil si non connecté
    );
  }
}
*/