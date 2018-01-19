<?xml version="1.0" encoding="UTF-8"?>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%-- <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%> --%>
 
<!DOCTYPE HTML>
<html>
<head>
<%-- <base href="<%=basePath%>">--%>
<title>My WebSocket</title>  
</head>
<style type="text/css">
.radios {
	width: 30px;
	height: 30px
}

* {
	font-family: 微软雅黑
}
</style>
<body onload="getData()">

	<DIV style="width: 100%; height: 60%">
		<H1 style="text-align: center">Zeiss智能眼镜推送后台</H1>
		<div id="message" style="text-align: center">   </div>
		</br> </br>
		<!-- 计时的布局 -->
		<DIV style="width: 50%; height: 100%; float: left">
			<div
				style="float: left; background #000; width 50%; margin-left: 50px">
				<div id="code"
					style="border: 1px solid #000; width: 167px; height: 167px;" />
			</div>
			<h3 id="scanresult">扫描二维码与智能眼镜连接</h3>
		</div>
		<DIV style="float: right; margin-right: 100px;width 50%">
			<DIV>
				<H2>演讲计时</H2>
			</DIV>
			<SELECT id="begin_hour"
				style="width: 200px; height: 35px; font-size: 13px">
				<OPTION>请选择开始(小时)</OPTION>
				<OPTION>00</OPTION>
				<OPTION>01</OPTION>
				<OPTION>02</OPTION>
				<OPTION>03</OPTION>
				<OPTION>04</OPTION>
				<OPTION>05</OPTION>
				<OPTION>06</OPTION>
				<OPTION>07</OPTION>
				<OPTION>08</OPTION>
				<OPTION>09</OPTION>
				<OPTION>10</OPTION>
				<OPTION>11</OPTION>
				<OPTION>12</OPTION>
				<OPTION>13</OPTION>
				<OPTION>14</OPTION>
				<OPTION>15</OPTION>
				<OPTION>16</OPTION>
				<OPTION>17</OPTION>
				<OPTION>18</OPTION>
				<OPTION>19</OPTION>
				<OPTION>20</OPTION>
				<OPTION>21</OPTION>
				<OPTION>22</OPTION>
				<OPTION>23</OPTION>
			</SELECT> <SELECT id="begin_min"
				style="width: 200px; height: 35px; font-size: 13px">
				<OPTION>请选择开始(分钟)</OPTION>
				<OPTION>00</OPTION>
				<OPTION>01</OPTION>
				<OPTION>02</OPTION>
				<OPTION>03</OPTION>
				<OPTION>04</OPTION>
				<OPTION>05</OPTION>
				<OPTION>06</OPTION>
				<OPTION>07</OPTION>
				<OPTION>08</OPTION>
				<OPTION>09</OPTION>
				<OPTION>10</OPTION>
				<OPTION>11</OPTION>
				<OPTION>12</OPTION>
				<OPTION>13</OPTION>
				<OPTION>14</OPTION>
				<OPTION>15</OPTION>
				<OPTION>16</OPTION>
				<OPTION>17</OPTION>
				<OPTION>18</OPTION>
				<OPTION>19</OPTION>
				<OPTION>20</OPTION>
				<OPTION>21</OPTION>
				<OPTION>22</OPTION>
				<OPTION>23</OPTION>
				<OPTION>24</OPTION>
				<OPTION>25</OPTION>
				<OPTION>26</OPTION>
				<OPTION>27</OPTION>
				<OPTION>28</OPTION>
				<OPTION>29</OPTION>
				<OPTION>30</OPTION>
				<OPTION>31</OPTION>
				<OPTION>32</OPTION>
				<OPTION>33</OPTION>
				<OPTION>34</OPTION>
				<OPTION>35</OPTION>
				<OPTION>36</OPTION>
				<OPTION>37</OPTION>
				<OPTION>38</OPTION>
				<OPTION>39</OPTION>
				<OPTION>40</OPTION>
				<OPTION>41</OPTION>
				<OPTION>42</OPTION>
				<OPTION>43</OPTION>
				<OPTION>44</OPTION>
				<OPTION>45</OPTION>
				<OPTION>46</OPTION>
				<OPTION>47</OPTION>
				<OPTION>48</OPTION>
				<OPTION>49</OPTION>
				<OPTION>50</OPTION>
				<OPTION>51</OPTION>
				<OPTION>52</OPTION>
				<OPTION>53</OPTION>
				<OPTION>54</OPTION>
				<OPTION>55</OPTION>
				<OPTION>56</OPTION>
				<OPTION>57</OPTION>
				<OPTION>58</OPTION>
				<OPTION>59</OPTION>
			</SELECT></br> </br> <SELECT id="end_hour"
				style="width: 200px; height: 35px; font-size: 13px">
				<OPTION>请选择结束(小时)</OPTION>
				<OPTION>00</OPTION>
				<OPTION>01</OPTION>
				<OPTION>02</OPTION>
				<OPTION>03</OPTION>
				<OPTION>04</OPTION>
				<OPTION>05</OPTION>
				<OPTION>06</OPTION>
				<OPTION>07</OPTION>
				<OPTION>08</OPTION>
				<OPTION>09</OPTION>
				<OPTION>10</OPTION>
				<OPTION>11</OPTION>
				<OPTION>12</OPTION>
				<OPTION>13</OPTION>
				<OPTION>14</OPTION>
				<OPTION>15</OPTION>
				<OPTION>16</OPTION>
				<OPTION>17</OPTION>
				<OPTION>18</OPTION>
				<OPTION>19</OPTION>
				<OPTION>20</OPTION>
				<OPTION>21</OPTION>
				<OPTION>22</OPTION>
				<OPTION>23</OPTION>
			</SELECT> <SELECT id="end_min"
				style="width: 200px; height: 35px; font-size: 13px">
				<OPTION>请选择结束(分钟)</OPTION>
				<OPTION>00</OPTION>
				<OPTION>01</OPTION>
				<OPTION>02</OPTION>
				<OPTION>03</OPTION>
				<OPTION>04</OPTION>
				<OPTION>05</OPTION>
				<OPTION>06</OPTION>
				<OPTION>07</OPTION>
				<OPTION>08</OPTION>
				<OPTION>09</OPTION>
				<OPTION>10</OPTION>
				<OPTION>11</OPTION>
				<OPTION>12</OPTION>
				<OPTION>13</OPTION>
				<OPTION>14</OPTION>
				<OPTION>15</OPTION>
				<OPTION>16</OPTION>
				<OPTION>17</OPTION>
				<OPTION>18</OPTION>
				<OPTION>19</OPTION>
				<OPTION>20</OPTION>
				<OPTION>21</OPTION>
				<OPTION>22</OPTION>
				<OPTION>23</OPTION>
				<OPTION>24</OPTION>
				<OPTION>25</OPTION>
				<OPTION>26</OPTION>
				<OPTION>27</OPTION>
				<OPTION>28</OPTION>
				<OPTION>29</OPTION>
				<OPTION>30</OPTION>
				<OPTION>31</OPTION>
				<OPTION>32</OPTION>
				<OPTION>33</OPTION>
				<OPTION>34</OPTION>
				<OPTION>35</OPTION>
				<OPTION>36</OPTION>
				<OPTION>37</OPTION>
				<OPTION>38</OPTION>
				<OPTION>39</OPTION>
				<OPTION>40</OPTION>
				<OPTION>41</OPTION>
				<OPTION>42</OPTION>
				<OPTION>43</OPTION>
				<OPTION>44</OPTION>
				<OPTION>45</OPTION>
				<OPTION>46</OPTION>
				<OPTION>47</OPTION>
				<OPTION>48</OPTION>
				<OPTION>49</OPTION>
				<OPTION>50</OPTION>
				<OPTION>51</OPTION>
				<OPTION>52</OPTION>
				<OPTION>53</OPTION>
				<OPTION>54</OPTION>
				<OPTION>55</OPTION>
				<OPTION>56</OPTION>
				<OPTION>57</OPTION>
				<OPTION>58</OPTION>
				<OPTION>59</OPTION>
			</SELECT></br> </br>
			<BUTTON type="button" onclick="settime()"
				style="width: 100%; height: 45px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
				<FONT color="#FFF">确定设置</FONT>
			</BUTTON>
			</br>
			<!-- 消息推送的布局 -->
			<DIV>
				<H2>消息推送</H2>
			</DIV>
			<TEXTAREA id="text" rows="3" cols="3"
				style="width: 100%; height: 100px"></TEXTAREA>
			</br> </br>
			<DIV>
				<!-- <INPUT type="radio" value="message" class="radios"checked="checked" name="nof"><FONT size="6px"">通知</FONT></INPUT>
					<INPUT type="radio" value="alert" class="radios" name="nof"><FONTsize="6px">提醒</FONT></INPUT>
					<INPUT type="radio" value="warning"class="radios" name="nof"><FONT size="6px">警告</FONT></INPUT> -->
				<H2>消息类型</H2>
				<SELECT id="messagelevel"
					style="width: 100%; height: 35px; font-size: 13px">
					<OPTION>消息</OPTION>
					<OPTION>提醒</OPTION>
					<OPTION>警告</OPTION>
				</SELECT>
			</DIV>
			</br> </br>
			<BUTTON type="button" onclick="pushmessage()"
				style="width: 100%; height: 45px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
				<FONT color="#FFF">推送消息</FONT>
			</BUTTON>
		</DIV>

		</br> </br>
	</DIV>

	<!-- 右边布局 -->
	<DIV style="width: 50%; height: 100%; float: right">
		<div style="width: 100%; margin-left: 100px">
			<DIV>
				<H2>演讲进度控制</H2>
			</DIV>

			<DIV>
				<H3 style="float: left; margin-right: 20p">PPT总页数</H3>
				<input id="totalprogress" type="number"
					style="width: 200px; height: 35px; margin-top: 6px; margin-left: 10px" />
				<!-- <BUTTON id="totalpage_last" onclick="last()"
						style="width: 70px; height: 35px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
						<FONT color="#FFFFFF" >上一页</FONT>
					</BUTTON>
					<BUTTON id="totalpage_next" onclick="next()()"
						style="width: 70px; height: 35px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
						<FONT color="#FFFFFF">下一页</FONT>
					</BUTTON> -->
			</DIV>

			</br>
			<DIV>
				<H3 style="float: left; margin-right: 20p">PPT当前页</H3>
				<input id="currentprogress" type="number"
					style="width: 200px; height: 35px; margin-top: 6px; margin-left: 10px" />
				<BUTTON id="currentpage_last" onclick="currentlast()"
					style="width: 70px; height: 35px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
					<FONT color="#FFFFFF">上一页</FONT>
				</BUTTON>
				<BUTTON id="currentpage_last" onclick="currentnext()"
					style="width: 70px; height: 35px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
					<FONT color="#FFFFFF">下一页</FONT>
				</BUTTON>
			</DIV>
			<!-- 演讲内容 -->
			<DIV>
				<DIV>
					<H2>演讲内容</H2>
				</DIV>
				<TEXTAREA id="content" rows="3" cols="3"
					style="width: 50%; height: 235px"></TEXTAREA>
				</br> </br>
			</DIV>
			</br> </br>
			<button onclick="pushcontent()" type="button"
				style="width: 500px; height: 45px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px">
				<font color="#fff">发送内容</font>
			</button>
			</br> </br> </br>
			<!-- <button onclick="closeWebSocket()"
				style="width: 500px; height: 45px; background: #ED4A4B; border: none; border-radius: 10px; font-size: 18px">
				<font color="#fff">关闭推送</font>
			</button> -->
		</div>
		</br>
	</DIV>
	<div id="message" style="text-align: center">   </div>
	</DIV>
	<!-- <div style="margin: 0 auto;">
		<button onclick="send()" type="button"
			style="width: 55%; height: 45px; font-size: 17px; background: #3388FF; border: none; border-radius: 8px; margin-left: 510px">
			<font color="#fff">发送全部</font>
		</button>
	</div> -->
</body>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
<script src="http://pv.sohu.com/cityjson?ie=utf-8"></script>
<script type="text/JavaScript">
	      var websocket = null;

	//判断当前浏览器是否支持WebSocket
	if ('WebSocket' in window) {
		websocket = new WebSocket("ws://127.0.0.1:8080/webSocket/websocket2");
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
		/*websocket.send("web/this for web connect")*/
	}

	//接收到消息的回调方法
	websocket.onmessage = function() {
		//		setMessageInnerHTML(event.data);
		//      setMessageAttribute(event.data);
		//setScanResult(event.data);
	}

	//连接关闭的回调方法
	websocket.onclose = function() {
		setMessageInnerHTML("已断开连接");
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

	//发送消息
	function send() {
		//消息提醒
		var message = document.getElementById('text').value;
		if (message.length <= 0) {
			message = 'null';
		}
		//开始小时设置
		var begin_hour = document.getElementById('begin_hour').value;
		if (begin_hour == "请选择开始(小时)") {
			begin_hour = '00';
		}
		//开始分钟设置
		var begin_min = document.getElementById('begin_min').value;
		if (begin_min == "请选择开始(分钟)") {
			begin_min = '00';
		}
		//结束小时设置
		var end_hour = document.getElementById('end_hour').value;
		if (end_hour == "请选择结束(小时)") {
			end_hour = '00';
		}
		//结束分钟设置
		var end_min = document.getElementById('end_min').value;
		if (end_min == "请选择结束(分钟)") {
			end_min = '00';
		}
		//PPT内容
		var content = document.getElementById('content').value;
		if (content.length <= 0) {
			content = 'null';
		}
		//PPT总进度
		var totalprogress = document.getElementById('totalprogress').value;
		if (totalprogress <= 0) {
			totalprogress = -1;
		}
		//PPT当前进度
		var currentprogress = document.getElementById('currentprogress').value;
		if (currentprogress <= 0) {
			currentprogress = -1;
		}
		var beign_time = begin_hour + ":" + begin_min;
		var end_time = end_hour + ":" + end_min;
		//获取单选按钮选中值
		var level = document.getElementById('messagelevel').value;
		/*var radio = document.getElementsByName("nof");
		for (var i = 0; i < radio.length; i++) {
			if (radio[i].checked == true) {
				level = radio[i].value;
			}
		} */

		websocket.send("web:all+" + beign_time + "/" + end_time + "@" + level
				+ "&" + message + "#" + totalprogress + "*" + currentprogress
				+ "$" + content);
		//清除当前页面所选填写内容
		/* document.getElementById("text").value = "";
		document.getElementById("content").value = "";
		document.getElementById("totalprogress").value = "";
		document.getElementById("currentprogress").value = "";
		document.getElementById("begin_hour").value = "请选择开始(小时)";
		document.getElementById("begin_min").value = "请选择开始(分钟)";
		document.getElementById("end_hour").value = "请选择结束(小时)";
		document.getElementById("end_min").value = "请选择结束(分钟)";
		document.getElementById("nof").value = "message"; */

	}
	/*
	 *PPT页数推送
	 */
	//上一页
	function currentlast() {
		//PPT总进度
		var totalprogress = document.getElementById('totalprogress').value;
		if (totalprogress <= 0) {
			totalprogress = -1;
		}
		//PPT当前进度
		var currentprogress = document.getElementById('currentprogress').value;
		if (currentprogress <= 0) {
			currentprogress = -1;
		}
		var currentprogress = document.getElementById('currentprogress').value;
		if (currentprogress > 1) {
			currentprogress = Number(currentprogress) + Number(1);
			document.getElementById('currentprogress').value = currentprogress;
		} else {
			currentprogress = -1;
		}
		websocket.send("web:ppt+" + totalprogress + "/" + currentprogress)
	}
	//下一页
	function currentnext() {
		//PPT总进度
		var totalprogress = document.getElementById('totalprogress').value;
		if (totalprogress <= 0) {
			totalprogress = -1;
		}
		//PPT当前进度
		var currentprogress = document.getElementById('currentprogress').value;
		if (currentprogress <= 0) {
			currentprogress = -1;
		}
		var currentprogress = document.getElementById('currentprogress').value;
		if (currentprogress > 1) {
			currentprogress = currentprogress - 1;
			document.getElementById('currentprogress').value = currentprogress;
		} else {
			currentprogress = -1;
		}
		websocket.send("web:ppt+" + totalprogress + "/" + currentprogress)
	}
	//设置时间
	function settime() {
		//开始小时设置
		var begin_hour = document.getElementById('begin_hour').value;
		if (begin_hour == "请选择开始(小时)") {
			begin_hour = '00';
		}
		//开始分钟设置
		var begin_min = document.getElementById('begin_min').value;
		if (begin_min == "请选择开始(分钟)") {
			begin_min = '00';
		}
		//结束小时设置
		var end_hour = document.getElementById('end_hour').value;
		if (end_hour == "请选择结束(小时)") {
			end_hour = '00';
		}
		//结束分钟设置
		var end_min = document.getElementById('end_min').value;
		if (end_min == "请选择结束(分钟)") {
			end_min = '00';
		}
		var beign_time = begin_hour + ":" + begin_min;
		var end_time = end_hour + ":" + end_min;
		websocket.send("web:time+" + beign_time + "/" + end_time);
	}
	//消息推送
	function pushmessage() {
		var message = document.getElementById('text').value;
		if (message.length <= 0) {
			message = 'null';
		}
		var level = document.getElementById('messagelevel').value;
		websocket.send("web:message+" + level + "/" + message);
	}
	//演讲内容推送
	function pushcontent() {
		var content = document.getElementById('content').value;
		if (content.length <= 0) {
			content = 'null';
		}
		websocket.send("web:content+" + content);
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
			width : 166,//二维码宽度
			height : 166,//二维码高度
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
</html>