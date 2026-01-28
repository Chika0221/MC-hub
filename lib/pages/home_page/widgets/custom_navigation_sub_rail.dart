part of 'custom_navigation_rail.dart';

class CustomNavigationSubRail extends HookConsumerWidget {
  const CustomNavigationSubRail({super.key, required this.selectedIndex});

  final ValueNotifier<int> selectedIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 32),
        IconButton(onPressed: () {}, icon: Icon(Icons.shape_line_rounded)),
        IconButton(onPressed: () {}, icon: Icon(Icons.add_box_rounded)),
        IconButton(onPressed: () {}, icon: Icon(Icons.send_rounded)),
        Spacer(),
        SizedBox(height: 32),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            "REMOCON",
            style: CustomTheme()
                .titleTheme(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            // style: Theme.of(context).textTheme.titleLarge?.copyWith(
            //   fontSize: MediaQuery.of(context).size.height * 0.08,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
        ).animate().slideX(
          duration: 100.ms,
          curve: Curves.bounceIn,
          begin: -1.0,
          end: 0.0,
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
