// import 'dart:math';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// extension NumberParsing on String {
//   int parseInt() {
//     try {
//       return int.parse(this);
//     } catch (e) {
//       // logger.e(e);
//     }
//     return -1;
//   }

//   double parseDouble() {
//     return double.tryParse(this) ?? -1;
//   }

//   bool parseBool() {
//     return this.toLowerCase() == 'true';
//   }
// }

// extension Precision on double {
//   double roundToPlace(int places) {
//     double mod = pow(10, places.toDouble());
//     return ((this * mod).round().toDouble() / mod);
//   }
// }

// extension ImageHelper on String {
//   Widget loadImage({double width, double height, double size, Color color}) {
//     if (size != null && size > 0) {
//       width = size;
//       height = size;
//     }
//     if (this.contains('http')) {
//       return CachedNetworkImage(
//         imageUrl: this,
//         width: width,
//         height: height,
//         color: color,
//         errorWidget: (context, url, error) => Icon(Icons.error),
//       );
//     }

//     if (this.contains('.svg')) {
//       var img = SvgPicture.asset(
//         this,
//         width: width ?? 24,
//         height: height ?? 24,
//         color: color,
//       );
//       return img;
//     }

//     if (this.contains('.png')) {
//       return Image.asset(
//         this,
//         width: width,
//         height: height,
//         color: color,
//       );
//     }

//     throw 'Assest $this failed to load';
//   }
// }

// extension TitleAlign on String {
//   TextAlign from() {
//     if (this == 'LEFT') {
//       return TextAlign.left;
//     }
//     if (this == 'RIGHT') {
//       return TextAlign.right;
//     }
//     return TextAlign.center;
//   }
// }

// extension ListExt on List {
//   List chunk(int chunkSize) {
//     List chunks = [];
//     int len = this.length;
//     for (var i = 0; i < len; i += chunkSize) {
//       int size = i + chunkSize;
//       chunks.add(this.sublist(i, size > len ? len : size));
//     }
//     return chunks;
//   }

//   get firstOrNull => this.length > 0 ? this.first : null;
//   get lastOrNull => this.length > 0 ? this.last : null;
// }

// extension HexColor on Color {
//   /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
//   static Color fromHex(String hexString) {
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   }

//   /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
//   String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
//       '${alpha.toRadixString(16).padLeft(2, '0')}'
//       '${red.toRadixString(16).padLeft(2, '0')}'
//       '${green.toRadixString(16).padLeft(2, '0')}'
//       '${blue.toRadixString(16).padLeft(2, '0')}';
// }
