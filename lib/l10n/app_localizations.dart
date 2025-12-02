import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('zh'),
    Locale('fr')
  ];

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @createFreeAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a free account'**
  String get createFreeAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @validEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validEmail;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @strongPassword.
  ///
  /// In en, this message translates to:
  /// **'Strong password'**
  String get strongPassword;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get agreeToTerms;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get terms;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @conditions.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get conditions;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @alreadyMember.
  ///
  /// In en, this message translates to:
  /// **'Already a member?'**
  String get alreadyMember;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signInToAccess.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your account'**
  String get signInToAccess;

  /// No description provided for @newMember.
  ///
  /// In en, this message translates to:
  /// **'New member?'**
  String get newMember;

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgetPassword;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @welcomeText.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Turkey 🇹🇷'**
  String get welcomeText;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search the desired section...'**
  String get searchHint;

  /// No description provided for @myEsim.
  ///
  /// In en, this message translates to:
  /// **'My eSIM'**
  String get myEsim;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Calls'**
  String get call;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @totalData.
  ///
  /// In en, this message translates to:
  /// **'Total data'**
  String get totalData;

  /// No description provided for @totalMinutes.
  ///
  /// In en, this message translates to:
  /// **'Total minutes'**
  String get totalMinutes;

  /// No description provided for @totalSms.
  ///
  /// In en, this message translates to:
  /// **'Total SMS'**
  String get totalSms;

  /// No description provided for @conversation.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get conversation;

  /// No description provided for @offers.
  ///
  /// In en, this message translates to:
  /// **'Offers'**
  String get offers;

  /// No description provided for @downloadsCount.
  ///
  /// In en, this message translates to:
  /// **'500000+'**
  String get downloadsCount;

  /// No description provided for @downloadsLabel.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloadsLabel;

  /// No description provided for @downloadsTitle.
  ///
  /// In en, this message translates to:
  /// **'Konnecti for easy travel connectivity'**
  String get downloadsTitle;

  /// No description provided for @downloadsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Konnecti - Fast and affordable connectivity'**
  String get downloadsSubtitle;

  /// No description provided for @dataOnly.
  ///
  /// In en, this message translates to:
  /// **'Data only Konnecti'**
  String get dataOnly;

  /// No description provided for @dataVoice.
  ///
  /// In en, this message translates to:
  /// **'Data + Calls Konnecti'**
  String get dataVoice;

  /// No description provided for @localEsims.
  ///
  /// In en, this message translates to:
  /// **'Local eSIMs'**
  String get localEsims;

  /// No description provided for @regionalEsims.
  ///
  /// In en, this message translates to:
  /// **'Regional eSIMs'**
  String get regionalEsims;

  /// No description provided for @globalEsims.
  ///
  /// In en, this message translates to:
  /// **'Global eSIMs'**
  String get globalEsims;

  /// No description provided for @globalComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Global eSIMs coming soon...'**
  String get globalComingSoon;

  /// No description provided for @exploreEsimsTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover our range of eSIMs for over 200 destinations'**
  String get exploreEsimsTitle;

  /// No description provided for @startsFrom.
  ///
  /// In en, this message translates to:
  /// **'Starts from'**
  String get startsFrom;

  /// No description provided for @regionalEsimSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discover regional eSIMs in different regions'**
  String get regionalEsimSubtitle;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @offersTitle.
  ///
  /// In en, this message translates to:
  /// **'Available offers for'**
  String get offersTitle;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @shareWithFriends.
  ///
  /// In en, this message translates to:
  /// **'Share with your friends and family'**
  String get shareWithFriends;

  /// No description provided for @createTickets.
  ///
  /// In en, this message translates to:
  /// **'Create tickets'**
  String get createTickets;

  /// No description provided for @generateTickets.
  ///
  /// In en, this message translates to:
  /// **'Please generate tickets here'**
  String get generateTickets;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @chooseLanguages.
  ///
  /// In en, this message translates to:
  /// **'Choose from 8 languages to connect'**
  String get chooseLanguages;

  /// No description provided for @readTerms.
  ///
  /// In en, this message translates to:
  /// **'Read our Terms and Conditions'**
  String get readTerms;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacy;

  /// No description provided for @readPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Read our Privacy Policy'**
  String get readPrivacy;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get help from our agents'**
  String get getHelp;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteHelp.
  ///
  /// In en, this message translates to:
  /// **'We are here to help you'**
  String get deleteHelp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @missed.
  ///
  /// In en, this message translates to:
  /// **'We will miss you'**
  String get missed;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change photo'**
  String get changePhoto;

  /// No description provided for @terms1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get terms1Title;

  /// No description provided for @terms1Content.
  ///
  /// In en, this message translates to:
  /// **'Welcome to our eSIM service. These Terms and Conditions govern your access and use of our digital SIM card (eSIM) services. By purchasing or activating an eSIM, you agree to be bound by these Terms.'**
  String get terms1Content;

  /// No description provided for @terms2Title.
  ///
  /// In en, this message translates to:
  /// **'2. Definitions'**
  String get terms2Title;

  /// No description provided for @terms2Content.
  ///
  /// In en, this message translates to:
  /// **'eSIM: An embedded SIM card downloaded and activated digitally.\nUser: The person who purchases and/or activates the eSIM.\nService provider: The mobile operator or reseller offering the eSIM.\nDevice: A mobile device compatible with eSIM technology.'**
  String get terms2Content;

  /// No description provided for @terms3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Eligibility'**
  String get terms3Title;

  /// No description provided for @terms3Content.
  ///
  /// In en, this message translates to:
  /// **'To use the eSIM service, you must:\nOwn an eSIM-compatible device.\nHave an active Internet connection during activation.\nBe legally capable of entering into a binding contract.'**
  String get terms3Content;

  /// No description provided for @terms4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Service activation'**
  String get terms4Title;

  /// No description provided for @terms4Content.
  ///
  /// In en, this message translates to:
  /// **'The eSIM QR codes and activation instructions will be provided after purchase.\nActivation may take from a few minutes to several hours depending on the operator.\nThe user is responsible for providing the correct device information.'**
  String get terms4Content;

  /// No description provided for @terms5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Use of the service'**
  String get terms5Title;

  /// No description provided for @terms5Content.
  ///
  /// In en, this message translates to:
  /// **'The eSIM is for personal use only and must not be resold, reused, or transferred without authorization.\nThe user agrees not to misuse or use the service illegally.\nVoice and data plans are subject to the provider’s limitations and fair use policy.'**
  String get terms5Content;

  /// No description provided for @terms6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Pricing and payments'**
  String get terms6Title;

  /// No description provided for @terms6Content.
  ///
  /// In en, this message translates to:
  /// **'All prices are stated in the specified currency and may include applicable taxes.\nPayments are non-refundable unless otherwise stated.\nOnce activated, the eSIM cannot be transferred to another device or account.'**
  String get terms6Content;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicyTitle;

  /// No description provided for @privacy1Title.
  ///
  /// In en, this message translates to:
  /// **'1. Information we collect'**
  String get privacy1Title;

  /// No description provided for @privacy1a.
  ///
  /// In en, this message translates to:
  /// **'a. Personal information'**
  String get privacy1a;

  /// No description provided for @privacy1aList.
  ///
  /// In en, this message translates to:
  /// **'Full name\nEmail address\nPhone number\nBilling address\nPayment information (handled by a third party)'**
  String get privacy1aList;

  /// No description provided for @privacy1b.
  ///
  /// In en, this message translates to:
  /// **'b. Device information'**
  String get privacy1b;

  /// No description provided for @privacy1bList.
  ///
  /// In en, this message translates to:
  /// **'Device model and brand\nOperating system\nIMEI or eSIM compatible ID (if required)'**
  String get privacy1bList;

  /// No description provided for @privacy1c.
  ///
  /// In en, this message translates to:
  /// **'c. Usage data'**
  String get privacy1c;

  /// No description provided for @privacy1cList.
  ///
  /// In en, this message translates to:
  /// **'Activation date and time\nData usage statistics\nIP address\nLocation data (compliance and fraud prevention)'**
  String get privacy1cList;

  /// No description provided for @privacy2Title.
  ///
  /// In en, this message translates to:
  /// **'2. How we use your information'**
  String get privacy2Title;

  /// No description provided for @privacy2Body.
  ///
  /// In en, this message translates to:
  /// **'We use your data to:\n• Activate your eSIM\n• Provide our services and customer support\n• Send notifications\n• Prevent fraud\n• Comply with laws\n• Improve our services'**
  String get privacy2Body;

  /// No description provided for @privacy3Title.
  ///
  /// In en, this message translates to:
  /// **'3. Sharing your information'**
  String get privacy3Title;

  /// No description provided for @privacy3Body.
  ///
  /// In en, this message translates to:
  /// **'We may share your data with:\n• Mobile operators\n• Payment processors\n• Service providers\n• Authorities (if required by law)\nWe do not sell your data.'**
  String get privacy3Body;

  /// No description provided for @privacy4Title.
  ///
  /// In en, this message translates to:
  /// **'4. Data storage and security'**
  String get privacy4Title;

  /// No description provided for @privacy4Body.
  ///
  /// In en, this message translates to:
  /// **'Your data is protected with encryption technologies. We use firewalls and secure servers.'**
  String get privacy4Body;

  /// No description provided for @privacy5Title.
  ///
  /// In en, this message translates to:
  /// **'5. Your rights'**
  String get privacy5Title;

  /// No description provided for @privacy5Body.
  ///
  /// In en, this message translates to:
  /// **'You can request access, correction, or deletion of your data. Contact us at: support@yourdomain.com'**
  String get privacy5Body;

  /// No description provided for @privacy6Title.
  ///
  /// In en, this message translates to:
  /// **'6. Cookies and tracking'**
  String get privacy6Title;

  /// No description provided for @privacy6Body.
  ///
  /// In en, this message translates to:
  /// **'We use cookies to analyze the site, remember your preferences, and improve functionality.'**
  String get privacy6Body;

  /// No description provided for @privacy7Title.
  ///
  /// In en, this message translates to:
  /// **'7. International transfers'**
  String get privacy7Title;

  /// No description provided for @privacy7Body.
  ///
  /// In en, this message translates to:
  /// **'Your data may be transferred abroad in compliance with the law (e.g. GDPR).'**
  String get privacy7Body;

  /// No description provided for @privacy8Title.
  ///
  /// In en, this message translates to:
  /// **'8. Children’s privacy'**
  String get privacy8Title;

  /// No description provided for @privacy8Body.
  ///
  /// In en, this message translates to:
  /// **'Our services are not intended for children under 13 (or 16 depending on region).'**
  String get privacy8Body;

  /// No description provided for @privacy9Title.
  ///
  /// In en, this message translates to:
  /// **'9. Changes to this policy'**
  String get privacy9Title;

  /// No description provided for @privacy9Body.
  ///
  /// In en, this message translates to:
  /// **'We may update this policy and notify you if necessary.'**
  String get privacy9Body;

  /// No description provided for @privacy10Title.
  ///
  /// In en, this message translates to:
  /// **'10. Contact us'**
  String get privacy10Title;

  /// No description provided for @privacy10Body.
  ///
  /// In en, this message translates to:
  /// **'[Company name]\nEmail: support@yourdomain.com\nPhone: +123-456-7890\nAddress: [Your address]'**
  String get privacy10Body;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'es', 'zh', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'zh': return AppLocalizationsZh();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
