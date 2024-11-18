// lib/views/pages/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import './widgets/balance_card.dart';
import './widgets/payment_card.dart';
import './widgets/action_buttons.dart';
import './widgets/transaction_history.dart';


class HomePage extends StatefulWidget {
 const HomePage({Key? key}) : super(key: key);

 @override
 State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 int _currentCardIndex = 0;
 final CarouselController _carouselController = CarouselController();

 final List<Widget> _cards = [
   const BalanceCard(),
   const PaymentCard(
     cardHolderName: 'Full Name',
     cardNumber: '4111111111111111',
     expiryDate: '00/00',
   ),
 ];

 @override
 Widget build(BuildContext context) {
   return SafeArea(
     child: Column(
       children: [
         _buildHeader(),
         Expanded(
           child: SingleChildScrollView(
             child: Column(
               children: [
                 // Carousel de cartes
                 CarouselSlider(
                   carouselController: _carouselController,
                   options: CarouselOptions(
                     height: 220,
                     enableInfiniteScroll: false,
                     viewportFraction: 0.92,
                     onPageChanged: (index, reason) {
                       setState(() {
                         _currentCardIndex = index;
                       });
                     },
                   ),
                   items: _cards,
                 ),
                 // Indicateurs de page
                 const SizedBox(height: 16),
                 AnimatedSmoothIndicator(
                   activeIndex: _currentCardIndex,
                   count: _cards.length,
                   effect: const WormEffect(
                     dotHeight: 8,
                     dotWidth: 8,
                     spacing: 8,
                     dotColor: Colors.grey,
                     activeDotColor: Colors.deepPurple,
                   ),
                   onDotClicked: (index) {
                     _carouselController.animateToPage(index);
                   },
                 ),
                 const ActionButtons(),
                 const TransactionHistory(),
               ],
             ),
           ),
         ),
       ],
     ),
   );
 }

 Widget _buildHeader() {
   return Container(
     padding: const EdgeInsets.all(16.0),
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Row(
           children: [
             Container(
               width: 40,
               height: 40,
               decoration: BoxDecoration(
                 color: Colors.deepPurple.shade100,
                 borderRadius: BorderRadius.circular(12),
               ),
               child: const Icon(
                 Icons.account_balance_wallet,
                 color: Colors.deepPurple,
               ),
             ),
             const SizedBox(width: 12),
             const Text(
               'PayWise',
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ],
         ),
         Stack(
           children: [
             IconButton(
               icon: const Icon(Icons.notifications_outlined),
               onPressed: () {
                 // TODO: Gérer les notifications
               },
             ),
             Positioned(
               right: 8,
               top: 8,
               child: Container(
                 padding: const EdgeInsets.all(4),
                 decoration: const BoxDecoration(
                   color: Colors.red,
                   shape: BoxShape.circle,
                 ),
                 child: const Text(
                   '2',
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 10,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
             ),
           ],
         ),
       ],
     ),
   );
 }
}