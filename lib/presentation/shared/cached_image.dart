import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_monisite/external/color_helpers.dart';
import 'package:skeleton_text/skeleton_text.dart';

enum TypeCachedImage { circle, rounded }

abstract class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  final PlaceholderWidgetBuilder? placeholder;
  final LoadingErrorWidgetBuilder? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.cover,
      placeholder: placeholder ??
          (context, url) => SkeletonAnimation(
                child: Container(width: width, height: height, color: ColorHelpers.colorGrey,),
              ),
      errorWidget: errorWidget ??
          (context, url, error) => Image.asset(
                "images/placeholder.png",
                width: width,
                height: height,
                fit: fit,
              ),
    );
  }
}

class CachedImageCircle extends CachedImage {
  const CachedImageCircle({
    super.key,
    required super.imageUrl,
    super.width,
    super.height,
    super.fit,
    super.placeholder,
    super.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(child: super.build(context));
  }
}

class CachedImageRounded extends CachedImage {
  const CachedImageRounded({
    super.key,
    required super.imageUrl,
    super.width,
    super.height,
    super.fit,
    super.placeholder,
    super.errorWidget,
    this.radius,
  });

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 8)),
      child: super.build(context),
    );
  }
}
