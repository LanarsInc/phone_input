import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Flag extends StatelessWidget {
  final BytesLoader loader;

  final double size;
  final BoxShape shape;

  Flag(
    String isoCode, {
    super.key,
    this.size = 48,
    this.shape = BoxShape.circle,
  }) : loader = _createLoader(isoCode);

  static BytesLoader _createLoader(String isoCode) {
    return _FlagAssetLoader(isoCode);
  }

  const Flag.fromLoader(this.loader, {super.key, this.size = 48, this.shape = BoxShape.circle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      decoration: BoxDecoration(shape: shape),
      clipBehavior: Clip.hardEdge,
      child: SvgPicture(
        loader,
        width: size,
        height: size,
        fit: shape == BoxShape.circle ? BoxFit.fill : BoxFit.contain,
      ),
    );
  }
}

/// create an SvgAssetLoader that points to circle flag svg file
/// it will resolve to the "?" flag if the normal asset is not found
class _FlagAssetLoader extends SvgAssetLoader {
  final String isoCode;

  _FlagAssetLoader(this.isoCode) : super(computeAssetName(isoCode));

  static String computeAssetName(String isoCode) {
    return 'packages/phone_input/assets/svg/${isoCode.toLowerCase()}.svg';
  }

  static AssetBundle _resolveBundle(AssetBundle? assetBundle, BuildContext? context) {
    if (assetBundle != null) {
      return assetBundle;
    }
    if (context != null) {
      return DefaultAssetBundle.of(context);
    }
    return rootBundle;
  }

  @override
  Future<ByteData?> prepareMessage(BuildContext? context) {
    final bundle = _resolveBundle(assetBundle, context);
    return bundle
        .load(computeAssetName(isoCode))
        // load "?" on error
        .catchError((e) => bundle.load(computeAssetName('xx')));
  }

  @override
  String provideSvg(ByteData? message) =>
      utf8.decode(message!.buffer.asUint8List(), allowMalformed: true);

  @override
  SvgCacheKey cacheKey(BuildContext? context) {
    return SvgCacheKey(keyData: isoCode, theme: theme, colorMapper: colorMapper);
  }
}