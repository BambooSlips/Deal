
<%@ page import="xyz.moment.here.po.Admin" %>
<%@ page import="xyz.moment.here.dao.AdminDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/5/3
  Time: 下午12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理</title>
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
    <script>
        <%
            Admin admin = new Admin();
            if(session.getAttribute("adminname") != null && !"".equals(session.getAttribute("adminname"))){
                admin.setAdminname(session.getAttribute("adminname").toString());
            }
            else
                response.sendRedirect("adminlogin.jsp");
            if(session.getAttribute("key") != null && !"".equals(session.getAttribute("key"))) {
                admin.setPassword(session.getAttribute("key").toString());
            }
            if (session.getAttribute("lastLogin") != null && !"".equals(session.getAttribute("lastLogin"))) {

                admin.setLastLogin((Date) session.getAttribute("lastLogin"));
                System.out.println("got a date:"+(Date) session.getAttribute("lastLogin"));
        %>
        <c:set var="admin" scope="application" value="<%= admin%>"></c:set>
        <%
            }
        %>
        function checkPasswordInput(){
            var password = document.querySelector("#password1");
            var comfirm = document.querySelector("#password2");
            var tip = document.querySelector("#tip");
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
</head>
<body>
<div class="top">
    <img src="./img/DEAL_logo.jpg" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">我的个人信息</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="adminHome.jsp"><div><label>系统概览</label> </div></a>
        <a href="adminProfile.jsp"><div style="background: #aee2f8;box-shadow:0px 1px 10px rgba(0,0,0,0.2);"><label>个人信息</label> </div></a>
        <a href="ManageUsers.jsp"><div><label>用户管理</label> </div></a>
        <a href="ManageCommodities.jsp"><div><label>商品管理</label> </div></a>
        <a href="ManageOrders.jsp"><div><label>订单管理</label> </div></a>
        <a href="index.jsp"><div><label>回到首页</label> </div></a>
        <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
    </div>
    <form action="./myself.jsp" method="post">
        <%--<div class="info">
            <label>手机号码：<input type="text" name="phone"  placeholder="手机号码" value="${applicationScope.me.phoneNumber}"></label>
        </div>--%>
        <br>
        <div class="info">
            <label>用户名：<input type="text" name="adminname"  placeholder="用户名" value="${admin.adminname}"></label>
        </div>
        <br>
        <div class="info">
            <label>密码：<input type="password" name="oldPassword" id="password1" placeholder="密码" value="${admin.password}"></label>
        </div>
        <br>
        <div class="info">
            <label>新密码：
                <input type="password" id="password2" name="newPassword" placeholder="确认新密码" value="" onblur="checkPasswordInput()">
            </label>
            <span id="tip"></span>
        </div>
        <br>
        <div class="info">
            <label >上次登录时间：
                <label style="position: relative; left: 75px">${admin.lastLogin}</label>
            </label>
        </div>
        <br>
        <%--<div class="info">
            <label>收货地址：<textarea name="address" rows="5" cols="50">${applicationScope.me.address}</textarea></label>
        </div>--%>
        <br>
        <div class="info"  style="border:0">
            <input type="submit" value="保存修改" id="save" onclick="alter()"/>
        </div>
    </form>
    <script>
        function alter() {
            var tip = document.querySelector("#tip");
            <%
                request.setCharacterEncoding("utf-8");
                String username=null, password=null, lastLogin=null;
                //Admin admin = new Admin();
                String AID = session.getAttribute("AID").toString();
                admin.setAID(AID);
                if(request.getParameter("adminname")!=null && !"".equals(request.getParameter("adminname"))){
                    username = request.getParameter("adminname");
                    admin.setAdminname(username);
                    session.setAttribute("admin",username);
                }
                if(request.getParameter("oldPassword")!=null && !"".equals(request.getParameter("oldPassword"))){
                    password = request.getParameter("oldPassword");
                    admin.setPassword(password);
                    session.setAttribute("key",password);
                }
                if(request.getParameter("newPassword")!=null && !"".equals(request.getParameter("newPassword"))){
                    password = request.getParameter("newPassword");
                    admin.setPassword(password);
                    session.setAttribute("key",password);
                }
                /*if(request.getParameter("birthday")!=null && !"".equals(request.getParameter("birthday"))){
                    birthday = request.getParameter("birthday");
                    me.setBirthday(birthday);
                    session.setAttribute("birthday",birthday);
                }*/
                /*if(request.getParameter("address")!=null && !"".equals(request.getParameter("address"))){
                    address = request.getParameter("address");
                    me.setAddress(address);
                    session.setAttribute("address",address);
                }
                if(request.getParameter("phone")!=null && !"".equals(request.getParameter("phone"))){
                    phone = request.getParameter("phone");
                    me.setPhoneNumber(phone);
                    session.setAttribute("phone",phone);
                }*/

                try {
                    if(!"".equals(username) && username != null){
                        System.out.println(AID+username+password);
                        AdminDAO.alterAdmin(admin);
            %>
            <c:set var="admin" scope="application" value="<%= admin%>"></c:set>
            <%
                    }
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                }

            %>
            //location.reload();  //刷新页面
            alter("修改成功！");
        }
    </script>
</div>
<br>
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
</body>
<script>

</script>
</html>

