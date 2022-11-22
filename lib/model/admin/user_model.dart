class User {
  User({
    this.name,
    this.pwd,
  });

  User.fromJson(dynamic json) {
    name = json['name'];
    pwd = json['pwd'];
  }
  String? name;
  String? pwd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['pwd'] = pwd;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': name,
      'password': pwd,
    };
  }

  @override
  String toString() {
    return 'User{code: $name, data: $pwd}';
  }
}
