class UserModel {
  final int id;
  final int isverified;

  UserModel({
    required this.id,
    required this.isverified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        isverified: json["isverified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "isverified": isverified,
      };
}
