class MyRoutes {
  // ==================== Authentication ====================

  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static String forgotPasswordRoute = "/forgot-password";
  static String resetPasswordRoute = "/reset-password";


  // ==================== Buyer ====================

  static const String buyerHomeRoute = "/buyer-home";
  static const String searchRoute = "/search";
  static const String wishlistRoute = "/wishlist";
  static const String visitsRoute = "/visits";
  static const String profileRoute = "/profile";
  static const String splashRoute = "/splash";
  static const String welcomeRoute = "/welcome";


  // ==================== Buyer Deal ====================

  static const String buyerDealRequestRoute = "/buyer-deal-request";
  static const String buyerDealDocumentsRoute = "/buyer-deal-documents";
  static const String buyerDealPaymentRoute = "/buyer-deal-payment";


  // ==================== Buyer Features ====================

  static const String priceComparisonRoute = "/price-comparison";
  static const String nearbyPropertyRoute = "/nearby-property";
  static const String calculatorRoute = "/calculator";
  static const String propertyDetailRoute = "/property-detail";


  // ==================== Buyer Profile ====================

  static const String changePasswordRoute = "/change-password";
  static const String helpSupportRoute = "/help-support";
  static const String aboutRoute = "/about";
  static const String privacyPolicyRoute = "/privacy-policy";
  static const String notificationRoute = '/notifications';


  // ==================== Broker Registration ====================

  static const String brokerVerificationRoute = "/broker-verification";
  static const String brokerPendingRoute = "/broker-pending";
  static const String brokerPaymentRoute = "/broker-payment";


  // ==================== Admin ====================

  static const String adminHomeRoute = '/admin-home';
  static const String adminUsersRoute = '/admin-users';
  static const String adminBrokersRoute = '/admin-brokers';
  static const String adminPropertiesRoute = '/admin-properties';
  static const String adminVerificationRoute = '/admin-verification';
  static const String adminReportsRoute = '/admin-reports';
  static const String adminAnalyticsRoute = '/admin-analytics';
  static const String adminProfileRoute = '/admin-profile';


  // ==================== Broker ====================

  static const String brokerHomeRoute = "/broker-home";


  // ==================== Broker Properties ====================

  static const String brokerPropertiesRoute = "/broker-properties";
  static const String addPropertyRoute = "/add-property";
  static const String propertyDetailsRoute = "/property-details";


  // ==================== Broker Visits ====================

  static const String brokerVisitsRoute = "/broker-visits";
  static const String visitDetailsRoute = "/visit-details";
  static const String brokerCalendarRoute = "/broker-calendar";


  // ==================== Broker Buyers / Deals ====================

  static const String brokerBuyersRoute = "/broker-buyers";
  static const String brokerDealRequestsRoute = "/broker-deal-requests";
  static const String brokerDealDetailsRoute = "/broker-deal-details";
  static const String brokerDocumentVerificationRoute =
      "/broker-document-verification";


  // ==================== Broker Profile ====================

  static const String brokerProfileRoute = "/broker-profile";
}