import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channlles_headlines_models.dart';
import 'package:news_app/screen/category_screen.dart';
import 'package:news_app/screen/detail_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  enum FilterList{ bbc, cnn, hindustantimes, independent, aljazeeara}

  class _HomePageState extends State<HomePage> {

  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;
  final format = DateFormat('MMMM dd, yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryScreen() ));
        }, icon: Icon(Icons.router_sharp)),
        centerTitle: true,
        title: Text('News', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        
        actions: [
          PopupMenuButton<FilterList>(
            
            initialValue: selectedMenu,
            icon: Icon(Icons.more_vert, color: Colors.black,),

            onSelected: (FilterList item){
              if(FilterList.bbc.name == item.name){
                name = 'bbc-news';
              }
              if(FilterList.cnn.name == item.name){
                name = 'cnn';
              }
              if(FilterList.hindustantimes.name == item.name){
                name = 'al-jazeera-english';
              }

              setState(() {
                
              });
            },

            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>> [
              PopupMenuItem<FilterList>(
                value: FilterList.bbc,
                child: Text('BBC'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.bbc,
                child: Text('CNN'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.bbc,
                child: Text('Al Jazeera'),
              )


            ]
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height*.55,
            width: width,
            child: FutureBuilder<NewsChannalsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(name), 
              builder: (BuildContext context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitPulsingGrid(
                      size: 50, 
                      color: Colors.blueAccent,
                    ),
                  );
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsScreen(
                              newsImage: snapshot.data!.articles![index].urlToImage.toString(), 
                              newsTitle: snapshot.data!.articles![index].title.toString(), 
                              newsDate: snapshot.data!.articles![index].publishedAt.toString(), 
                              auther: snapshot.data!.articles![index].author.toString(), 
                              description: snapshot.data!.articles![index].description.toString(), 
                              content: snapshot.data!.articles![index].content.toString(), 
                              source: snapshot.data!.articles![index].source!.name.toString(),
                            )));
                        },
                        child: SizedBox(
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.6,
                            width: width * .9,
                            padding: EdgeInsets.symmetric(horizontal: height*.02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(child: spinKit2,),
                                errorWidget:(context, url, error) => Icon(Icons.error_outline, color: Colors.red,),
                              ),
                            ),
                          ),
                          
                          Positioned(
                            bottom: 10,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.all(15),
                                height: height*.22,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * 0.7,
                                      child: Text(
                                        snapshot.data!.articles![index].title.toString(),  
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].source!.name.toString(),  
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            format.format(dateTime), 
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                                            ),
                                          ),
                      );
                  });
                }
              },
            ),
          ),

          // SizedBox(height: 30,),

          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi('General'),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitPulsingGrid(
                          size: 50,
                          color: Colors.blueAccent,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) => Container(
                                        child: spinKit2,
                                      ),
                                      errorWidget: (context, url, error) => Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
            
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index].source!.name.toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: Colors.black45,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(format.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  },
                ),
          ),
        ],
      ),
    );
  }
}


const spinKit2 = SpinKitDualRing(
  color: Colors.black,
  size: 50,
);