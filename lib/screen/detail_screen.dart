import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {

  final String newsImage, newsTitle, newsDate, auther, description, content, source;
  const NewsDetailsScreen({
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.auther,
    required this.description,
    required this.content,
    required this.source,
    super.key});
  
  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    DateTime dateTime = DateTime.parse(widget.newsDate);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height*.45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                ),
                child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                ),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle,
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: height *.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source,
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
                    ),
                    Text(format.format(dateTime),
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500),
                    ),                  
                  ],
                ),
                SizedBox(height: height*.03,),
                    Text(widget.description,
                    style: GoogleFonts.poppins(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}