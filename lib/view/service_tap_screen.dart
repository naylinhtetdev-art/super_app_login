import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:super_app/model/service_model.dart';
import 'package:super_app/providers/service_provider.dart';

class ServiceTapScreen extends StatefulWidget {
  const ServiceTapScreen({Key? key}) : super(key: key);

  @override
  State<ServiceTapScreen> createState() => _ServiceTapScreen();
}

class _ServiceTapScreen extends State<ServiceTapScreen> {
  @override
  void initState() {
    super.initState();
    // App စဖွင့်ချိန် API Data ရယူရန်
    Future.microtask(() => context.read<ServiceProvider>().fetchHomeData());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServiceProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFD633E1)),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thingyan Special Banner
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thingyan Special 💦',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Get 20% off all utility bills this week.',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                          child: Text(
                            'Claim',
                            style: TextStyle(
                              color: Color(0xFFFFC107),
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Mini App Services
                  _buildSectionTitle('Mini App Services'),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.miniApps.length,
                      itemBuilder: (context, index) {
                        final item = provider.miniApps[index];
                        return _buildCategoryCard(item.title, item.iconPath);
                      },
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Pay Bills
                  _buildSectionTitle('Pay Bills'),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: provider.payBills
                        .map(
                          (bill) =>
                              _buildIconCircle(bill.title, Icons.flash_on),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 24.h),
                  // Local Services
                  _buildSectionTitle('Local Services'),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.localServices.length,
                      itemBuilder: (context, index) {
                        final item = provider.localServices[index];
                        return _buildServicesCategoryCard(
                          item.title,
                          Icons.restaurant,
                        );
                      },
                    ),
                  ),
                  // Shop by Category Product Grid
                  _buildSectionTitle('Shop by Category', hasSeeAll: true),
                  SizedBox(height: 12.h),
                  _buildCategoryFilterChips(context),
                  SizedBox(height: 12.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      final product = provider.products[index];
                      return _buildProductCard(context, product);
                    },
                  ),
                ],
              ),
            ),
    );
  }

  // Section Header Helper
  Widget _buildSectionTitle(String title, {bool hasSeeAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (!hasSeeAll) ...[
              Container(
                width: 4.w,
                height: 16.h,
                color: const Color(0xFFD633E1),
              ),
            ],
            SizedBox(width: 8.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (hasSeeAll)
          TextButton(
            onPressed: () {},
            child: TextStyle(color: Colors.grey, fontSize: 12.sp) == null
                ? SizedBox()
                : Text(
                    'Shop All',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
          ),
      ],
    );
  }

  // Square Category Card Helper
  Widget _buildCategoryCard(String title, String iconPath) {
    return Container(
      width: 90.h,
      margin: EdgeInsets.only(right: 12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white10,
            radius: 24.r,
            child: Image.asset(
              iconPath,
              color: const Color(0xFFD633E1),
              width: 20.w,
              height: 20.h,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  // Local Services Card Helper
  Widget _buildServicesCategoryCard(String title, IconData icon) {
    return Container(
      width: 100.h,
      margin: EdgeInsets.only(right: 12.r),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white10,
            child: Icon(icon, color: const Color(0xFFD633E1)),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  // Icon Circle Helper (Pay Bills)
  Widget _buildIconCircle(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF2A2A2A),
          child: Icon(icon, color: const Color(0xFFD633E1)),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: TextStyle(color: Colors.white70, fontSize: 11.sp),
        ),
      ],
    );
  }

  // Product Card Helper
  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(color: Colors.white, fontSize: 13.r),
                  maxLines: 2,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${product.price.toStringAsFixed(0)} MMK',
                  style: const TextStyle(
                    color: Color(0xFFD633E1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.read<ServiceProvider>().addToCart(product.id),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD633E1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 16.r,
                          color: Colors.white,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterChips(BuildContext context) {
    final provider = context.watch<ServiceProvider>();

    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.shopCategories.length,
        itemBuilder: (context, index) {
          final category = provider.shopCategories[index];
          final isSelected = provider.selectedCategoryIndex == index;

          return GestureDetector(
            onTap: () => context.read<ServiceProvider>().selectCategory(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: EdgeInsets.only(right: 10.w),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF0F5A56)
                    : const Color(0xFF4A4A4A),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'] as IconData,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    category['title'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
