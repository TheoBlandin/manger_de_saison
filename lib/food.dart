class Food {
  final String _name;
  final int _type; // 0: vegetable, 1: fruit
  final List<String> _months;
  final String _image;

  Food({required name, required type, required months, required image}) : _name = name, _type = type, _months = months, _image = image;

  String get nameGetter => _name;
  int get typeGetter => _type;
  List<String> get monthsGetter => _months;
  String get imageGetter => _image;
}