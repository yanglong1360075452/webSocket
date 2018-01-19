<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>测试jquery</title>
</head>
<body>
	<input type="file" id="id_file" name="name_file"/>
	<button type="button" onclick="upload(this)">上传</button></br>
	<div id="responsemsg"></div>
</body>
<script src="./js/jquery-3.2.1.min.js"></script>
<script src="./js/jquery.ajaxfileupload.js"></script>
<!-- <script src="./js/jquery-3.2.1.js"></script> -->


<script type="text/javascript">
    var data;
	function upload(){

	    console.info("开始")
		$.ajaxFileUpload({
		    type: "POST",  
		    url: "/webSocket/GetFilePathServlet",
		    data:"",//要传到后台的参数，没有可以不写  
		    secureuri : false,//是否启用安全提交，默认为false  
		    fileElementId:'id_file',//文件选择框的id属性  
		    dataType: 'text',//服务器返回的格式
		    async : false,
		    success: function(data){
		        console.info("服务器返回的格式")
		    	alert(data);
		        this.data=data;
		        if(data.result=='success'){  
		            //coding  
		            alert(data.msg);
		        }else{  
		            //coding  
		        	alert(data.msg);
		        }  
		    },  
		    error: function (data, status, e){  
		        //coding  
		        alert(data+"/"+status+"/"+e);
		    }  
		});  
	}
</script>
</html>