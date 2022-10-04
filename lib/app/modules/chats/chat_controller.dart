import 'package:get/get.dart';
import 'package:poraki/app/data/repositories/chat_repository.dart';
import '../../data/models/chats.dart';

class ChatController extends GetxController {
  ChatRepository chatRepo = ChatRepository();
  List<Chats> listChats = [];
  bool isLoading = false;

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<List<Chats>> getAllByCustomerId() async {
    try {
      changeLoading(true);
      listChats = await chatRepo.getAllByCustomerId();
    } catch (e) {
      print('Erro no getAllByCustomerId() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }

    return listChats;
  }

  Future<List<Chats>> getAllBySellerId() async {
    try {
      changeLoading(true);
      listChats = await chatRepo.getAllBySellerId();
    } catch (e) {
      print('Erro no getAllBySellerId() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }

    return listChats;
  }

  Future<void> add(Chats chat) async {
    try {
      changeLoading(true);
      await chatRepo.add(chat);
    } catch (e) {
      print('Erro no add() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<void> close(String chatId) async {
    try {
      changeLoading(true);
      await chatRepo.close(chatId);
    } catch (e) {
      print('Erro no add() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }


}