import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmail/models/mail.dart';
import 'package:gmail/widgets/icon_button.dart';

class MailPage extends StatefulWidget {
  static const routeName = '/extractArguments';

  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  bool isVis = false;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleIcon() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final msg = ModalRoute.of(context)!.settings.arguments as Mail;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    List<String> text = ["Reply", "Reply All", "Forward"];
    List<IconData> icons = [
      CupertinoIcons.arrow_turn_up_left,
      CupertinoIcons.arrow_turn_up_left,
      CupertinoIcons.arrow_turn_up_right,
    ];

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.archive_outlined, color: colorScheme.onSurface),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(CupertinoIcons.delete, color: colorScheme.onSurface),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.mail_outline_outlined,
              color: colorScheme.onSurface,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Email Subject**
              Text(
                msg.subject ?? "",
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),

              /// **Sender Information**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.green,
                    child: Text(
                      (msg.senderName ?? "")[0].toUpperCase(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.senderName ?? "",
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          msg.getDate()?.substring(0, 6) ?? "",
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.arrow_turn_up_left),
                    onPressed: () {},
                    color: colorScheme.onSurface,
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                    color: colorScheme.onSurface,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// **Expand Details Button**
              GestureDetector(
                onTap: () => setState(() => isVis = !isVis),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      msg.receiverMails?.length == 1 ? "to me" : "",
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    AnimatedIconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        maxHeight: 15,
                        maxWidth: 15,
                      ),
                      size: 15,
                      onPressed: toggleIcon,
                      animationController: _animationController,
                      icons: [
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: colorScheme.onSurfaceVariant,
                            size: 15,
                          ),
                        ),
                        AnimatedIconItem(
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: colorScheme.onSurfaceVariant,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// **Expanded Email Details**
              Visibility(
                visible: isVis,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.onSurface.withOpacity(0.3),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow(
                        "From:",
                        msg.senderName ?? "",
                        colorScheme,
                        textTheme,
                      ),
                      _buildInfoRow(
                        "To:",
                        (msg.receiverMails ?? []).join(", "),
                        colorScheme,
                        textTheme,
                      ),
                      _buildInfoRow(
                        "Date:",
                        "${msg.date}, ${msg.time}",
                        colorScheme,
                        textTheme,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_outline,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Standard encryption (TLS). See security details.',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// **Email Content**
              const SizedBox(height: 20),
              Text(
                msg.content ?? "",
                textAlign: TextAlign.justify,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 30),

              /// **Reply Actions**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (i) => Expanded(child: CustomIconButton(text[i], icons[i])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Helper Method: Build Email Detail Row**
  Widget _buildInfoRow(
    String label,
    String value,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurface,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
