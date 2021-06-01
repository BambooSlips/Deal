<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: 众神消亡
  Date: 2020/12/17
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="css/registerStyle.css">
    <style>

    </style>
</head>
<body>
<div class="top">
    <img src="./img/logo.png" class="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">注册账号</h2>
    <a class="port" href="./login.jsp">已有账号？&nbsp;&nbsp;请登录></a>
</div>
</br></br>
<div class="main">
    <a class="research">
        调查问卷
    </a>
    <form action="RegisterServlet" method="post">
        <a class="help" href="./login.html" target="_blank">
            <img src="./img/consult.png"/>
        </a>
        <div class="item1">
            <label>中国+86</label>
            <input type="text" name="phone" id="phone" placeholder="   请填写常用手机号">
        </div>
        <p id="message3" style="position: relative; top:75px; left:50px; color: red"></p><br>
        <div class="item2">
            <label>用户名</label>
            <input type="text" name="username" id="username" placeholder="   您的账户名和登录名"/>
        </div>
        <!--
        <p id="message1" style="position: relative; top:120px; left:30px; color: red"></p><br>
        -->
        <div class="item3">
            <label>设置密码</label>
            <input type="password" name="password" id="password" placeholder="   建议使用两种或两种以上字符组合"/>
        </div>
        <div class="item4">
            <label>确认密码</label>
            <input type="password" name="password2" id="password2" placeholder="   确认密码" onblur="checkPasswordInput()"/>
        </div>
        <p id="message2" style="position: relative; top:275px; left:50px; color: red"></p><br>
        <div class="item5">
            <label><img name="code" src="VerificationCodeServlet" style="width: 100%; position: relative;top:5px;"/> </label>
            <input type="text" name="key" id="key" placeholder="   输入验证码"/>
            <input type="button" id="getKey" value="刷新验证码" onclick="freshVerificationCode()"/>
        </div>

        <div class="item6">
            <input type="checkbox" id="agreement"/>
            <p id="p1">我已阅读并同意
                <a href="https:www.baidu.com" target="_blank" style="text-decoration:none;">《用户协议》</a>
            </p>
        </div>
        <div class="item7">
            <input type="submit" value="立 即 注 册"id="register" name="register"/>
        </div>
    </form>
    <script>
        function freshVerificationCode(){
            document.code.src="VerificationCodeServlet?id="+Math.random();
        }

        /*----------------------------------------------------------------------*/
        //var r1=/^[a-zA-Z]\w{5,19}$/;
        //var r2=/^[a-zA-Z]\w{5,14}$/;
        var r3=/^1[345789]\d{9}$/;

        var c1=document.querySelector("#username");
        var c2=document.querySelector("#password");
        var c21 = document.password2;
        var c3=document.querySelector("#phone");
        var s1=document.querySelector("#message1");
        var s2=document.querySelector("#message2");
        var s3=document.querySelector("#message3");

        c3.onblur=function(){
            if(r3.test(c3.value))
            {
                s3.innerHTML="手机号输入正确";
            }
            else
            {
                s3.innerHTML="手机号输入错误";
            }
        }

        function checkPasswordInput(){
            var password = document.querySelector("#password");
            var comfirm = document.querySelector("#password2");
            var tip = document.querySelector("#message2");
            if(password.value === comfirm.value)
            {
                //console.log(password.value + "--Right!--" +comfirm.value);
                comfirm.style.border = "1px black solid";
                tip.innerHTML = "";
            }
            else {
                //console.log(password.value + "--Wrong!--"+comfirm.value);
                tip.innerHTML = "两次密码输入不同！";
                comfirm.value = "";
                comfirm.style.border = "3px red solid";
            }
        }
    </script>
</div>
<div class="bottom">
    <div class="links">
        <a class="addition" href="./login.jsp" target="_blank">关于我们&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">联系我们&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.jsp" target="_blank">人才招聘&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">商家入驻&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">广告服务&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">手机京东&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">友情链接&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">销售联盟&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">京东社区&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">京东公益&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;</a>
        <a class="addition" href="./login.html" target="_blank">English Site</a>
    </div>
    </br>
    <div class="copyright">
        Copyright&copy;2000-2020&nbsp;&nbsp;众神消亡&nbsp;版权所有
    </div>
</div>
<script>
    <%
        if(session.getAttribute("goAhead") != null){
            String goAhead = session.getAttribute("goAhead").toString();
            if("false1".equals(goAhead)){
                System.out.println("false1!!!!!!!");
    %>
                var message = document.querySelector("#message");
                message.innerHTML = "验证码错误！";
    <%
            }
        }
    %>
</script>
</body>
</html>

