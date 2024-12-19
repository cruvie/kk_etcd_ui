import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kk_etcd_ui/pages/page_ai/logic/state_ai.dart';
import 'package:kk_ui/kk_widget/kk_card.dart';
import 'package:kk_ui/kk_widget/kk_indicator.dart';

class PageAI extends ConsumerStatefulWidget {
  const PageAI({super.key});

  @override
  ConsumerState<PageAI> createState() => _PageAIState();
}

class _PageAIState extends ConsumerState<PageAI> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var readAI = ref.read(aIProvider.notifier);
    var watchAI = ref.watch(aIProvider);
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: KKCard(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: textEditingController,
                    minLines: 1,
                    maxLines: 5,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: watchAI.loading
                    ? null
                    : () {
                        readAI.query(textEditingController.text);
                      },
                child: watchAI.loading
                    ? KKIndicator()
                    : Icon(Icons.manage_search_outlined),
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          Expanded(
            child:
            // ListView(
            //   children: [
                KKCard(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  // padding: EdgeInsets.all(10),
                  // child: SelectableText(watchAI.answer),
                  child: Markdown(
                    selectable: true,
                    data: watchAI.answer,
                  ),
                )
              // ],
            // ),
          )
        ],
      ),
    );
  }
}
