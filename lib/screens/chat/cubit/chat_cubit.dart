import 'package:flutter_map_booking/common/base_cubit.dart';
import 'package:flutter_map_booking/model/chat.dart';
import 'package:flutter_map_booking/model/request_check_response.dart';
import 'package:meta/meta.dart';
import 'package:simplest/simplest.dart';
import 'package:firebase_database/firebase_database.dart';

part 'chat_state.dart';

class ChatCubit extends BaseCubit<ChatState> {
  ChatCubit({@required Datum trip}) : super(ChatInitial(trip: trip));

  DatabaseReference get _chatRef {
    // final fireApp = locator<FirebaseDatabaseConfig>().firebaseDatabase;
    // final database = FirebaseDatabase(app: fireApp);
    return FirebaseDatabase.instance.reference().child('${state.trip.id}');
  }

  loadChat() {
    subscriptions.add(_chatRef.onChildAdded.listen((event) {
      final data = event.snapshot.value;
      final mapData = Map<String, dynamic>.from(data);
      Chat chat = Chat.fromJson(mapData);
      logger.d(chat.toRawJson());
      final list = [...state.chatList]..insert(0, chat);
      emit(ChatAddedState(state.copyWith(chatList: list)));
    }));
  }

  send(String message) async {
    try {
      if (message.trim().isEmpty) {
        return;
      }
      final chat = Chat(
          sender: 'user',
          timestamp: DateTime.now().millisecondsSinceEpoch,
          type: 'text',
          text: message,
          read: 0,
          driverId: '${state.trip.providerId}',
          userId: '${state.trip.user.id}');
      _chatRef.push().update(chat.toJson());
      await dataRepository.postChatItem(
          sender: 'user', userId: '${state.trip.providerId}', message: message);
    } catch (e) {
      handleAppError(e);
    }
  }
}
