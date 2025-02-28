import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';
import 'package:tiktokapp/features/authentication/repos/authentication_repository.dart';
import 'package:tiktokapp/features/inbox/view_models/messages_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = 'chatDetail';
  static const String routeURL = ':chatId';

  final String chatId;
  const ChatDetailScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _editingController = TextEditingController();

  void _onSendPress() {
    final text = _editingController.text;
    if (text == "") {
      return;
    }
    ref.read(messagesProvider.notifier).sendMessage(text);
    _editingController.text = "";
    _editingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage("https://avatars.githubusercontent.com/u/3612017"),
                child: Text('User'),
              ),
              Positioned(
                left: 32,
                top: 32,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size3,
                    ),
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "Lynn ${widget.chatId}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                size: Sizes.size20,
                color: Colors.black,
              ),
              Gaps.h24,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                size: Sizes.size20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom: MediaQuery.of(context).padding.bottom + Sizes.size96,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine = message.userId == ref.watch(authRepo).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(Sizes.size14),
                            decoration: BoxDecoration(
                              color: isMine ? Colors.blue : Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(
                                  Sizes.size20,
                                ),
                                topRight: const Radius.circular(
                                  Sizes.size20,
                                ),
                                bottomLeft: Radius.circular(
                                  isMine ? Sizes.size20 : Sizes.size5,
                                ),
                                bottomRight: Radius.circular(
                                  !isMine ? Sizes.size20 : Sizes.size5,
                                ),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: Colors.blueGrey.shade50,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _editingController,
                      // expands부터 textInputAction까지 input text에 enter 기능을 추가하기 위함.
                      // expands가 true이면 minLines와 maxLines가 null로 설정이 되어야 함.
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        hintText: "Send a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size12,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: Sizes.size10,
                        ),
                        suffixIcon: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(FontAwesomeIcons.faceLaugh),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  IconButton(
                    onPressed: isLoading ? null : _onSendPress,
                    icon: FaIcon(
                      isLoading ? FontAwesomeIcons.hourglass : FontAwesomeIcons.paperPlane,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
