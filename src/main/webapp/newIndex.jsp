<%@ page import="java.util.List" %>
<%@ page import="java.lang.reflect.Array" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2017/11/20
  Time: 11:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>My WebSocket</title>

    <style type="text/css">
        #poplayer
        {
            position:absolute;
            top:100px;
            left:400px;
            width:300px;
            height:200px;
            z-index:8888;

        }
        .covered
        {
            position:fixed;
            _position:absolute;
            z-index:888;
            top:0px;
            left:0px;
            width:100%;
            height:100%;

            opacity:0.3;
        }

    </style>
</head>
<body onload="getData()">


<div id="covered" class="covered">
<div style="height:100px;background-color:rgba(242, 242, 242, 1);">
    <h1 style="line-height: 100px"> Smart Assistant for TED Talkers
        <span id="mytime" style="line-height: 100px; float: right"></span>
    </h1>
</div>

<div style="height: 30px;background-color: rgba(153, 255, 255, 1);text-align:center" >
    <span id="message"></span>
</div>


<div style="margin-top:50px">

    <div style="float: left">
        startTime: <input class="Wdate" type="text" id="start" onClick="WdatePicker({el:this,dateFmt:'HH:mm'})">
        endTime: <input class="Wdate" type="text" id="end" onClick="WdatePicker({el:this,dateFmt:'HH:mm'})">
        duration:<span><input  id="duration" type="text" style="width:30px"/>min</span>
        <button onclick="val()">Apply</button>
        <br>


        <form action="path.html" method="post" enctype="multipart/form-data" style="margin-top: 30px">
            <input type="file" name="file" multiple="multiple"/>
            <button type="submit">Upload</button>
        </form>


    </div>

    <div style="float: right">
        <form id="myform">
            Message: <label><input name="Fruit" type="radio" value="Info" />Info</label>
            <label><input name="Fruit" type="radio" value="Warning" />Warning</label>
            <label><input name="Fruit" type="radio" value="Alarm" />Alarm</label>
            <br>
            <textarea  name="Fruit2" type="text"  style="margin: 0px; width: 507px; height: 73px;"></textarea>
            <br>
            <button type="button" style="float: right" onclick="pushmessage()" >Send</button>

        </form>

    </div>

</div>



<div style="background-color:rgba(204, 204, 204, 1);margin-top:180px; width:850px; height: 200px; margin-left: 400px">
    <div style="width:100%;height:20px">
        <div style="width:30%;float:left;margin-left:3%">Last page:</div>
        <div style="width:30%;float:left;margin-left:3%">PPT Notes:</div>
        <div style="width:30%;float:left;margin-left:3%">Next page:</div>
    </div>
    <div style="width:30%;height:65%;padding-top:1%;margin-left:3%;float:left">
        <textarea id="LastPage" type="text" value="" style="margin: 0px; width: 80%; height: 100%;"></textarea>
    </div>
    <div style="width:30%;height:65%;padding-top:1%;margin-left:3%;float:left">
        <textarea  id="PPTNotes" type="text" value="" style="margin: 0px; width: 80%; height: 100%;" ></textarea>
    </div>
    <div style="width:30%;height:65%;padding-top:1%;margin-left:3%;float:left">
        <textarea  id="NextPage" type="text" value="" style="margin: 0px; width: 80%; height: 100%;" ></textarea>
    </div>

    <div style="width: 100%; height:10%;text-align:center;margin-top:18%">
        <button><</button>
        <span>Pages</span>
        <span><input id ="pageNO" type="text" style="width:30px"/>/<input id="total" type="text" style="width:30px"/></span>
        <button onclick="pagePPT()">></button>
    </div>
</div>

</div>

    <div id="poplayer" style="width:1600px;height:1600px">
        <H1 style="text-align: center">Zeiss智能眼镜推送后台</H1>
        <div id="message" style="text-align: center">   </div>
        </br> </br>
        <!-- 计时的布局 -->
        <DIV style="text-align: center">
        <div
        style="text-align: center;">
        <div id="code"
        style="text-align: center" />
        </div>
        <h3 id="scanresult">扫描二维码与智能眼镜连接</h3>
        </div>
    </div>

<% ArrayList data = (ArrayList) request.getAttribute("data");%>
</body>
</html>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
<script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>
<script type="text/javascript" src="My97DatePicker/WdatePicker.js"></script>
<%--<script src="./js/jquery-3.2.1.min.js"></script>--%>
<script src="./js/format.js"></script>
<script type="text/javascript">
var array = '<%=data%>'
var myArray=new Array();
var pageNO=1;
    $(function () {
        array = array.replace(/\[|]/g,'')
        myArray = array.split(",");

        if (myArray[0] != "null"){
            document.getElementById("total").value=myArray.length;

            document.getElementById("PPTNotes").value=myArray[pageNO-1];

            document.getElementById("NextPage").value=myArray[pageNO];

            document.getElementById("pageNO").value=pageNO;

            document.getElementById("poplayer").style.display= "none";
            document.getElementById("covered").style.opacity="0.";
            $("#covered").removeClass('covered');
        }

    });

    function pagePPT() {

    }


    var websocket = null;

    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        websocket = new WebSocket("ws://127.0.0.1:8080/webSocket/websocket");
    } else {
        alert('您的浏览器不支持')
    }

    //连接发生错误的回调方法
    websocket.onerror = function() {
        setMessageInnerHTML("服务端未知错误,请点击重试");
    };

    //连接成功建立的回调方法
    websocket.onopen = function(event) {
        setMessageInnerHTML("Automatic connection");
        websocket.send("web/this for web connect")
    }

    //接收到消息的回调方法
    websocket.onmessage = function(event) {
 /*       $("input:text").each(function(){
            $(this).attr("readonly","readonly");*/
        alert("client response :"+event.data)
        if (event.data == "success"){
            if(array!=null){
                alert("二维码扫面"+event.data);
                document.getElementById("poplayer").style.display= "none";
                document.getElementById("covered").style.opacity="0.";
                $("#covered").removeClass('covered');
            }

        }
        //		setMessageInnerHTML(event.data);
        //      setMessageAttribute(event.data);
        //setScanResult(event.data);
    }

    //连接关闭的回调方法
    websocket.onclose = function() {
        setMessageInnerHTML("Disconnected connection");
    }

    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function() {
        websocket.close();
    }

    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        document.getElementById('message').innerHTML += innerHTML + '<br/>';
    }
    //将原显示的消息替换
    function setMessageAttribute(attribute) {
        document.getElementById('message').attribute += innerHTML + '<br/>';
    }
    //关闭连接
    function closeWebSocket() {
        websocket.close();
    }



    function val(){
        var start = document.getElementById("start").value;
        var end = document.getElementById("end").value;

        var time1 = new Date().Format("yyyy-MM-dd");


        var  startTime = time1+" "+start;
        var endTime = time1+" "+end;

        startTime = new Date(Date.parse(startTime.replace(/-/g, "/")));
        endTime = new Date(Date.parse(endTime.replace(/-/g, "/")));
        var duration =null;
        if (startTime < endTime){
            duration = (endTime-startTime)/1000/60;
            document.getElementById("duration").value=duration;
        }else {
            alert("!startTime > endTime");
        }

        websocket.send("web:time+" + start +"/"+ end);

    }

    function pushmessage() {
        var radios = document.getElementById("myform").Fruit;
        console.info(radios);
//通过名字获取  getElementsByName
        for(var i=0;i<radios.length;i++){//循环值得集合
            if(radios[i].checked){//通过checked属性判断是否被选中
                userid = radios[i].value//将被选择的radio的值赋给变量userid
            }
        }

        var text = document.getElementById("myform").Fruit2.value;
        websocket.send("web:message+" + userid +"/"+ text);
//        alert(text)
//        alert(userid)//弹出被选中的radio的值
    }

    //获取实时时间
    function showTime(){
        nowtime=new Date();
        year=nowtime.getFullYear();
        month=nowtime.getMonth()+1;
        date=nowtime.getDate();
        document.getElementById("mytime").innerText=nowtime.toLocaleTimeString();
    }

    setInterval("showTime()",1000);


//获取二维码的信息
function getData() {
    $.ajax({
        type : "get",
        url : "./GetIPServlet",
        dataType : "text",
        data : {
            "ip" : "192.168.0.0.1"
        },
        success : function(Result) {
           /* alert(Result);*/
            qcode(Result);
        },
        error : function(xhr, status, errMsg) {

        }
    });
}
function setScanResult(msg) {
    if (msg != null && msg.length > 0) {
        document.getElementById('scanresult').innerHTML = msg;
    }
}
/*$(function() {
    var url = result;//IP地址
    alert(result);
    var domain = utf16to8(url);
    $("#code").qrcode({
        render : "canvas",
        text : domain,//二维码代表的字符串
        width : 166,//二维码宽度
        height : 166,//二维码高度
        typeNumber : -1,
        correctLevel : 0
    });

})*/

function qcode(result) {
    var url = result;//IP地址
    var domain = utf16to8(url);
    $("#code").qrcode({
        render : "canvas",
        text : domain,//二维码代表的字符串
        width : 166,//二维码宽度
        height : 166,//二维码高度
        typeNumber : -1,
        correctLevel : 0
    });
}

/**
 * 使二维码支持中文
 */
function utf16to8(str) {
    var out, i, len, c;
    out = "";
    len = str.length;
    for (i = 0; i < len; i++) {
        c = str.charCodeAt(i);
        if ((c >= 0x0001) && (c <= 0x007F)) {
            out += str.charAt(i);
        } else if (c > 0x07FF) {
            out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
            out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
        } else {
            out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
            out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
        }
    }
    return out;
}

</script>




