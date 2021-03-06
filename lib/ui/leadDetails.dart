import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:minicode_crm/models/leadDetails.dart';
import 'package:minicode_crm/translation/localizations.dart';
import 'package:minicode_crm/ui/addAction.dart';
// import 'package:minicode_crm/ui/addAction.dart';/
import 'package:minicode_crm/ui/commonUI.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:minicode_crm/ui/editLeadDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class LeadDetails extends StatefulWidget {
  final String name;
  final String mobile;
  final String projectName;
  final DateTime creationDate;
  final String stageName;
  final String stageID;
  final String clientID;
  final String channelName;
  final String lastComment;
  LeadDetails(
      {this.name,
      this.mobile,
      this.projectName,
      this.stageName,
      this.creationDate,
      this.stageID,
      this.clientID,
      this.channelName,
      this.lastComment});
  @override
  _LeadDetailsState createState() => _LeadDetailsState();
}

class _LeadDetailsState extends State<LeadDetails> {
  CommonUI commonUIObj;
  TextEditingController commentController = new TextEditingController();
  LeadModel leadModel = new LeadModel();
  DateTime nextActionDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    commonUIObj = new CommonUI(context);

    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height / 3 - 100.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigo,
                      Colors.indigo[400],
                      Colors.indigo[300],
                      Colors.indigo[100]
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Text((widget.name),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text((widget.stageName == null)?"":
                   widget.stageName,
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 15.0)),
                  )
                ],
              ),
            )),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: (){},
        //     icon: Icon(Icons.more_vert,color:Colors.white),
        //   )
        // ],

        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Text(AppLocalizations.of(context).creationDate,
                          style: TextStyle(
                              color: Colors.indigo[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                    ],
                  ),
                  // SizedBox(height: 10.0),

                  Row(
                    // textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Text((widget.creationDate.toString() == null)?"":
                      widget.creationDate.toString().substring(0,10),
                          style: TextStyle(
                              color: Colors.indigo[200], fontSize: 16.0)),
                    ],
                  ),
                  // SizedBox(height: 10.0),
                  Divider(),

                  Row(
                    // textDirection: TextDirection.ltr,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: (Localizations.localeOf(context)
                                          .languageCode ==
                                      "en")
                                  ? "Stage\n"
                                  : "موقف العميل\n",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                              text: (widget.stageName == null)?"":widget.stageName,
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.indigo[200])),
                        ]),
                      )
                      // Text("Stage\n",style:TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize:17.0)),
                      // Text("Following",style:TextStyle(color: Colors.grey,fontSize:15.0)),
                    ],
                  ),

                  // SizedBox(height: 10.0),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).leadComment,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (widget.lastComment ==null)?"":widget.lastComment,
                        style: TextStyle(
                            fontSize: 15.0, color: Colors.indigo[200]),
                      )
                    ],
                  ),
                  Divider(),

                  // SizedBox(height: 10.0,),
                  // Row(
                  //   textDirection: TextDirection.ltr,
                  //   children: <Widget>[
                  //     Text("Comment\n",
                  //         style: TextStyle(
                  //             color: Colors.indigo,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 16.0)),
                  //   ],
                  // ),

                  Row(
                    // textDirection: TextDirection.ltr,
                    children: <Widget>[
                      Text(AppLocalizations.of(context).nextActionDate,
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                    ],
                  ),
                  FlatButton(
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2000, 3, 5),
                            maxTime: DateTime(2020, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          print('confirm $date');
                          setState(() {
                            nextActionDate = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.ar);
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            nextActionDate.day.toString() +
                                "-" +
                                nextActionDate.month.toString() +
                                "-" +
                                nextActionDate.year.toString(),
                            style: TextStyle(color: Colors.indigo[200]),
                          ),
                          SizedBox(width: 10.0),
                          Icon(Icons.edit, color: Colors.indigo[200])
                        ],
                      )),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // ScreenFlexibleWidget(
                  //     // 1. Wrap with `ScreenFlexibleWidget`

                  //     child: Builder(builder: (BuildContext context) {
                  //   return Container(
                  //     // child :  commonUIObj.buildTextField("Lead Note", leadNote,TextInputType.text, context),
                  //     child: Padding(
                  //       padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  //       child: TextField(
                  //         controller: commentController,

                  //         // style: textStyle,
                  //         onChanged: (val) {
                  //           // debugPrint("something changed in description ");
                  //           // updateDescription();
                  //         },
                  //         maxLines: null,
                  //         decoration: InputDecoration(
                  //             filled: true,
                  //             fillColor: Colors.white54,
                  //             contentPadding: EdgeInsets.all(10.0),
                  //             hintText: "Write your comment",
                  //             hintStyle: TextStyle(color: Colors.indigo[200]),
                  //             border: OutlineInputBorder(
                  //               borderSide: BorderSide.none,
                  //               // borderSide: BorderSide(color: Colors.indigo[200]),
                  //               borderRadius: const BorderRadius.all(
                  //                 const Radius.circular(10.0),
                  //               ),
                  //             )),
                  //       ),
                  //     ),
                  //   );
                  // })),
                  // SizedBox(height: 10.0),
                  Divider(),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0.0, left: 8),
                      child: ExpandablePanel(
                        iconColor: Colors.indigo,
                        header: Text(
                          AppLocalizations.of(context).contactInfo,
                          style: TextStyle(
                              color: Colors.indigo[800], fontSize: 17.0),
                        ),
                        expanded: Column(
                          children: <Widget>[
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: <Widget>[
                            //     Text("email@gmail.com",
                            //         style: TextStyle(color: Colors.indigo)),
                            //     // SizedBox(width: 5.0),
                            //     InkWell(
                            //       child: Icon(
                            //         Icons.email,
                            //         color: Colors.indigo,
                            //         size: 15.0,
                            //       ),
                            //       onTap: () {},
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 10.0,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(widget.mobile,
                                    style: TextStyle(color: Colors.indigo)),
                                // SizedBox(width: 5.0),
                                InkWell(
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.indigo,
                                    size: 15.0,
                                  ),
                                  onTap: () {
                                    _makePhoneCall(widget.mobile);
                                  },
                                ),
                                InkWell(
                                  child: Image(
                                    height: 25.0,
                                    width: 25.0,
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/Whatsapp.png"),
                                  ),
                                  onTap: () {
                                    _launchWhatsapp(widget.mobile);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),

                        // child:Text("Contact Info",style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),

                  //                     Container(
                  //                       height:100.0,

                  //                       child:  GridView.builder(
                  //                         // shrinkWrap: true,
                  //                       // scrollDirection: Axis.horizontal,
                  //                       itemCount: categories.length,
                  //                       itemBuilder: (context,index){
                  //  return _buildTagContainer(index,categories[index]);
                  //                       }, gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  //                 crossAxisCount: 3,
                  //                 crossAxisSpacing: 3.0,
                  //                 //for height of card
                  //                 childAspectRatio: 2.0,
                  //                 //for horizontal space
                  //                 mainAxisSpacing: 0.3,

                  //               ),
                  //                     ),
                  //                     ),
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 18.0, left: 8),
                  //     child: ExpandablePanel(
                  //       iconColor: Colors.indigo,
                  //       header: Text(
                  //         "More Info",
                  //         style:
                  //             TextStyle(color: Colors.indigo[800], fontSize: 17.0),
                  //       ),
                  //       expanded: Column(
                  //         children: <Widget>[
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: <Widget>[
                  //               Text("CITY:",
                  //                   style: TextStyle(color: Colors.indigo)),
                  //               SizedBox(
                  //                 width: 5.0,
                  //               ),
                  //               Text("Assuit",
                  //                   style: TextStyle(color: Colors.indigo[200])),
                  //               // SizedBox(width: 5.0),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: <Widget>[
                  //               Text("Country:",
                  //                   style: TextStyle(color: Colors.indigo)),
                  //               SizedBox(width: 5.0),
                  //               Text("Egypt",
                  //                   style: TextStyle(color: Colors.indigo[200])),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //             children: <Widget>[
                  //               Text("SOURCE LEAD",
                  //                   style: TextStyle(color: Colors.indigo)),
                  //               SizedBox(width: 5.0),
                  //               Text("Facebook",
                  //                   style: TextStyle(color: Colors.indigo[200])),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 10.0,
                  //           )
                  //         ],
                  //       ),

                  //       // child:Text("Contact Info",style: TextStyle(color: Colors.white),),
                  //     ),
                  //   ),
                  // ),
                  // Divider(),
                  // Directionality(
                  //   textDirection: TextDirection.ltr,
                  //   child: Row(
                  //     //  textDirection: TextDirection.rtl,
                  //     children: <Widget>[
                  //       RichText(
                  //         text: TextSpan(children: [
                  //           TextSpan(
                  //               text: "Leads Details\n",
                  //               style: TextStyle(
                  //                 fontSize: 16.0,
                  //                 color: Colors.indigo[800],
                  //                 fontWeight: FontWeight.bold,
                  //                 decoration: TextDecoration.underline,
                  //               )),
                  //           TextSpan(
                  //               text: "CITY\n",
                  //               style: TextStyle(
                  //                 color: Colors.indigo,
                  //                 fontSize: 16.0,
                  //               )),
                  //           TextSpan(
                  //               text: "cairo\n",
                  //               style: TextStyle(
                  //                 color: Colors.indigo[200],
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 15.0,
                  //               )),
                  //         ]),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Divider(),
                  // Directionality(
                  //   textDirection: TextDirection.ltr,
                  //   child: Row(
                  //     children: <Widget>[
                  //       RichText(
                  //         text: TextSpan(children: [
                  //           TextSpan(
                  //               text: "Country\n",
                  //               style: TextStyle(
                  //                 fontSize: 16.0,
                  //                 color: Colors.indigo,
                  //               )),
                  //           TextSpan(
                  //               text: "Egypt\n",
                  //               style: TextStyle(
                  //                 fontSize: 15.0,
                  //                 color: Colors.indigo[200],
                  //                 fontWeight: FontWeight.bold,
                  //               )),
                  //         ]),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  // Divider(),
                  // Directionality(
                  //   textDirection: TextDirection.ltr,
                  //   child: Row(
                  //     children: <Widget>[
                  //       RichText(
                  //         text: TextSpan(children: [
                  //           TextSpan(
                  //               text: "SOURCE LEAD\n",
                  //               style: TextStyle(
                  //                 fontSize: 16.0,
                  //                 color: Colors.indigo,
                  //               )),
                  //           TextSpan(
                  //               text: "facebook\n",
                  //               style: TextStyle(
                  //                 fontSize: 15.0,
                  //                 color: Colors.indigo[200],
                  //                 fontWeight: FontWeight.bold,
                  //               )),
                  //         ]),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            leadModel = new LeadModel(
                                clientID: int.parse(widget.clientID),
                                clientName: widget.name,
                                clientMobile: widget.mobile,
                                channelName: widget.channelName,
                                stageID: int.parse(widget.stageID),
                                stageName: widget.stageName,
                                lastComment: widget.lastComment);
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  new EditLeadDetails(leadModel)));
                        },
                        child: Container(
                          height: 40.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.indigo[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            (Localizations.localeOf(context).languageCode ==
                                    "en")
                                ? "Edit"
                                : "تعديل",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => new AddAction(
                                    type: "add",
                                    clientID: widget.clientID,
                                    stageID: widget.stageID,
                                  )));
                        },
                        child: Container(
                          height: 40.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.indigo[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            AppLocalizations.of(context).addAction,
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ));
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch("tel://" + url)) {
      launch("tel://" + url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildTagContainer(int index, String item) {
    return Row(
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Container(
            height: 40.0,
            width: 100.0,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                border: new Border.all(color: Colors.grey)),
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 5.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(
                      child: Text(item, style: TextStyle(color: Colors.grey))),
                  SizedBox(width: 10.0),
                  InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.close,
                        color: Colors.grey,
                        size: 15.0,
                      ))
                ],
              ),
            )),
        // SizedBox(width:10.0)
      ],
    );
  }

  void _launchWhatsapp(String mobile) async {
    var whatsappUrl = "whatsapp://send?phone=$mobile";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }
}
