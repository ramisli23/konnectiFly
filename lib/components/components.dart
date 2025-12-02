library component;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';

import 'package:konnecti/components/cards/PaymentWebView.dart';
import 'package:konnecti/components/cards/balance.dart';
import 'package:konnecti/invoisescreen.dart';
import 'package:konnecti/modules/country.dart';
import 'package:konnecti/modules/package_pricing.dart';
import 'package:konnecti/providers/AuthProvider.dart';
import 'package:konnecti/providers/auth_storage.dart';
import 'package:konnecti/providers/cart/CartProvider.dart';
import 'package:konnecti/providers/order/order_provider.dart';

import 'package:konnecti/providers/packages_provider.dart';
import 'package:konnecti/providers/purchase/DataOnly_provider.dart';
import 'package:konnecti/providers/purchase/datavoicesmsServiceProvider.dart';
import 'package:konnecti/services/EsimService/EsimService.dart';
import 'package:konnecti/services/auth_logout.dart' show AuthLogout;
import 'package:konnecti/services/signinservice.dart';
import 'package:konnecti/widgets/buyEsim/language.dart';
import 'package:konnecti/widgets/country_card.dart';

import 'package:konnecti/widgets/country_carousel.dart';
import 'package:konnecti/widgets/order/order_detail.dart';
import 'package:konnecti/widgets/orderConfirmation/AvailbleBlance.dart';
import 'package:konnecti/widgets/orderConfirmation/CustomStepper.dart';
import 'package:konnecti/widgets/orderConfirmation/orderSummary.dart';
import 'package:konnecti/widgets/purshaseDetail/Dataonlydetail.dart';

import 'package:konnecti/widgets/refeil/refil.dart';
import 'package:konnecti/widgets/welcome_header.dart';
import 'package:konnecti/widgets/search_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:konnecti/l10n/app_localizations.dart';

import 'package:konnecti/widgets/buyEsim/topheader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart' show WebViewWidget;
import '../widgets/login_form.dart';
import 'package:konnecti/widgets/buyEsim/Dataoptions.dart';

import 'package:konnecti/widgets/buyEsim/Downloads.dart';
import 'package:konnecti/widgets/buyEsim/localCountries.dart';
import 'package:konnecti/widgets/buyEsim/regionalesims.dart';
import 'package:konnecti/widgets/buyesimDetails/offrecards.dart';
import 'package:konnecti/widgets/buyesimDetails/preparedTravel.dart';
import 'package:konnecti/widgets/buyesimDetails/switchbar.dart';
import 'package:lottie/lottie.dart';
part 'cards/Login.dart';
part 'cards/Signup.dart';
part 'cards/verification.dart';
part 'cards/splashscreen3.dart';
part 'cards/spalashscreen1.dart';
part 'cards/splashscreen2.dart';
part 'cards/ConfirmationOrder.dart';
part 'cards/Myesim.dart';
part 'cards/profile.dart';
part 'cards/cardEmpty.dart';
part 'cards/buyesimDetails.dart';
part 'cards/buy_esim_screen.dart';
part 'cards/home_screen.dart';
part 'cards/bottom_bar_only_page.dart';
part 'cards/terms_conditions.dart';
part 'cards/privacyPolicay.dart';

part 'cards/bottom_bar_out_page.dart';
part 'cards/Home_screen_out.dart';
