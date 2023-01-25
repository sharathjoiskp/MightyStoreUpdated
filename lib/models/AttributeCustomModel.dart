import 'package:mightyAdmin/models/AttributeTermsResponse.dart';

class AttributeSection {
  int? id;
  String? name;
  List<AttributeTermsResponse>? option;
  bool? visible;
  bool? variation;
  bool isSelected;

  AttributeSection({this.id = 0, this.name = "", this.option, this.visible = false, this.variation = false, this.isSelected = false});
}
