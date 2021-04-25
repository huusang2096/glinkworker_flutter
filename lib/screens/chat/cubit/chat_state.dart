part of 'chat_cubit.dart';

class ChatState {
  Datum trip;
  List<Chat> chatList;

  ChatState({@required this.trip, this.chatList});

  ChatState copyWith({Datum trip, List<Chat> chatList}) {
    return ChatState(
        trip: trip ?? this.trip, chatList: chatList ?? this.chatList);
  }

  ChatState.from(ChatState state) {
    this.trip = state.trip;
    this.chatList = state.chatList;
  }
}

class ChatInitial extends ChatState {
  ChatInitial({@required Datum trip}) : super(trip: trip, chatList: []);
}

class ChatAddedState extends ChatState {
  ChatAddedState(ChatState state) : super.from(state);
}
