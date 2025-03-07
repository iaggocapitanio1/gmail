import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Compose extends StatefulWidget {
  const Compose({super.key});

  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  final TextEditingController senderController = TextEditingController();
  final TextEditingController receiverController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController msgController = TextEditingController();
  final TextEditingController ccController = TextEditingController();
  final TextEditingController bccController = TextEditingController();

  final List<String> option = [
    "email1@gmail.com",
    "email2@gmail.com",
    "email3@gmail.com",
    "email4@gmail.com",
    "email5@gmail.com",
    "email6@gmail.com",
  ];

  late String selected;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    selected = option.first; // Set first option as default
  }

  @override
  void dispose() {
    senderController.dispose();
    receiverController.dispose();
    subjectController.dispose();
    msgController.dispose();
    ccController.dispose();
    bccController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Compose",
          style: GoogleFonts.poppins(color: colorScheme.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.attachment, color: colorScheme.onSurface),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: colorScheme.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              // FROM FIELD
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "From",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: selected,
                      isExpanded: true,
                      dropdownColor: colorScheme.surface,
                      underline: const SizedBox(),
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: colorScheme.onSurface,
                      ),
                      items:
                          option.map((e) {
                            return DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(color: colorScheme.onSurface),
                              ),
                            );
                          }).toList(),
                      onChanged:
                          (val) =>
                              setState(() => selected = val ?? option.first),
                    ),
                  ),
                ],
              ),

              const Divider(thickness: 0.5),

              // TO FIELD
              TextField(
                controller: receiverController,
                decoration: InputDecoration(
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 5.0),
                    child: Text("To", style: TextStyle(fontSize: 18)),
                  ),
                  suffixIcon:
                      !isVisible
                          ? IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: colorScheme.onSurface,
                            ),
                            onPressed: () => setState(() => isVisible = true),
                          )
                          : null,
                  border: InputBorder.none,
                ),
              ),

              const Divider(thickness: 0.5),

              // CC & BCC FIELDS
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    isVisible
                        ? Column(
                          children: [
                            TextField(
                              controller: ccController,
                              decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.0,
                                    right: 5.0,
                                  ),
                                  child: Text(
                                    "Cc",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            const Divider(thickness: 0.5),
                            TextField(
                              controller: bccController,
                              decoration: const InputDecoration(
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.0,
                                    right: 5.0,
                                  ),
                                  child: Text(
                                    "Bcc",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            const Divider(thickness: 0.5),
                          ],
                        )
                        : const SizedBox(),
              ),

              // SUBJECT FIELD
              TextField(
                controller: subjectController,
                decoration: const InputDecoration(
                  hintText: "Subject",
                  border: InputBorder.none,
                ),
              ),

              const Divider(thickness: 0.5),

              // MESSAGE FIELD
              Expanded(
                child: TextField(
                  controller: msgController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: "Compose email",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
