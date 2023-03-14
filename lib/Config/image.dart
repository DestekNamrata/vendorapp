class Images {
  static const String splash = "assets/images/splash.png";
  static const String backgroung = "assets/images/BG.png";
  static const String minus = "assets/images/minus.png";
  static const String profile_icon = "assets/images/profile-icon.png";
  static const String bg = "assets/images/bg.png";
  static const String notiIcon = "assets/images/noti_icon.png";
  static const String logo = "assets/images/Logo.png";
  static const String dashboard = "assets/images/bottom_dashboard.png";
  static const String product = "assets/images/bottom_product.png";
  static const String order = "assets/images/bottom_order.png";
  static const String sales = "assets/images/bottom_sales.png";
  static const String profile = "assets/images/bottom_profile.png";
  static const String myLoc = "assets/images/my_loc.png";
  static const String search = "assets/images/search_icon.png";
  static const String roundCancel = "assets/images/round_cancel.png";
  static const String dashBg = "assets/images/dashboard_bg.png";
  static const String sortIcon = "assets/images/sort_icon.png";
  static const String filterIcon = "assets/images/filter.png";


  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
