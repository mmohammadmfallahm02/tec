import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_color.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/gen/assets.gen.dart';

class ArticleSingleScreen extends StatelessWidget {
  const ArticleSingleScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              children: [
                CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          // image: DecorationImage(
                          // image: imageProvider, fit: BoxFit.cover)),
                          // foregroundDecoration: BoxDecoration(
                          //     gradient: const LinearGradient(
                          //         colors: GradiantColors.blogPostGradint,
                          //         begin: Alignment.bottomCenter,
                          //         end: Alignment.topCenter),
                          //     borderRadius: BorderRadius.circular(16)),
                        ),
                    placeholder: (context, url) => const Loading(),
                    errorWidget: (context, url, error) =>
                        Assets.images.singlePlaceHolder.image()),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors:
                                  GradiantColors.articleSingleAppbarGradiant,
                              end: Alignment.bottomCenter,
                              begin: Alignment.topCenter)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SizedBox(
                            width: 16,
                          ),
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.bookmark_outline,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'رازهای اساسینز کرید والهالا؛ از هری پاتر و ارباب حلقه‌ها تا دارک سولز',
                maxLines: 2,
                style: themeData.textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Assets.images.profileAvatar.image(width: 50),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    'فاطمه امیری',
                    style: themeData.textTheme.headline4,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '2 روز پیش',
                    style: themeData.textTheme.caption,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: HtmlWidget(
                """چند ماه پیش جدیدترین قسمت از مجموعه بازی‌های اساسینز کرید عرضه شد. بازی اساسینز کرید والهالا ماجرای قاتلان تاریخی را در سرزمین وایکینگ‌ها روایت می‌کند و تفاوت عظیمی با بازی‌های اصلی این سری دارد. البته چیزی که در این بازی حاضر هست و در دیگر بازی‌های این سری هم همیشه موجود بوده، حجم بالایی از محتوای مخفی و رازهای عجیب و غریب است. قصد داریم تا نگاهی به آن‌ها داشته باشیم تا در صورتی که آن‌ها را ندیده‌اید، غافل نمانید.
        
        سری بازی‌های اساسینز کرید این روز‌ها شباهت بیش‌تری به بازی‌های نقش‌آفرینی دارند تا اساسینز کرید. گیم‌پلی این بازی‌ها تا حد زیادی تغییر کرده و المان‌های نقش‌آفرینی زیادی به آن‌ها اضافه شده. بازی اساسینز کرید والهالا همانند بازی‌های نقش‌آفرینی بسیار بزرگ شده و جارو کردن دنیای پهناور آن بیش‌تر از صد ساعت زمان می‌خواهد. در میان این نقشه‌ی بزرگ، نکات مخفی زیادی که در جوامع گیمرها به آن‌ها «ایستر اگ» (Easter Egg) گفته می‌شود وجود دارند.""",
                textStyle: themeData.textTheme.caption,
                enableCaching: true,
                onLoadingBuilder: (context, element, loadingProgress) =>
                    const Loading(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                height: 55,
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final listTagsSingleScreen = [
                        'بازی کامپیوتری',
                        'یوبیسافت',
                        'game'
                      ];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: SolidColors.surfaceColor,
                              borderRadius: BorderRadius.circular(18)),
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  listTagsSingleScreen[index],
                                  style: themeData.textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child:
                  Text('نوشته های مرتبط', style: themeData.textTheme.headline3),
            ),
            topVisitedList(themeData, size)
          ]),
        ),
      ),
    );
  }

  Widget topVisitedList(ThemeData themeData, Size size) {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            // blog item
            return Padding(
              padding: EdgeInsets.fromLTRB(4, 8, index == 0 ? 25 : 16, 8),
              child: Column(
                children: [
                  // blog post image
                  SizedBox(
                    height: size.height / 5.9,
                    width: size.width / 2.6,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                            imageUrl:
                                'https://api2.zoomit.ir/media/2020-10-samsung-release-update-for-galaxy-s20-fe-touchscreen-638bb228c669e381fe49646c?w=1920&q=75',
                            imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                  foregroundDecoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          colors:
                                              GradiantColors.blogPostGradint,
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                            placeholder: (context, url) => const Loading(),
                            errorWidget: (context, url, error) => const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                )),
                        Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('mohammad',
                                    style: themeData.textTheme.subtitle1),
                                Row(
                                  children: [
                                    Text('300',
                                        style: themeData.textTheme.subtitle1),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  // blog post text
                  Expanded(
                    child: SizedBox(
                        width: size.width / 2.6,
                        child: const Text(
                          'article.title!',
                          maxLines: 2,
                          softWrap: true,
                          // textAlign: TextAlign.justify,
                          overflow: TextOverflow.fade,
                        )),
                  )
                ],
              ),
            );
          }),
    );
  }
}
