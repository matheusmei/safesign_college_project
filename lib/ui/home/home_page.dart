import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safesign_app/ui/components/custom_appbar.dart';
import 'package:safesign_app/ui/components/theme/colors_app.dart';
import 'package:safesign_app/ui/documents%20list%20page/documents_list_page.dart';
import 'package:safesign_app/ui/home/components/custom_drawer.dart';
import 'package:safesign_app/ui/home/components/custom_tile.dart';
import 'package:safesign_app/ui/home/components/fabio.dart';
import 'package:safesign_app/ui/upload/upload_page.dart';
import '../../core/models/user_model.dart';
import '../../controller/home/home_controller.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  void initState() {
    _controller.getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Fabio(onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadPage(),
          ),
        );
      }),
      backgroundColor: ColorsApp.appDarkGrey,
      endDrawer: Observer(builder: (_) {
        return CustomDrawer(
          firstName: _controller.firstName,
          lastName: _controller.lastName,
        );
      }),
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Observer(
          builder: (_) {
            _controller.getDocumentstoSignLength();
            _controller.getAvailableDocumentsLength();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTile(
                  number: _controller.documentstoSignLength,
                  title: "Documents to sign",
                  action: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DocumentsListPage.toSign(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTile(
                  number: _controller.availableDocumentsLength,
                  title: "Available Documents",
                  action: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const DocumentsListPage.available(),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
