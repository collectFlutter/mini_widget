import 'package:flutter/material.dart';
import '../widget/scrawl_location_widget.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';

class ScrawlLocationPage extends StatefulWidget {
  final String filePath;
  final String appName;
  final List<Color> colors;
  final Color backColor;
  final bool showTop;
  final bool enableTransform;
  final Widget? appLogo;
  final String? authorName;

  const ScrawlLocationPage(
    this.filePath, {
    super.key,
    required this.appName,
    this.colors = const [Colors.redAccent, Colors.lightBlueAccent],
    this.backColor = Colors.black12,
    this.showTop = true,
    this.enableTransform = true,
    this.appLogo,
    this.authorName,
  });

  @override
  State<ScrawlLocationPage> createState() => _ScrawlLocationPageState();
}

class _ScrawlLocationPageState extends State<ScrawlLocationPage> {
  final GlobalKey<ScrawlWithLocationState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScrawlWithLocationWidget(
      widget.filePath,
      saveImage: (file) {},
      key: _key,
    );
  }
}
