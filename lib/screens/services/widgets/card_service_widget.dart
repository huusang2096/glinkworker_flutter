import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/config.dart';
import 'package:flutter_map_booking/common/style.dart';

class CardServiceWidget extends StatelessWidget {
  final String urlImage;
  final String titleText;
  final String subTitleText;
  final moneyText;
  final Function onPress;
  final double maxHeight;
  final bool showTextForm;
  final bool disable;
  const CardServiceWidget({
    Key key,
    this.urlImage,
    this.titleText,
    this.subTitleText,
    this.moneyText,
    this.onPress,
    this.maxHeight = 150.0,
    this.showTextForm,
    this.disable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (disable == false) {
          onPress();
        }
      },
      child: Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 4,
              child: CachedNetworkImage(
                memCacheWidth: 600,
                imageUrl: urlImage,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, string, dynamic) {
                  return Container(
                    child: Center(
                      child: Text('img not found'),
                    ),
                  );
                },
                placeholder: (context, string) {
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                placeholderFadeInDuration: Duration(milliseconds: 500),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleText,
                      overflow: TextOverflow.ellipsis,
                      style: heading1.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      subTitleText,
                      style: textGrey.copyWith(fontSize: 13.0),
                    ),
                    Spacer(),
                    if (showTextForm)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'from  ',
                                style: textGrey.copyWith(fontSize: 13.0)),
                            TextSpan(
                                text: '$moneyText' + kCurrency,
                                style: heading1.copyWith(
                                    color: primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
