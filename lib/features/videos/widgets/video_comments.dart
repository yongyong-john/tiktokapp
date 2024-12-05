import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  final ScrollController _scrollController = ScrollController();
  bool _isWriting = false;

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _onStopCommenting() {
    // NOTE: virtual keyboard를 사라지게 하는 tap 설정.
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // NOTE: BorderRadius를 적용하기 위해 clipBehavior를 hardEdge로 적용.
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      height: size.height * 0.75,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade50,
          title: const Text("22796 comments"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.xmark),
              onPressed: _onClosePressed,
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _onStopCommenting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    top: Sizes.size8,
                    bottom: Sizes.size96,
                    left: Sizes.size16,
                    right: Sizes.size16,
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Text("User"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            const Text("Long text for user message in comments and can do reply later.")
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                          Gaps.v2,
                          Text(
                            '52.2K',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size8,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.grey.shade50,
                          child: const FaIcon(FontAwesomeIcons.solidUser),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: TextField(
                            onTap: _onStartWriting,
                            // expands부터 textInputAction까지 input text에 enter 기능을 추가하기 위함.
                            // expands가 true이면 minLines와 maxLines가 null로 설정이 되어야 함.
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              hintText: "Write a comment...",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size10,
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  right: Sizes.size16,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h10,
                                    FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: Colors.grey.shade900,
                                    ),
                                    Gaps.h10,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: Colors.grey.shade900,
                                    ),
                                    if (_isWriting)
                                      Row(
                                        children: [
                                          Gaps.h10,
                                          GestureDetector(
                                            onTap: _onStopCommenting,
                                            child: FaIcon(
                                              FontAwesomeIcons.circleArrowUp,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
