import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigatorExtensions on BuildContext {
  /// Navigasi ke halaman dengan path (dipush agar tombol back tersedia)
  void navigateTo(String routePath, {Object? arguments}) {
    // Catatan: arguments tidak digunakan untuk path-based routing.
    // Gunakan state.extra jika perlu meneruskan objek kompleks via GoRouter.
    push(routePath);
  }

  /// Navigasi ke halaman tertentu dan menghapus semua halaman sebelumnya
  void navigateAndRemove(String routePath, {Object? arguments}) {
    // go() mengganti stack historis, cocok untuk navigasi one-way (splash -> home)
    go(routePath);
  }

  /// Navigasi mengganti halaman saat ini saja
  void navigateAndReplace(String routePath, {Object? arguments}) {
    replace(routePath);
  }

  /// Kembali ke halaman sebelumnya
  void goBack() {
    pop();
  }
}
