import 'dart:ui';

import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const arrowForward = "assets/icons/arrow_forward.svg";
  static const arrowRight = "assets/icons/arrow_right.svg";
  static const orders = "assets/icons/orders.svg";
  static const home = "assets/icons/home.svg";
  static const employs = "assets/icons/employs.svg";
  static const carbonDashboard = "assets/icons/carbon_dashboard.svg";
  static const tablerEdit = "assets/icons/tabler_edit.svg";
  static const sklad = "assets/icons/sklad.svg";
  static const carbonProduct = "assets/icons/carbon_product.svg";
  static const firma = "assets/icons/firma.svg";
  static const history = "assets/icons/history.svg";
  static const indebtedness = "assets/icons/indebtedness.svg";
  static const profile = "assets/icons/profile.svg";
  static const info = "assets/icons/info.svg";
  static const language = "assets/icons/language.svg";
  static const moon = "assets/icons/moon.svg";
  static const support = "assets/icons/support.svg";
  static const mamnun = "assets/icons/mamnun.svg";
  static const turnOff = "assets/icons/turn_off.svg";

  static const random = "assets/icons/random.svg";
  static const list = "assets/icons/list.svg";
  static const word = "assets/icons/word.svg";
  static const phrase = "assets/icons/phrase.svg";
  static const principle = "assets/icons/principle.svg";
  static const star = "assets/icons/star.svg";
  static const uz = "assets/icons/uz.svg";
  static const en = "assets/icons/en_1.svg";
  static const mix = "assets/icons/mix.svg";
  static const how = "assets/icons/how.svg";
  static const write = "assets/icons/write.svg";
}

extension SvgExt on String {
  SvgPicture svg({
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      this,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
}
