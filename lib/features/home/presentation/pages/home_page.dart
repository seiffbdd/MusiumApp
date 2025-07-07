import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:musium/config/routes/app_router.dart';
import 'package:musium/config/theme/app_colors.dart';
import 'package:musium/core/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:musium/features/home/presentation/home_constants/tabs.dart';
import 'package:musium/features/home/presentation/widgets/custom_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCont;
  late final ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    super.initState();

    _tabCont = TabController(length: tabs.length, vsync: this);
    _selectedIndex = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _tabCont.dispose();
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabCont.addListener(() {
      if (_tabCont.indexIsChanging || _tabCont.index != _selectedIndex.value) {
        _selectedIndex.value = _tabCont.index;
      }
    });
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: TabBarView(controller: _tabCont, children: [
          Text('All'),
          Text('Folders'),
          Text('Playlists'),
          Text('Albums'),
          Text('Podcasts'),
        ]),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Welcome back !',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.textWhite),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.read<AuthCubit>().userEntity?.name ?? 'User',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColors.cyan),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: null,
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            context.pushNamed(AppRouter.settingsPageName);
          },
          icon: const Icon(Icons.settings),
        ),
      ],
      bottom: _buildTabBar(),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      labelPadding: EdgeInsets.only(right: 9, bottom: 16.0),
      controller: _tabCont,
      dividerHeight: 0,
      indicator: const BoxDecoration(),
      indicatorWeight: 0,
      isScrollable: true,
      tabs: List.generate(tabs.length, (index) {
        return CustomTab(
          text: tabs[index],
          index: index,
          selectedIndex: _selectedIndex,
        );
      }),
    );
  }
}
