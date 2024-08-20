class EditModel{
  String? key;


  // EditModel.fromMap(dynamic obj) {
  //   this.key = obj['key'];
  //
  // }
  // EditModel.fromJson(Map<String, dynamic> json) {
  //   key = json['data'];
  // }

  Map<String, dynamic> toJson() => {
    "dataDecoder":key,
  };

}