import 'package:admin_client/exception/base_chat_exception.dart';

class WebsocketException extends BaseChatException {
  WebsocketException(String errorMessage) : super(errorMessage);
}