import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';

class StringService {
  static String getChatTime(String str) {
    if (str.isNotEmpty) {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime dateTime = dateFormat.parse(str, true);
      DateTime localTime = dateTime.toLocal();

      return DateFormat("h:mm a").format(localTime);
    } else
      return '';
  }
}