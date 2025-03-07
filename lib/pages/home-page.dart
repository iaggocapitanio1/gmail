import 'package:flutter/material.dart';
import 'package:gmail/pages/mail-page.dart';
import 'package:gmail/theme/theme-provider.dart';
import 'package:gmail/widgets/fab/fab_collapsed.dart';
import 'package:gmail/widgets/fab/fab_extended.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../models/mail.dart';

class DataSearch extends SearchDelegate<String> {
  final List<String> arr = [
    "Yogesh Kumar",
    "Flutter Developer",
    "Software Engineer",
    "@Odessa",
    "Gmail-UI",
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return theme.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: TextStyle(
          color: colorScheme.onPrimary,
        ), // Updated from `title`
        bodyMedium: TextStyle(
          color: colorScheme.onSurfaceVariant,
        ), // Updated from `body1`
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        query.isEmpty
            ? arr
            : arr
                .where(
                  (element) =>
                      element.toLowerCase().startsWith(query.toLowerCase()),
                )
                .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder:
          (context, index) => ListTile(
            leading: Icon(
              Icons.restore,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            title: Text(
              suggestionList[index],
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        "You searched for: $query",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _animationController;
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isFAB = false;
  int currentSelected = 1;
  late List<Mail> mails;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    // Initialize dummy data
    final dummyData data = dummyData();
    mails = List.generate(
      10,
      (i) => Mail(
        content: data.content[i],
        date: "26 Jan 2020",
        subject: data.subject[i],
        senderName: data.names[i],
        senderMail: data.emails[i],
        time: "12:23 am",
        profile: data.link[i],
        receiverMails: ["mymail@gmail.com"],
        read: data.read[i],
      ),
    );

    _scrollController.addListener(() {
      setState(() {
        isFAB = _scrollController.offset > 50;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surface,
      floatingActionButton:
          isFAB ? buildCollapsedFAB(context) : buildExtendedFAB(context),
      drawer: Drawer(
        child: Container(
          color: colorScheme.surface,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(color: colorScheme.outline, width: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gmail',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 22,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'ProductSans',
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        themeProvider.themeMode == ThemeMode.dark
                            ? Icons.mode_night
                            : Icons.light_mode_sharp,
                        color: colorScheme.primary,
                      ),
                      onPressed: () => themeProvider.toggleTheme(),
                    ),
                  ],
                ),
              ),
              _buildDrawerButton(context, Icons.all_inbox, 'All inboxes', 1),
              _buildDrawerButton(context, Icons.inbox, 'Primary', 2),
              _buildDrawerButton(
                context,
                Icons.people_alt_outlined,
                'Social',
                3,
              ),
              _buildDrawerButton(
                context,
                Icons.local_offer_outlined,
                'Promotions',
                4,
              ),
              _buildDrawerButton(context, Icons.star_outline, 'Starred', 5),
              _buildDrawerButton(context, Icons.access_time, 'Snoozed', 6),
              _buildDrawerButton(context, Icons.send, 'Sent', 8),
              _buildDrawerButton(
                context,
                Icons.schedule_send_outlined,
                'Scheduled',
                9,
              ),
              _buildDrawerButton(context, Icons.outbox, 'Outbox', 10),
              _buildDrawerButton(
                context,
                Icons.insert_drive_file_outlined,
                'Drafts',
                11,
              ),
              _buildDrawerButton(context, Icons.mail_outline, 'All mail', 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red.shade500,
        unselectedItemColor: colorScheme.onSurfaceVariant,
        backgroundColor: colorScheme.surface,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mail, size: 25),
            label: "Mail",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.videocam_outlined, size: 25),
            label: "Meet",
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(context),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: Text(
                "PRIMARY",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 13,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: mails.length,
                controller: _scrollController,
                itemBuilder: (context, i) => _buildMailItem(context, i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerButton(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        tileColor:
            currentSelected == index
                ? Colors.red.shade50
                : theme.colorScheme.surface,
        leading: Icon(
          icon,
          color:
              currentSelected == index
                  ? Colors.red
                  : theme.colorScheme.onSurfaceVariant,
        ),
        title: Text(
          label,
          style: TextStyle(
            color:
                currentSelected == index
                    ? Colors.red
                    : theme.colorScheme.onSurfaceVariant,
            fontFamily: 'ProductSans',
          ),
        ),
        onTap: () => setState(() => currentSelected = index),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: DataSearch()),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 1),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.menu, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "Search in emails",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const CircleAvatar(
              radius: 14,
              child: Text("S", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMailItem(BuildContext context, int i) {
    final mailItem = mails[i];
    return ListTile(
      onTap:
          () => Navigator.pushNamed(
            context,
            MailPage.routeName,
            arguments: mailItem,
          ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(mailItem.profile ?? ""),
        backgroundColor: Colors.white,
        radius: 20,
      ),
      title: Text(
        mailItem.getUsername() ?? "",
        style: TextStyle(
          fontWeight: mailItem.read ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(
        mailItem.getSubject() ?? "",
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.star_border, color: Colors.grey),
    );
  }
}
