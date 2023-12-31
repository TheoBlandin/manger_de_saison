class Food {
  final String _name; // id, unique
  final int _type; // 0: fruit, 1: vegetable
  final List<int> _months;
  final String _image;

  Food({required name, required type, required months, required image}) : _name = name, _type = type, _months = months, _image = image;

  String get nameGetter => _name;
  int get typeGetter => _type;
  List<int> get monthsGetter => _months;
  String get imageGetter => _image;
}