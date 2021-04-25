import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/model/offer_response.dart';

part 'offer_state.dart';

class OfferCubit extends BaseCubit<OfferState> {
  OfferCubit() : super(OfferInitial());

  getOffer() async {
    // emitLoading(true);
    try {
      emit(state.copyWith(isLoading: true));
      final listResponse = await dataRepository.getOffer();
      // emitLoading(false);
      emit(state.copyWith(isLoading: false));
      emit(GetOfferFetch(listResponse.promoList));
    } catch (e) {
      handleAppError(e);
    }
  }
}
