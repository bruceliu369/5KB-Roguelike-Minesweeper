import 'package:flutter/material.dart';import 'dart:math';import 'package:flare_flutter/flare_actor.dart';import 'package:percent_indicator/linear_percent_indicator.dart';const HW=0xffffffff,IH=2,IC=4,IS=8,IT=16,LD=32,MN=64;const brd=BorderSide(width:4,color:Color(HW));var rnd=Random().nextInt;var d4=[[1,0],[0,1],[-1,0],[0,-1]],d8=List.from(d4)..addAll([[1,1],[1,-1],[-1,1],[-1,-1]]);main()=>runApp(App());class App extends StatelessWidget{build(BuildContext c){return MaterialApp(title:'RM',theme:ThemeData(brightness:Brightness.dark,fontFamily:'Fnt'),home:H());}}class H extends StatefulWidget{H({Key key}):super(key:key);GS createState()=>GS();}class Grd{int t;bool r=false;}class Itm{int t;Itm(_t){t=_t;}}class GS extends State<H>{int ht=10,wt=7,lv=1,tc=0;bool iS,iC,fst,alive=false;double mxt=90000,rmt=0;List<List<Grd>>grd;BuildContext ctx;List<Itm>itms;String msg;final stl=TextStyle(fontFamily:'Fnt',fontSize:15,color:Color(HW),backgroundColor:Color(0x66000000));GS(){nlv();rst();}nlv(){msg="";fst=true;grd=List<List<Grd>>(wt);for(int x=0;x<wt;x++){grd[x]=List<Grd>(ht);for(int y=0;y<ht;y++){grd[x][y]=Grd();grd[x][y].t=[MN,MN,IH,IH,IH,IC,IS,IT,IT,0,0,0,0,0,0,0,0,0,0,0][rnd(20)];}}}rst()async{lv=1;iS=iC=false;itms=[Itm(0),Itm(0),Itm(0)];alive=true;rmt=mxt;while(alive){var b=DateTime.now().millisecondsSinceEpoch;await Future.delayed(Duration(milliseconds:33));setState((){rmt-=DateTime.now().millisecondsSinceEpoch-b;rmt=max(0,rmt);});if(rmt>0)continue;dead();return;}}dead(){if(!alive)return;alive=false;showDialog(context:ctx,barrierDismissible:false,builder:(BuildContext c){return AlertDialog(title:Text("Dead"),actions:[FlatButton(onPressed:()=>rply(c),child:Text("Retry"))],);});}vld(int x,int y)=>x>=0&&y>=0&&x<wt&&y<ht;cnt(int x,int y,List tps)=>d8.fold(0,(t,e)=>vld(x+e[0],y+e[1])&&tps.contains(grd[x+e[0]][y+e[1]].t)?t+1 :t);rply(BuildContext c){Navigator.of(c).pop();setState((){nlv();rst();});}hnt(int x,int y){if(!grd[x][y].r||[LD,MN].indexOf(grd[x][y].t)>=0)return '';int c1=cnt(x,y,[MN]);int c2=cnt(x,y,[IH,IC,IS,IT,LD]);if(c1==0&&c2==0)return '';return " ! $c1 \n ? $c2 ";}rvl(int x,int y,Map mem)async{if(mem['$x-$y']==true)return;setState((){grd[x][y].r=true;});mem['$x-$y']=true;await Future.delayed(Duration(milliseconds:200));if(cnt(x,y,[IH,IC,IS,IT,LD,MN])>0)return;d4.forEach((List ta){int ax=x+ta[0],ay=y+ta[1];if(!vld(ax,ay)||mem['$ax-$ay']!=null)return;rvl(ax,ay,mem);});}tap(int x,int y)async{msg="";setState((){if(grd[x][y].r&&grd[x][y].t==LD){if(lv==5){alive=false;showDialog(context:ctx,barrierDismissible:false,builder:(BuildContext c)=>AlertDialog(title:Text("clear!"),actions:[FlatButton(onPressed:()=>rply(c),child:Text("Replay"))]));}else{lv+=1;nlv();}return;}if(iC){for(var v=0;v<wt;v++){if(grd[v][y].t==0)grd[v][y].r=true;}for(var v=0;v<ht;v++){if(grd[x][v].t==0)grd[x][v].r=true;}iC=false;}if(grd[x][y].t==MN){rmt=max(0,rmt-(iS?0.25 :1)*20000);iS=false;itms.lastWhere((i)=>i.t==IT,orElse:()=>Itm(0)).t=0;msg="damaged";tc=0xffff0000;}else if(grd[x][y].t==LD){msg="found ladder";tc=HW;}else if(grd[x][y].t>0){adi(grd[x][y].t);}rvl(x,y,{});});}adi(int tp){var i=itms.indexWhere((item)=>item.t==0);if(i==-1)return;itms[i]=Itm(tp);msg="got ${{IH:"heart",IC:"slash",IS:"shield",IT:"trash"}[tp]}";tc=HW;}rmi(Itm itm){setState((){switch(itm.t){case IH:rmt+=0.5*(mxt-rmt);break;case IC:iC=true;break;case IS:iS=true;break;case IT:return;}itms.remove(itm);itms.add(Itm(0));});}build(BuildContext c){ctx=c;return Scaffold(persistentFooterButtons:itms.map((itm){return SizedBox(width:48,height:48,child:Container(decoration:BoxDecoration(border:Border(top:brd,left:brd,right:brd,bottom:brd),),child:IconButton(icon:Image(width:50,image:ExactAssetImage("a/${itm.t}.gif")),onPressed:()=>rmi(itm)),));}).toList(),body:Container(decoration:BoxDecoration(image:DecorationImage(alignment:Alignment.topCenter,image:ExactAssetImage("a/lv-$lv.png"),fit:BoxFit.fitWidth)),child:Column(children:[Container(height:30),Row(mainAxisAlignment:MainAxisAlignment.start,children:[Container(width:150,height:20),RepaintBoundary(child:LinearPercentIndicator(width:100,lineHeight:8,percent:(1-(mxt-rmt)/ mxt),progressColor:Colors.pink,)),Container(width:8),Text("LV:$lv"),Image(width:iC?20 :0,image:ExactAssetImage("a/$IC.gif")),Image(width:iS?20 :0,image:ExactAssetImage("a/$IS.gif"))],),Container(height:20),Text(msg,style:TextStyle(fontSize:20,color:Color(tc))),Container(margin:EdgeInsets.only(top:20),child:Column(children:List.generate(ht,(y)=>Row(mainAxisAlignment:MainAxisAlignment.center,children:List.generate(wt,(x){return SizedBox(width:50,height:50,child:GestureDetector(onTap:(){if(grd[x][y].r&&grd[x][y].t!=LD)return;if(fst){grd[x][y].t=0;d8.forEach((ta){int v=x+ta[0],w=y+ta[1];if(!vld(v,w))return;grd[v][w].t=0;});grd[(x+rnd(wt-3)+2)% wt][(y+rnd(ht-3)+2)% ht].t=LD;fst=false;}tap(x,y);},child:Stack(alignment:AlignmentDirectional.center,children:[FlareActor("a/f$lv.flr",animation:grd[x][y].r?'cut' :'idle',fit:BoxFit.fitHeight,),Image(width:30,image:ExactAssetImage("a/${grd[x][y].r?grd[x][y].t :0}.gif")),Text(hnt(x,y),style:stl)])));})))))])));}}