<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2017/8/31
  Time: 21:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<% ArrayList data = (ArrayList) request.getAttribute("data");out.print(data);%>
<body>

<form>
    <input type="file" id="avatar" name="avatar">
    <button type="">保存</button>
    <div id="responsemsg"></div>

</form>

</body>
<script src="./js/jquery-3.2.1.min.js"></script>

<script type="text/javascript">

    var array = '<%=data%>'

    $('button').click(function(){
        var files = $('#avatar').prop('files');

        var data = new FormData();
        data.append('avatar', files[0]);
        var data1=null;
        $.ajax({
            url: '/webSocket/GetFilePathServlet',
            type: 'POST',
            data: data,
            cache: false,
            processData: false,
            contentType: false,
            success: function(datas){
debugger
                var obj = JSON.parse(datas);

                alert(obj);
  /*              $("#responsemsg").html(datas);
                if(datas.result=='success'){
                    //coding
                    alert(datas.get(0));
                }else{
                    //coding
                    alert(datas.msg);
                }*/
            },
            error: function (data, status, e){
                alert(data);
                //coding
                console.info(data)

                var obj = JSON.parse(data);
                alert(obj);
                alert(data+"/"+status+"/"+e);
            }
        });
    });
    document.getElementById('responsemsg').innerHTML += 11111111 + '<br/>';

</script>
</html>


