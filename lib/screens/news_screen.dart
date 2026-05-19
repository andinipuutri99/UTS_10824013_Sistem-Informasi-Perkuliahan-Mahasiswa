// lib/screens/news_screen.dart

import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../constants/mock_data.dart';
import '../models/user_model.dart';
import '../widgets/app_card.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _activeCategory = 0;
  final List<String> _categories = ['All', 'Announcement', 'Achievement', 'Event'];

  @override
  Widget build(BuildContext context) {
    final filteredNews = _activeCategory == 0
        ? mockNews
        : mockNews
            .where((n) => n.category == _categories[_activeCategory])
            .toList();

    return Scaffold(
      backgroundColor: AppColors.secondaryCream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Campus News Feed',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stay updated with the latest events and announcements.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                    const SizedBox(height: 16),
                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
                      ),
                      child: const TextField(
                        style: TextStyle(fontSize: 14, color: AppColors.darkBlue),
                        decoration: InputDecoration(
                          hintText: 'Search news, events...',
                          hintStyle: TextStyle(
                            color: Color(0xFFCBD5E1),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(Icons.search_rounded,
                              color: Color(0xFF94A3B8), size: 20),
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Category Tabs
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (_, i) {
                          final isActive = _activeCategory == i;
                          return GestureDetector(
                            onTap: () => setState(() => _activeCategory = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.primaryContainer
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: isActive
                                    ? null
                                    : Border.all(
                                        color: const Color(0xFFE2E8F0)),
                                boxShadow: isActive
                                    ? [
                                        BoxShadow(
                                          color: AppColors.primaryContainer
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                          offset: const Offset(0, 3),
                                        )
                                      ]
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _categories[i],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF94A3B8),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _NewsArticleCard(news: filteredNews[i]),
                  ),
                  childCount: filteredNews.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsArticleCard extends StatelessWidget {
  final NewsItem news;
  const _NewsArticleCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                child: Image.network(
                  news.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: const Color(0xFFE2E8F0),
                    child: const Icon(Icons.image_outlined,
                        color: Color(0xFF94A3B8), size: 40),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.white.withOpacity(0.9),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    child: Text(
                      news.category.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        news.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkBlue,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.bookmark_border_rounded,
                        size: 22, color: Color(0xFFCBD5E1)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  news.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      news.publishedAt,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF94A3B8)),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.share_outlined,
                            size: 17, color: Color(0xFF94A3B8)),
                        const SizedBox(width: 16),
                        const Text(
                          'Read More',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            size: 16, color: AppColors.primary),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
