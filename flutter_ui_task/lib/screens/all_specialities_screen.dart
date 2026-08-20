import 'package:flutter/material.dart';
import '../controllers/all_specialities_controller.dart';
import '../models/speciality.dart';
import '../widgets/home/speciality_item.dart';

class AllSpecialitiesScreen extends StatefulWidget {
  const AllSpecialitiesScreen({super.key});

  @override
  State<AllSpecialitiesScreen> createState() => _AllSpecialitiesScreenState();
}

class _AllSpecialitiesScreenState extends State<AllSpecialitiesScreen> {
  late final AllSpecialitiesController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AllSpecialitiesController();
    _controller.loadSpecialities();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: const BackButton(),
        centerTitle: false,
        title: const Text(
          'All Specialities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: _controller.isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ValueListenableBuilder<List<Speciality>>(
              valueListenable: _controller.specialities,
              builder: (context, specialities, _) {
                if (specialities.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        'No specialities available right now.',
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return LayoutBuilder(
                  builder: (context, constraints) {
                    // Responsive column count instead of a fixed number,
                    // so this doesn't overflow or look sparse whether
                    // it's a phone, a tablet, or a wide desktop window.
                    final crossAxisCount =
                        (constraints.maxWidth / 100).floor().clamp(3, 6);
                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: specialities.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 24,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        return SpecialityItem(
                          speciality: specialities[index],
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
