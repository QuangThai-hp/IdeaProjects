import 'package:flutter/cupertino.dart';

class DonViTinh with ChangeNotifier {
  int? tid;
  final String? name;
  final String? type;

  DonViTinh({
    this.tid = 0,
    this.name,
    this.type,
  });

}
