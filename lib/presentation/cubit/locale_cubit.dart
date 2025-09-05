import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// LocaleCubit
/// Mengelola pemilihan bahasa aplikasi secara sederhana menggunakan [Locale].
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('id'));

  void setLocale(Locale locale) => emit(locale);

  /// Daftar bahasa yang didukung aplikasi saat ini.
  static const supportedLocales = <Locale>[
    Locale('id'), // Indonesia
    Locale('en'), // English
    Locale('ko'), // Korean
  ];
}