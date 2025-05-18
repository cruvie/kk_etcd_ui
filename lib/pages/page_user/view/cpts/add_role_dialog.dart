import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';
import 'package:kk_etcd_go/kk_etcd_api_hub/user/api_def/UserGrantRole.pb.dart';
import 'package:kk_etcd_go/kk_etcd_models/pb_role_kk_etcd.pb.dart';
import 'package:kk_etcd_ui/l10n/l10n.dart';
import 'package:kk_etcd_ui/pages/page_role/logic/state_role.dart';
import 'package:kk_etcd_ui/pages/page_user/logic/state_user.dart';

class AddRoleDialog extends ConsumerStatefulWidget {
  const AddRoleDialog({super.key, required this.userName, required this.roles});

  final String userName;
  final List<String> roles;

  @override
  ConsumerState<AddRoleDialog> createState() => _AddRoleDialogState();
}

class _AddRoleDialogState extends ConsumerState<AddRoleDialog> {
  @override
  void initState() {
    super.initState();
    ref.read(roleProvider.notifier).roleList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Wrap(
        alignment: WrapAlignment.start, // 设置左对齐
        children: ref.watch(roleProvider).pbListRole.list.map((PBRole value) {
          return Row(
            mainAxisSize: MainAxisSize.min, // 设置行宽度为尽可能小
            children: [
              Checkbox(
                value: widget.roles.contains(value.name),
                onChanged: (bool? isChecked) {
                  setState(() {
                    if (isChecked != null && isChecked) {
                      widget.roles.add(value.name); // 将选中的值添加到列表中
                    } else {
                      widget.roles.remove(value.name); // 如果取消选中，则从列表中移除
                    }
                  });
                },
              ),
              Text(value.name),
              const SizedBox(width: 20), // 添加间距
            ],
          );
        }).toList(),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              context.pop();
            },
            child: Text(lTr(context).buttonCancel)),
        ElevatedButton(
            onPressed: () {
              if (widget.userName.isEmpty) return;
              ref.read(userProvider.notifier).userGrantRole(
                    UserGrantRole_Input(
                      userName: widget.userName,
                      roles: widget.roles,
                    ),
                  );
              context.pop();
            },
            child: Text(lTr(context).buttonOK)),
      ],
    );
  }
}
