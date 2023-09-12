import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../util/url_util.dart';

class ImageCell extends StatelessWidget {
  final String? path;
  final BorderRadius? borderRadius;
  final double width;
  final double height;
  final double radius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ImageCell(
      {Key? key,
      this.path,
      this.borderRadius,
      this.width = double.infinity,
      this.height = 150,
      this.radius = 5,
      this.placeholder,
      this.errorWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius)),
      child: (path == null || path!.isEmpty)
          ? (errorWidget ?? Container())
          : UrlUtil.isUrl(path!)
              ? CachedNetworkImage(
                  height: height,
                  width: width,
                  imageUrl: path!,
                  fit: BoxFit.cover,
                  placeholder:
                      placeholder != null ? (ctx, url) => placeholder! : null,
                  errorWidget: errorWidget != null
                      ? (ctx, url, error) => errorWidget!
                      : null)
              : Image.asset(
                  path!,
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
    );
  }
}
