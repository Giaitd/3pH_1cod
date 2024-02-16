class DuLieuQuanTracModel {
  String thietBiId;
  String pH1;
  String temp1;
  String cod;
  String bod;
  String tss;
  String pH2;
  String temp2;
  String pH3;
  String temp3;

  DuLieuQuanTracModel({
    this.thietBiId = "",
    this.pH1 = "",
    this.temp1 = "",
    this.cod = "",
    this.bod = "",
    this.tss = "",
    this.pH2 = "",
    this.temp2 = "",
    this.pH3 = "",
    this.temp3 = "",
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'thietBiId': thietBiId.trim(),
      'pH1': pH1.trim(),
      'temp1': temp1.trim(),
      'pH2': pH2.trim(),
      'temp2': temp2.trim(),
      'pH3': pH3.trim(),
      'temp3': temp3.trim(),
      'cod': cod.trim(),
      'bod': bod.trim(),
      'tss': tss.trim(),
    };

    return map;
  }
}
