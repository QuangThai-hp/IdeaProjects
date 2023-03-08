import 'package:flutter/cupertino.dart';

class KhuVuc with ChangeNotifier {
  int? tid;
  final String name;
  final String type;

  KhuVuc({
    this.tid,
    this.name = '',
    this.type = '',
  });
}
