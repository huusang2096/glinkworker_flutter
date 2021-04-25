import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_booking/common/style.dart';
import 'package:flutter_map_booking/screens/booking/cubit/booking_cubit.dart';
import 'package:flutter_map_booking/screens/services/widgets/app_bar_widget.dart';
import 'package:simplest/simplest.dart';

class SearchPlaceScreen extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 500);

  static provider(BookingCubit cubit) {
    return BlocProvider.value(
      child: SearchPlaceScreen(),
      value: cubit,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.bloc<BookingCubit>();
        return Scaffold(
          appBar: buildAppbar(context, cubit),
          body: SafeArea(
            child: Column(
              children: [
                buildSearchFiled(size, cubit),
                SizedBox(
                  height: 10.0,
                ),
                buildListResult(size, state, cubit)
              ],
            ),
          ),
        );
      },
    );
  }

  buildListResult(Size size, BookingState state, BookingCubit cubit) {
    switch (state.statusSearch) {
      case "NORMAL":
        return buildTipSearch('enter_search_keywords'.tr);
        break;
      case "OK":
        return Expanded(
          child: buildListViewSearch(size, state, cubit),
        );
        break;
      case "SEARCH":
        return Container(child: Center(child: CircularProgressIndicator()));
        break;
      case "INVALID_REQUEST":
        return buildTipSearch('no_search_results_found'.tr);
        break;
      case "ZERO_RESULTS":
        return buildTipSearch('no_search_results_found'.tr);
        break;
      case "OVER_QUERY_LIMIT":
        return buildTipSearch('server_error_please_try_again'.tr);
      case "REQUEST_DENIED":
        return buildTipSearch('an_error_occurred_while_searching'.tr);
      case "UNKNOWN_ERROR":
        return buildTipSearch('server_error_please_try_again'.tr);
      default:
        return Expanded(
          child: buildListViewSearch(size, state, cubit),
        );
        break;
    }
  }

  buildTipSearch(String text) {
    return Container(
      child: Center(child: Text(text)),
    );
  }

  buildListViewSearch(Size size, BookingState state, BookingCubit cubit) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            width: size.width,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListTile(
              onTap: () {
                cubit.changeMyLocationInSearchTap(state.listPlace[index]);
                Navigator.of(context).pop();
              },
              title: Text(
                state.listPlace[index].name,
                style: title.copyWith(fontSize: 18.0),
              ),
              subtitle: Text(
                state.listPlace[index].formattedAddress,
                style: body1.copyWith(fontSize: 15.0),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 5.0,
          );
        },
        itemCount: state.listPlace.length);
  }

  buildSearchFiled(Size size, BookingCubit cubit) {
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: Icon(Icons.search, size: 20, color: Colors.black),
              contentPadding: EdgeInsets.all(11),
              hintText: 'search'.tr,
              hintStyle: TextStyle(color: Colors.black)),
          onChanged: (query) {
            _debouncer.run(() {
              cubit.searchPlace(query);
            });
          },
          autofocus: false,
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }

  buildAppbar(BuildContext context, BookingCubit cubit) {
    return PreferredSize(
      child: AppbarWidget(
        text: 'set_your_address'.tr,
        callBack: () {
          cubit.refreshSearchPlace();
        },
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }
}
