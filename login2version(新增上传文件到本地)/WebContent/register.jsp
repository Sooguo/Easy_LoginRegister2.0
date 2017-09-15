<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/common_form.css">
<script type="text/javascript" src="js/jquery-3.1.1.min.js"></script>
<script src="js/common_form_test.js"></script>
<title>注册界面</title>
</head>

<body>
    <header>
        <div class="header-line"></div>
    </header>
<div class="content">
    <img class="content-logo" src="img/form_logo.png" alt="logo">
	<h1 class="content-title">创建账户</h1>
	<div class="content-form">
<form id="form2" method="post" action="" onsubmit="return submitTest()">	
	<div id="change_margin_0">
           <input class="user" id="add_userId" type="text" name="userId" placeholder="请输入编号" onblur="oBlur_0()" onfocus="oFocus_0()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_0"></p>
    
	<div id="change_margin_1">
           <input class="user" id="add_userName" type="text" name="userName" placeholder="请输入用户名" onblur="oBlur_1()" onfocus="oFocus_1()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_1"></p>
    
    <div id="change_margin_2">
         <input class="password" id="add_password" type="password" name="password" placeholder="请输入密码" onblur="oBlur_2()" onfocus="oFocus_2()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_2"></p>
    
    <div id="change_margin_3">
         <input class="user" id="add_email" type="text" name="email" placeholder="请输入电子邮箱" onblur="oBlur_3()" onfocus="oFocus_3()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_3"></p>
    
    <div id="change_margin_4">
         <input class="user" id=add_registerTime type="text" name="registerTime" placeholder="请输入注册时间" onblur="oBlur_4()" onfocus="oFocus_4()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_4"></p>
    
	<div id="change_margin_5">
        <input id="submitBtn" class="content-form-signup" type="submit" value="创建账户">
    </div>
 </form>
   </div>
   <div class="content-login-description">已经拥有账户？</div>
   <div><a class="content-login-link" href="login.jsp">登录</a></div>
</div>

  <script type="text/javascript">
		$(function(){
			$("#submitBtn").click(function(){
				$.ajax({
				   type: "POST",
				   url: "<%=request.getContextPath() %>/RegisterServlet?oprateType=register",
				   data: {	  
					   "userId":$("#add_userId").val(),
					   "userName":$("#add_userName").val(),
					   "password":$("#add_password").val(),
					   "email":$("#add_email").val(),
				       "registerTime":$("#add_registerTime").val(),
				   },
				   dataType: "json",                             //请求页面返回的数据类型 
				   success: function(data){
				     if(data.message=="no"){
				    	 $.messager.alert('提示信息','添加用户失败!','info');
				     }else{
				    	 $.messager.alert('提示信息','添加用户成功!','info');
				    	 $('#win').window("close"); 
				    	 $("#searchBtn").click();
				     }
				   }
				});
			});
		});
	</script>
</body>
</html>






       

