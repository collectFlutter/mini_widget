import 'package:flutter/material.dart';

class ImageLabelModel<T> {
  ValueKey<T> key;
  Widget _image;
  String _label;
  ImageLabelModel(this._image, this._label, {this.key});

  getImage() {
    return _image;
  }

  getLabel() {
    return _label;
  }
}
