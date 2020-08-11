class CustomSize {

  double _heightFactor, _widthFactor;
  static CustomSize _customSize;
  double _referencedHeight = 737.4545454545455,
      _referencedWidth = 392.72727272727275;

  static void initialize(height, width) {
    if (_customSize == null) _customSize = new CustomSize();

    _customSize._widthFactor = width / _customSize._referencedWidth;
    _customSize._heightFactor = height / _customSize._referencedHeight;
    print("act H: " + height.toString());
    print("act W: "+width.toString());

    print("fact H: "+_customSize._heightFactor.toString());
    print("fact W: "+_customSize.widthFactor.toString());
  }

  static CustomSize get customSize => _customSize;

  get widthFactor => _widthFactor;

  double get heightFactor => _heightFactor;
}