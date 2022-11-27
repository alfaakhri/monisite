import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String ddMMMMyyyy() {
    final formatter = DateFormat('dd MMMM yyyy', 'id_ID');
    return formatter.format(this);
  }

  String ddMMyy() {
    final formatter = DateFormat('dd/MM/yy');
    return formatter.format(this);
  }

  String eeee() {
    final formatter = DateFormat('EEEE', 'id_ID');
    return formatter.format(this);
  }

  String ddMMMyyyy() {
    final formatter = DateFormat('dd MMM yyyy', 'id_ID');
    return formatter.format(this);
  }

  String dayTime() {
    final formatter = DateFormat('EEEE, HH:mm a', 'id_ID');
    return formatter.format(this);
  }

  String dayDate() {
    final formatter = DateFormat('EEEE, dd MMM yyyy', 'id_ID');
    return formatter.format(this);
  }

  String dayddMMMMyyyy() {
    final formatter = DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
    return formatter.format(this);
  }

  String ddMMMhhmma() {
    final formatter = DateFormat('dd MMM hh:mm a', 'id_ID');
    return formatter.format(this);
  }

  String ddMMMyyyyHHmmss() {
    final formatter = DateFormat('dd MMMM yyyy HH:mm:ss', 'id_ID');
    return formatter.format(this);
  }

  String ddMMMHHmm() {
    final formatter = DateFormat('dd MMM HH:mm', 'id_ID');
    return formatter.format(this);
  }

  String yyyyMMddHHmmss() {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(this);
  }

  String hhmma() {
    final formatter = DateFormat('HH:mm a', 'id_ID');
    return formatter.format(this);
  }

  String hhmm() {
    final formatter = DateFormat('HH:mm', 'id_ID');
    return formatter.format(this);
  }

  String ddMMHHmm() {
    final formatter = DateFormat('dd MMM HH:mm', 'id_ID');
    return formatter.format(this);
  }
}
