import 'package:familytest/network/requests.dart';
import 'package:familytest/pages/chat/model/chatmoled.dart';
import 'package:rongcloud_im_plugin/rongcloud_im_plugin.dart';

class Roogyun{

//  初始化
static rooginit(){
    RongIMClient.init("p5tvi9dsplrv4");
  }
//  监听
static rooglistn(){
  RongIMClient.onMessageReceived = (Message msg,int left) {
    print("receive message messsageId:"+msg.messageId.toString()+" left:"+left.toString()+'msg:'+msg.toString());
    print("消息类型6：${msg.content.conversationDigest()}");
    print("消息发送者信息：${msg.content.sendUserInfo}");
  };
}

//检查连接状态
static roogclientstatue(){
  RongIMClient.onConnectionStatusChange = (int connectionStatus) {
    if (RCConnectionStatus.KickedByOtherClient == connectionStatus ||
        RCConnectionStatus.TokenIncorrect == connectionStatus ||
        RCConnectionStatus.UserBlocked == connectionStatus) {
      String toast = "连接状态变化 $connectionStatus, 请退出后重新登录";
      print("连接有误");
    } else if (RCConnectionStatus.Connected == connectionStatus) {
      print("连接成功");
    }
  };
}

//获得指定会话消息
 static getConversation(String targetId)async{
    Conversation con =await RongIMClient.getConversation(RCConversationType.Private, targetId);
    print("得到会话：${con.latestMessageContent.conversationDigest()}");
  }


//  发送消息
static sedMessage(String sendmsg,String pid)async{
    TextMessage txtMessage = new TextMessage();
    txtMessage.content = sendmsg;
    Message msg = await RongIMClient.sendMessage(RCConversationType.Private, pid, txtMessage);
    var st = msg.sentStatus;
    print("发送消息状态：${st}");
  }

//  获取所有的会话
static getallConversation()async{
  List<chatmodel> userlist = [];
  List ?conversationList = await RongIMClient.getConversationList([RCConversationType.Private,RCConversationType.Group,RCConversationType.System]);
  print("获取所有的会话：${conversationList}");
//  接收方
  print("获取所有接收方id：${conversationList[0].targetId}");
//  发送方
  print("获取所有发送方id：${conversationList[0].senderUserId}");
  for(var i=0;i<conversationList.length;i++){
    var result = await Request.getNetwork('user/',params: {
      'user_id':conversationList[i].targetId
    });
    userlist.add(chatmodel(result,conversationList[i].latestMessageContent.content));
  }
  print("userlis:${userlist}");
  return userlist;
}


//连接融云
static  roogclient(String ?token)async{
    print("进入");
    var a = await RongIMClient.getConnectionStatus();
    if(a != 0){
      RongIMClient.connect(token, (code, userId) => print("状态码：${code},${userId}"));
    }
    print("连接状态：${a}");
    print("退出");
  }

}