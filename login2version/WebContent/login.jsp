<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/common_form.css">
<script src="js/common_form_test.js"></script>
<title>登陆界面</title>
</head>
<body>
    <header>
        <div class="header-line"></div>
    </header>
<!-- 当前的数据通过POST方法传递！ 在服务器端可以用response.post来获取数据 -->
<!-- 提交表单后，会跳转到LoginServlet类 -->
<div class="content">
       <img class="content-logo" src="img/form_logo.png" alt="logo">
       <h1 class="content-title">登录</h1>
       <div class="content-form">
    <form id="form1" name="form1" method="post" action="LoginServlet" onsubmit="return submitTest()">
	<div id="change_margin_1">
    <input class="user" type="text" id="userName" name="userName" placeholder="请输入用户名" onblur="oBlur_1()" onfocus="oFocus_1()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_1"></p>
    
	<div id="change_margin_2">
    <input class="password" id="password" type="password" name="password" placeholder="请输入密码" onblur="oBlur_2()" onfocus="oFocus_2()">
    </div>
    <!-- input的value为空时弹出提醒 -->
    <p id="remind_2"></p>
    <div id="change_margin_3">
       <input class="content-form-signup" type="submit" value="登录">
    </div>
	${error}
    </form>	
  </div>
        <div class="content-login-description">没有账户？</div>
        <div><a class="content-login-link" href="register.jsp">注册</a></div>
</div>
</body>
</html>