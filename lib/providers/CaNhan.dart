import 'package:flutter/cupertino.dart';

class CaNhan with ChangeNotifier {
  String? tid;
  final String name;


  CaNhan({
    this.tid = '',
    required this.name,
  
  });
}
