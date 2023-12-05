// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// import 'package:onspace/features/home/ui/widgets/menu_options_widget.dart';
//
// class SideDrawerView extends StatelessWidget {
//   const SideDrawerView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: theme.colorScheme.primary,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(4.0),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: theme.colorScheme.onPrimary,
//                       border: Border.all(color: theme.colorScheme.onPrimary, width: 2.0)
//                   ),
//
//                   child: Image.asset("assets/images/avatar.png", height: 50.0, width: 50.0,),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                  Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Hi Enos",
//                       style: theme.textTheme.displayLarge?.copyWith(
//                           fontSize: 16
//                       )
//                     ),
//                     const SizedBox(
//                       height: 5.0,
//                     ),
//                     RichText(text: TextSpan(
//                       text: "Your PesaKit number is ", style: theme.textTheme.displayMedium?.copyWith(fontSize: 14),
//                       children: [
//                         TextSpan(
//                           text: "123456",
//                             style: theme.textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 14)
//                         )
//                       ]
//                     )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           MenuOptionWidget(
//               onTap: (){
//               context.goNamed("create_lead_step_one");
//               },
//               showDivider: true,
//               title: "Create new lead",
//               assetName: "account.png"
//           ),
//           MenuOptionWidget(
//               onTap: (){
//                context.goNamed('change_pin');
//               },
//               showDivider: true,
//               title: "Change PIN",
//               assetName: "safe.png"
//           ),
//           MenuOptionWidget(
//               onTap: (){
//                 context.goNamed('chat');
//               },
//               showDivider: true,
//               title: "Chat with us",
//               assetName: "businessinfo.png"
//           ),
//           MenuOptionWidget(
//               onTap: (){
//               showWarningDialog(context: context,
//                   buttonPressed: (){
//                     context.goNamed('login');
//                   },
//                   title: "Log Out",
//                   btnText: "Proceed", description: "You will be leaving the app ?");
//               },
//               showDivider: true,
//               title: "Log Out",
//               assetName: "logout_dash.png"
//           ),
//         ],
//       ),
//     );
//   }
// }