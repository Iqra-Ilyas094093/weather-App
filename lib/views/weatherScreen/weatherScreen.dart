import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/view_model/theme_view_model/theme_provider.dart';

class weatherScreen extends ConsumerStatefulWidget {
  const weatherScreen({super.key});

  @override
  ConsumerState<weatherScreen> createState() => _weatherScreenState();
}

class _weatherScreenState extends ConsumerState<weatherScreen> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final notifier = ref.read(themeNotifierProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w), // Responsive padding
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40.h, // Responsive height
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search your city',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).colorScheme.surface,
                        size: 20.sp,
                      ),
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                        fontSize: 14.sp,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                child: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: isDark ? Colors.yellow.shade900 : Colors.white70,
                  size: 24.sp,
                ),
                onTap: notifier.toggleTheme,
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text(
          'Weather Screen Content Here',
          style: TextStyle(fontSize: 18.sp),
        ),
      ),
    );
  }
}
