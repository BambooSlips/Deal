<%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/5/2
  Time: 下午4:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理后台</title>
    <link rel="stylesheet" type="text/css" href="css/adminLoginStyle.css">
    <style>

    </style>

</head>
<body>
<div class="top">
    <img src="./img/logo.png" class="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">欢迎登录</h2>
    <a class="port" href="./login.jsp">调查问卷></a>
</div>
<div class="center">
    <div class="box">
        <!-- 登录表单 -->
        <form action="AdminLoginServlet" method="post">
            <div class="divU">
                <h4 style="position:absolute; bottom:2px; left:50px;">密码登录</h4>
            </div>

            <img src="./img/usr.png" id = "uimg"/>
            <p id="message"></p><br>
            <input type="text" name="username" class="account" placeholder="邮箱/用户名/手机号" id="username"/>
            <img src="./img/lock.png" id="limg"/>
            <input type="password" name="password" class="password" placeholder="密码" id="password"/>
            <input type="text" name ="checkname" class="check" placeholder="验证码">
            <img name="code" src="VerificationCodeServlet" class = "ccode" onclick="freshVerificationCode()"/><br>
            <a href="https://www.baidu.com" id="tip" target="blank">忘记密码</a>
            <input type="submit" name="login" class="login" value="登  录" onclick=""/>
            <div class="divD">
                <img id="QQimg" src="./img/QQimg.png"/>
                <img id="weixinImg" src="./img/weixinImg.png"/>
                <a href="./register.jsp" style="text-decoration:none; position:absolute; right:20px; top:6px; font-size:6px;" target="_blank">免费注册</a>
            </div>
        </form>
        <script>
            function freshVerificationCode(){
                document.code.src="VerificationCodeServlet?id="+Math.random();
            }
        </script>
    </div>
</div>
<div class="bottom">
    <div class="links">
        <a class="addition" href="./login.jsp" target="_blank">关于我们&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">联系我们&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">人才招聘&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">商家入驻&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">广告服务&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">手机京东&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">友情链接&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">销售联盟&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">京东社区&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">京东公益&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">English Site</a>
    </div>
    <br>
    <div class="copyright">
        Copyright&copy;2000-2020&nbsp;&nbsp;众神消亡&nbsp;版权所有
    </div>
</div>
<script>
    <%
        //判断登录信息是否正确
        if(session.getAttribute("goAhead") != null){
            String goAhead = session.getAttribute("goAhead").toString();
            if("false1".equals(goAhead)){
                System.out.println("false1!!!!!!!");
    %>
    var message = document.querySelector("#message");
    message.innerHTML = "验证码错误！";
    <%
        }
            else if("false2".equals(goAhead)){
                System.out.println("false2!!!!!!!");
    %>
    var message = document.querySelector("#message");
    message.innerHTML = "用户名或密码错误！";
    <%
            }
        }

        //根据session自动填写用户名与密码
        if(session.getAttribute("username") != null){
            String username = session.getAttribute("username").toString();
    %>
    var username = document.querySelector("#username");
    username.value = "<%= username%>"
    <%
        }

        if(session.getAttribute("password") != null){
            String password = session.getAttribute("password").toString();
    %>
    var password = document.querySelector("#password");
    password.value = "<%= password%>"
    <%
        }
    %>
</script>
</body>
</html>

