// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map_booking/common/config.dart';
// import 'package:flutter_map_booking/common/ui_helper.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../../routes.dart';

// class NetworkScreen extends StatefulWidget {
//   @override
//   _NetworkScreenState createState() => _NetworkScreenState();
// }

// class _NetworkScreenState extends State<NetworkScreen> with UIHelper {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _buildBody(),
//     );
//   }

//   _buildBody() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 30.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           FaIcon(
//             FontAwesomeIcons.wifi,
//             size: 100,
//           ),
//           FaIcon(
//             FontAwesomeIcons.times,
//             color: Colors.red,
//             size: 40,
//           ),
//           Center(
//               child: Text(
//             'no_internet'.tr,
//             textAlign: TextAlign.center,
//           )),
//           SizedBox(
//             height: 20,
//           ),
//           FlatButton(
//             onPressed: _handleTryAgain,
//             child: Text('try_again'.tr),
//           )
//         ],
//       ),
//     );
//   }

//   _handleTryAgain() async {
//     await showLoading(context: context);
//     final isHasInternet = await hasNetwork();
//     await hideLoading();
//     if (isHasInternet) {
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil(AppRoute.tabScreen, (route) => false);
//     }
//   }
// }
