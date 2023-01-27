// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_linkify/flutter_linkify.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker_view/multi_image_picker_view.dart';
// import 'package:provider/provider.dart';
// import 'package:queen_connect/configure/app_colors.dart';
// import 'package:queen_connect/configure/app_widgets.dart';
// import 'package:queen_connect/controller/api_controller.dart';
// import 'package:queen_connect/controller/image_controller/image_get.dart';
// import 'package:queen_connect/ui/chatting/chat_home_screen.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:socket_io_client/socket_io_client.dart';
// import 'package:http/http.dart' as http;
//
//
// class OneToOneChatScreen extends StatefulWidget {
//   const OneToOneChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<OneToOneChatScreen> createState() => _OneToOneChatScreenState();
// }
//
// class _OneToOneChatScreenState extends State<OneToOneChatScreen> {
//
//   var textController = TextEditingController();
//   String? _imagePath;
//   ImageSource _imageSource = ImageSource.camera;
//   var senderId;
//
//   @override
//   void initState() {
//     loginController.press.value = false;
//     initSocket();
//     getAllPrivateConversation();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     socket.disconnect();
//     socket.dispose();
//     multiImageController.dispose();
//     textController.dispose();
//     super.dispose();
//   }
//
//   initSocket() {
//     socket = IO.io(url, <String, dynamic>{
//       'autoConnect': false,
//       'transports': ['websocket'],
//     });
//     socket.connect();
//     socket.onConnect((_) {
//       print('Connection established');
//     });
//     socket.onDisconnect((_) => print('Connection Disconnection'));
//     socket.onConnectError((err) => print('Error 1: $err'));
//     socket.onError((err) => print('Error 2: $err'));
//   }
//   var conversationList = [];
//   var photoList = [];
//
//   late final multiImageController = MultiImagePickerController(
//     maxImages: 5,
//     allowedImageTypes: ['png', 'jpg', 'jpeg', 'webp'],
//   );
//
//   getAllPrivateConversation() async {
//     var url = Uri.parse('$baseUrl/message//get/all/conversation/${privateConversationController.convoId.toString()}');
//     var res = await http.get(url);
//     var body    = json.decode(res.body);
//     var status  = body['success'];
//     var message = body['message'];
//
//     try{
//       switch(status){
//         case true:{
//           conversationList.clear();
//           setState(() {
//             conversationList.addAll(body['data']);
//           });
//         }
//         break;
//         case false:{
//           debugPrint('Error: $message');
//         }
//       }
//     } catch(e){
//       debugPrint('Get Chatting Error: $e');
//     }
//   }
//
//   Future socketOn() async {
//     socket = IO.io(url);
//     socket.on('social_new_message_${loginController.id}', (newMessage) {
//       setState(() {
//         getAllPrivateConversation();
//       });
//     });
//   }
//   DateTime timeBackPressed = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     final imageGet = Provider.of<ImageGet>(context, listen: true);
//
//     return SafeArea(
//       child: WillPopScope(
//         onWillPop: () async {
//           final differ = DateTime.now().difference(timeBackPressed);
//           final exitWarning = differ >= const Duration(seconds: 2);
//           timeBackPressed = DateTime.now();
//           if (exitWarning) {
//             privateConversationController.loader.value = false;
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatHomeScreen()));
//             return false;
//           } else {
//             return true;
//           }
//         },
//         child: Scaffold(
//             appBar: AppBar(
//               elevation: 0,
//               automaticallyImplyLeading: false,
//               flexibleSpace: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     IconButton(onPressed: (){
//                       privateConversationController.loader.value = false;
//                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ChatHomeScreen()));
//                     }, icon: const Icon(Icons.arrow_back),iconSize: 26, color: AppColors.white,),
//
//                     Container(
//                       width: w * 0.12,
//                       height: w * 0.12,
//                       clipBehavior: Clip.antiAlias,
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                       ),
//                       child: GestureDetector(
//                           onTap: (() => singleUserDataFetch(context, userId: privateConversationController.receiverId)),
//
//                           child: Image.network('$imageBaseUrl/social_users_files/${privateConversationController.userPhoto}')),
//                     ),
//                     SizedBox(width: w*0.02),
//                     Text('${privateConversationController.userName}', style: const TextStyle(color: AppColors.white, fontSize: 18),),
//
//                   ],
//                 ),
//               ),
//
//               actions: [
//                 Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     AppWidgets().simpleIconButton(context, press: (){}, icon: const Icon(Icons.call_outlined, size: 26,)),
//                     SizedBox(width: w*0.02,),
//                     AppWidgets().simpleIconButton(context, press: (){}, icon: const Padding(
//                       padding: EdgeInsets.only(right: 6),
//                       child: Icon(Icons.video_call_outlined, size: 30),
//                     )),
//                   ],
//                 )
//               ],
//
//             ),
//
//             body: Column(
//               children: [
//
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: conversationList.length,
//                     physics: const BouncingScrollPhysics(),
//                     scrollDirection: Axis.vertical,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       var reversedList = List.from(conversationList.reversed);
//                       var data = reversedList[index];
//
//                       return
//                         Padding(
//                           padding: EdgeInsets.only(left: h*0.017, right: h*0.017, top: h*0.005, bottom: 0.005),
//                           child: Column(
//                             crossAxisAlignment:
//                             loginController.id == data['sender_id'] ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                             children: <Widget>[
//
//                               data['message'] == '' || data['message'] == null ? Container() : Padding(
//                                 padding: const EdgeInsets.only(top: 1.2, bottom: 1.2),
//                                 child: Material(
//                                   borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(h*0.05),
//                                     topLeft: loginController.id == data['sender_id'] ? Radius.circular(h*0.05) : const Radius.circular(0),
//                                     bottomRight: Radius.circular(h*0.05),
//                                     topRight: loginController.id == data['sender_id'] ? const Radius.circular(0) : Radius.circular(h*0.05),
//                                   ),
//                                   color: loginController.id == data['sender_id'] ? AppColors.chatColor : AppColors.chatColor2,
//                                   elevation: 3,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                                     child: Linkify(
//                                       linkStyle: const TextStyle(color: AppColors.textColor2),
//                                       onOpen: launchURL,
//                                       textScaleFactor: 1.1,
//                                       text: data['message'].toString(),
//                                       style: TextStyle(color: loginController.id == data['sender_id'] ? Colors.white : Colors.black, fontFamily: 'Poppins', fontSize: 15,
//                                       ),
//                                     ),
//
//                                     // Text(
//                                     //   data['message'].toString(),
//                                     //   style: TextStyle(
//                                     //     color: loginController.id == data['sender_id'] ? Colors.white : Colors.black,
//                                     //     fontFamily: 'Poppins',
//                                     //     fontSize: 15,
//                                     //   ),
//                                     // )
//
//                                   ),
//                                 ),
//                               ) ,
//
//                               for(var i = 0; i<data['attachments'].length; i++)...{
//                                 Padding(padding: const EdgeInsets.only(bottom: 4),
//                                   child: Image.network('$imageBaseUrl/social_message_files/${data['attachments'][i]}',  width: w/2, fit: BoxFit.cover,),)
//                               },
//
//
//                             ],
//                           ),
//                         );
//
//                     },
//                   ),
//                 ),
//
//                 _imagePath != null ? Stack(
//                     children:[
//                       Center(child: Image.file(File(_imagePath!), height:h*.225)),
//                       Positioned(
//                           left: w*0.58,
//                           top: -10,
//                           child: IconButton(
//                               icon: Icon(
//                                 Icons.cancel,
//                                 color: Colors.black.withOpacity(0.7),
//                                 size: 30,
//                               ),
//                               onPressed: () => setState(() {
//                                 _imagePath = null;
//                               })))
//                     ]) : Container(),
//
//                 Card(
//                   color: Colors.white54,
//                   child: Row(
//                     children: [
//
//                       AppWidgets().simpleIconButton(context, press: (){
//                         _imageSource = ImageSource.camera;
//                         _getImage();
//                       }, icon: const Icon(Icons.camera_alt_outlined, color: AppColors.secondaryColor,)),
//                       AppWidgets().simpleIconButton(context,
//
//                           press: () {
//                             showModalBottomSheet<void>(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   height: h / 0.2,
//                                   color: Colors.white,
//                                   child: Column(
//                                     children: [
//
//                                       Expanded(
//                                         child:
//                                         MultiImagePickerView(
//                                           controller:multiImageController,
//                                           padding: const EdgeInsets.all(10),
//                                           initialContainerBuilder:
//                                               (context, pickerCallback) {
//                                             return GestureDetector(
//                                               child: Container(
//                                                 height: 120,
//                                                 width: 120,
//                                                 decoration:
//                                                 BoxDecoration(
//                                                   borderRadius:
//                                                   BorderRadius.circular(5),
//                                                   // color: mainColor4,
//                                                 ),
//                                                 child: Padding(
//                                                   padding:
//                                                   const EdgeInsets.all(5.0),
//                                                   child: Center(
//                                                     child: Image.asset("assets/images/add_photo.png", height: h * 0.2, width: w * 0.7,),
//                                                   ),
//                                                 ),
//                                               ),
//                                               onTap: () {
//                                                 pickerCallback();
//                                               },
//                                             );
//                                           },
//                                           addMoreBuilder: (context,
//                                               pickerCallback) {
//                                             return SizedBox(
//                                               height: 120,
//                                               width: double
//                                                   .infinity,
//                                               child: Center(
//                                                 child:
//                                                 Container(
//                                                   height: 120,
//                                                   width: 120,
//                                                   decoration:
//                                                   BoxDecoration(
//                                                     borderRadius:
//                                                     BorderRadius.circular(5),
//                                                     // color: mainColor4,
//                                                   ),
//                                                   child:
//                                                   Padding(
//                                                     padding:
//                                                     const EdgeInsets.all(5.0),
//                                                     child:
//                                                     TextButton(
//                                                       style: TextButton.styleFrom(
//                                                         backgroundColor: AppColors.primaryColor,
//                                                         // shape: const CircleBorder(),
//                                                       ),
//                                                       child:
//                                                       Center(
//                                                         child:
//                                                         Icon(
//                                                           Icons.add,
//                                                           color: AppColors.textColor,
//                                                           size: h*0.07,
//                                                         ),
//                                                       ),
//                                                       onPressed:
//                                                           () {
//                                                         pickerCallback();
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//
//
//                                         ),
//                                       ),
//                                       // multiImageController.images.length == 0 ? (){} :
//                                       GestureDetector(
//                                         onTap: (){
//                                           loginController.press.value = true;
//                                           sendMultipleImage(
//                                             context,
//                                             convoId: privateConversationController.convoId.toString(),
//                                             senderId: loginController.id.toString(),
//                                             multiImage: multiImageController.images,
//                                           ).then((value) {
//                                             textController.clear();
//
//                                             getAllPrivateConversation();
//                                             socketOn();
//                                           });
//
//
//                                           Navigator.pop(context);
//
//                                         },
//                                         child: Container(
//                                             height: h*0.06,
//                                             width: w*0.3,
//                                             padding: const EdgeInsets.all(8),
//                                             margin: const EdgeInsets.only(right: 10, bottom: 8),
//                                             decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(100),
//                                                 color: AppColors.secondaryColor,
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Colors.grey.withOpacity(.35),
//                                                       blurRadius: 2,
//                                                       spreadRadius: 1.5,
//                                                       offset: const Offset(0, 2.0))
//                                                 ]),
//                                             child: const Icon(Icons.send, color: Colors.white, size: 30,)
//                                         ),
//                                       ),
//
//                                     ],
//                                   ),
//                                 );
//                               },
//                             );
//
//                           },
//
//                           icon: const Icon(Icons.photo_library_outlined, color: AppColors.secondaryColor,)),
//
//
//                       Expanded(
//                         child: Stack(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: SizedBox(
//                                   width: w*0.65,
//                                   child: AppWidgets().msgInputField(context,
//                                       controller: textController,
//                                       minLine: 1,
//                                       maxLine: 3,
//                                       hintText: 'type_message'.tr,
//                                       icon: AppWidgets().simpleIconButton(context,
//                                           press: (){},
//                                           icon: const Icon(Icons.emoji_emotions_outlined, color: AppColors.secondaryColor,) )),
//
//
//                                 ),
//                               ),
//                               Positioned(
//                                 right: -10,
//                                 bottom: 1,
//                                 child: GestureDetector(
//                                   onTap: (){
//                                     if(textController.text == '' && _imagePath == null){
//                                       debugPrint('text: ${textController.text}');
//                                       debugPrint('image: $_imagePath');
//                                     } else{
//                                       debugPrint('text1: ${textController.text}');
//                                       debugPrint('image1: $_imagePath');
//                                       setState(() {
//                                         debugPrint(textController.text.toString());
//                                         loginController.press.value = true;
//                                         sendPrivateMsg(
//                                           context,
//                                           convoId: privateConversationController.convoId.toString(),
//                                           senderId: loginController.id.toString(),
//                                           messageController: textController.text.toString(),
//                                           photo: _imagePath,
//                                           multiImage: multiImageController.images,
//                                         ).then((value) {
//                                           getAllPrivateConversation();
//                                           socketOn();
//
//                                           final images = multiImageController.images; // return Iterable<ImageFile>
//                                           for (final image in images) {
//                                             if (image.hasPath) {
//                                               multiImageController.removeImage(image);
//                                             }
//                                           }
//
//                                         });
//                                         textController.clear();
//                                         _imagePath = null;
//
//                                       });
//                                     }
//                                   },
//                                   child: Container(
//                                       height: h*0.05,
//                                       width: h*0.05,
//                                       padding: const EdgeInsets.all(8),
//                                       margin: const EdgeInsets.only(right: 10, bottom: 8),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(100),
//                                           color: AppColors.secondaryColor,
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Colors.grey.withOpacity(.35),
//                                                 blurRadius: 2,
//                                                 spreadRadius: 1.5,
//                                                 offset: const Offset(0, 2.0))
//                                           ]),
//                                       child: const Icon(Icons.send, color: Colors.white,)
//                                   ),
//                                 ),
//                               ),
//                             ]
//                         ),
//                       ),
//
//                     ],
//                   ),
//                 ),
//
//
//               ],
//             )
//
//         ),
//       ),
//     );
//
//   }
//
//   void _getImage() async {
//     final selectedImage = await ImagePicker().pickImage(source: _imageSource);
//     if (selectedImage != null) {
//       setState(() {
//         _imagePath = selectedImage.path;
//       });
//     }
//   }
//
//
// }