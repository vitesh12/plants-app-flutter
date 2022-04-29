import 'package:flutter/material.dart';
import 'package:plant_app_flutter/core/color.dart';
import 'package:plant_app_flutter/data/category_model.dart';
import 'package:plant_app_flutter/data/plant_data.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController();
  @override
  void initState(){
    controller = PageController(viewportFraction: 0.6,initialPage: 0);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        automaticallyImplyLeading: false,
        leadingWidth: 40,
        leading: TextButton(
          onPressed: (){},
          child: Image.asset('assets/icons/menu.png'
          ),
        ),
        actions: [
          Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.only(right: 20,top: 10,bottom: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlue.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0,0),
                ),
              ],
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/logo.jpeg'),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20.0),
              child: Row(
                children: [
                  Container(
                    height: 45.0,
                    width: 300.0,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: blue),
                      boxShadow: [
                        BoxShadow(
                          color: blue.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0,0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                      
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 45,
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                          ),
                        ),
                        Image.asset('assets/icons/search.png', height: 25,),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    height: 45,
                    width: 45,
                    padding: const EdgeInsets.symmetric( horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: blue,
                      boxShadow: [
                        BoxShadow(
                          color: blue.withOpacity(10.0),
                          blurRadius: 10,
                          offset: const Offset(0,0),
                        ),
                      ],
                      borderRadius:  BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/icons/adjust.png', 
                      height: 25,
                      color: white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for(int i=0;i<categories.length;i++)
                    GestureDetector(
                      onTap: (){
                        setState(()=> selectId = categories[i].id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            categories[i].name,
                            style: TextStyle(
                              color: selectId ==i ? Colors.pinkAccent.shade100 : black.withOpacity(0.7),
                              fontSize: 16.0,
                            ),
                          ),
                          if(selectId ==i)
                            const CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.cyan,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 340,
              width: 500,
              child: PageView.builder(
                itemCount: plants.length,
                controller: controller,
                physics: const BouncingScrollPhysics(),
                padEnds: false,
                pageSnapping: true,
                onPageChanged: (value) => setState(()=> activePage =value),
                itemBuilder: (itemBuilder,index){
                  bool active =index==activePage;
                  return slider(active,index);                
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
                    style: TextStyle(
                      color: black.withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Image.asset(
                    'assets/icons/search.png', 
                    height: 25,
                    color: Colors.amber.shade500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView.builder(
                itemCount: popularPlants.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (itemBuilder,index){
                  return Container(
                    width: 220.0,
                    margin:  const EdgeInsets.only(right: 20, bottom: 10),
                    decoration:  BoxDecoration(
                      color: Colors.cyan.shade50,
                      boxShadow: [
                        BoxShadow(
                          color: blue.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                          popularPlants[index].imagePath,
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              popularPlants[index].name,
                              style: TextStyle(
                                color: black.withOpacity(0.7),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              '\$${popularPlants[index].price.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: black.withOpacity(0.4),
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 20,
                      bottom: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.pink.shade300,
                        radius: 15,
                        child: Image.asset(
                          'assets/icons/add.png',
                          color: white,
                          height: 15,
                        ),
                      ),
                    ),
                  ],
                  ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
  AnimatedContainer slider(active,index){
    double margin = active ? 20:30;
    return AnimatedContainer(
      duration: const Duration(microseconds: 500),
      curve: Curves.easeInOutCubic,
      margin: EdgeInsets.all(margin),
      child: mainPlantsCard(index),
    );
  }

  Widget mainPlantsCard(index){
    return GestureDetector(
      onTap:(){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:( builder)=> DetailsPage(plant : plants[index]),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.05),
              blurRadius: 15,
              offset:  const Offset(5, 5),
            ),
          ],
          border: Border.all(color: blue,width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.cyan.shade50,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    blurRadius: 15,
                    offset:  const Offset(5, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage(plants[index].imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                      right: 8,
                      top: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.pink.shade400,
                        radius: 15,
                        child: Image.asset(
                          'assets/icons/add.png',
                          color: white,
                          height: 15,
                        ),
                      ),
                    ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  const EdgeInsets.only(bottom: 5),
                child: Text(
                  '${plants[index].name} - \$${plants[index].price.toStringAsFixed(0)}',
                  style: TextStyle(
                    color: black.withOpacity(0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  int selectId=0;
  int activePage=0;
}