<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2017/11/17
  Time: 16:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>qrcode</title>
</head>
<body onload="getData()">

<DIV style="text-align: center">
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
</DIV>

</body>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
<script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>
<script type="text/JavaScript">


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
        setMessageInnerHTML("已自动连接");
        websocket.send("web/this for web connect")
    }

    //接收到消息的回调方法
    websocket.onmessage = function(event) {
        if (event.data != null){
            window.location="newIndex.jsp";

        }

        //		setMessageInnerHTML(event.data);
        //      setMessageAttribute(event.data);
        //setScanResult(event.data);
    }

    //连接关闭的回调方法
  /*  websocket.onclose = function() {
        setMessageInnerHTML("已断开连接");
    }*/

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
    $(function() {
        var url = result;//IP地址
        var domain = utf16to8(url);
        $("#code").qrcode({
            render : "canvas",
            text : domain,//二维码代表的字符串

            typeNumber : -1,
            correctLevel : 0
        });

    })
    function qcode(result) {
        var url = result;//IP地址
        var domain = utf16to8(url);
        $("#code").qrcode({
            render : "canvas",
            text : domain,//二维码代表的字符串

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
</html>
