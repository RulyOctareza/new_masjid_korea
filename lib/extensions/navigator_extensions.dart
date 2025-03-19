import 'package:flutter/material.dart';

extension NavigatorExtensions on BuildContext {
  /// Navigasi ke halaman dengan nama route
  void navigateTo(String routeName, {Object? arguments}) {
    Navigator.pushNamed(this, routeName, arguments: arguments);
  }

  /// Navigasi ke halaman tertentu, lalu menghapus semua halaman sebelumnya
  void navigateAndRemove(String routeName, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Navigasi ke halaman tertentu, lalu menghapus halaman sebelumnya saja
  void navigateAndReplace(String routeName, {Object? arguments}) {
    Navigator.pushReplacementNamed(this, routeName, arguments: arguments);
  }

  /// Kembali ke halaman sebelumnya
  void goBack() {
    Navigator.pop(this);
  }
}
