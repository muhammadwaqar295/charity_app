import 'package:charity_app/consts/images.dart';
import 'package:flutter/material.dart';

import 'components/category_items.dart';
import 'components/spacial_event_compaigns.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu, size: 28),
                  Text(
                    "Charity",
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 18,
                        child: Icon(Icons.notifications_none, size: 20, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(imgProfile),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.brown, size: 20),
                    hintText: "Search charity campaigns",
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Donation Campaign Grid
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Donation Campaigns",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth - 8) / 2;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: itemWidth / (itemWidth * 0.99),
                    ),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: itemWidth * 0.65,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange, width: 1.5),
                              borderRadius: BorderRadius.circular(8),
                              image: const DecorationImage(
                                image: AssetImage(imgRequester),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text("Medical Support",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          ),
                          const Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                "Urgent need for medical treatment...",
                                style: TextStyle(fontSize: 10),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),


              // Eid Campaign Section
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Eid Campaigns",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),

// Horizontal scrollable Eid section
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 12), // spacing from left edge
                    spacialCompaings(imgEid, 'Eid Relief'),
                    const SizedBox(width: 12),
                    spacialCompaings(imgRamazan, 'Ramadan Support'),
                    const SizedBox(width: 12),
                    spacialCompaings(imgFood, 'Food Support'),
                    const SizedBox(width: 12),
                    spacialCompaings(imgCloth, 'Clothing Help'),
                    const SizedBox(width: 12), // spacing at end
                  ],
                ),
              ),


              // Categories Section

              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 92,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    categoryItem(imgFood, 'Food'),
                    categoryItem(imgCloth, 'Clothing'),
                    categoryItem(imgMedical, 'Medical'),
                    categoryItem(imgConstruction, 'Shelter'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }












}