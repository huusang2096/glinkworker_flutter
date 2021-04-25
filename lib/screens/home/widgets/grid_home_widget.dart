import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/model/services_reponse.dart';
import 'package:flutter_map_booking/routes.dart';

class GridHomeWidget extends StatelessWidget {
  const GridHomeWidget({
    Key key,
    @required this.size,
    @required this.defaultPadding,
    this.listServices,
  }) : super(key: key);

  final Size size;
  final double defaultPadding;
  final List<ServicesResponse> listServices;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      // height: size.height * 0.6,
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
      ),
      child: listServices.length == 0
          ? Center(child: CircularProgressIndicator())
          : buildGridView(),
    );
  }

  buildGridView() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listServices.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.65,
          mainAxisSpacing: 10.0),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoute.repairService, arguments: {
              'idService': listServices[index].id,
              'listServices': listServices,
              'navigationBooking': false
            });
          },
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: CachedNetworkImage(
                    imageUrl: listServices[index].image,
                    memCacheWidth: 500,
                    imageBuilder: (context, img) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            image:
                                DecorationImage(image: img, fit: BoxFit.cover)),
                      );
                    },
                    errorWidget: (context, string, dynamic) {
                      return Container(
                        child: Center(
                          child: Text('img not found'),
                        ),
                      );
                    },
                    placeholder: (context, string) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                Flexible(
                  child: Center(
                    child: Text(
                      listServices[index].name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: body1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
