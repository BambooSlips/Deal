<%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/5/15
  Time: 上午10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="xyz.moment.here.service.CommodityFilter" %>
<%@ page import="xyz.moment.here.po.Commodity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="xyz.moment.here.service.UserFilter" %>
<%@ page import="xyz.moment.here.po.User" %>
<%@ page import="xyz.moment.here.service.UserLocker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
  <title>用户管理</title>
  <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
  <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">

  <script>
    <%
        if(session.getAttribute("adminname") == null || "".equals(session.getAttribute("adminname"))){
               response.sendRedirect("adminlogin.jsp");
        }
        UserFilter userFilter = new UserFilter();
        List<User> selectedUsers = null;
        try {
            selectedUsers = userFilter.allUsers();} catch (SQLException | ClassNotFoundException throwables) {
            throwables.printStackTrace();
        }
    %>
  </script>
</head>
<body>
<div class="top">
  <img src="./img/DEAL_logo.jpg" class="logo" alt="logo"/>
  <h2 style="margin-top:45px; margin-left:20px; float:left;">用户管理</h2>
  <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
  <div class="sidebar">
    <a href="adminHome.jsp"><div><label>系统概览</label> </div></a>
    <a href="adminProfile.jsp"><div><label>个人信息</label> </div></a>
    <a href="ManageUsers.jsp"><div style="background: #aee2f8;box-shadow:0 1px 10px rgba(0,0,0,0.2);"><label>用户管理</label> </div></a>
    <a href="ManageCommodities.jsp"><div><label>商品管理</label> </div></a>
    <a href="ManageOrders.jsp"><div><label>订单管理</label> </div></a>
    <a href="index.jsp"><div><label>回到首页</label> </div></a>
    <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
  </div>
  <form name="UserForm" method="post">
    <table id="commodity_table" class="table table-bordered table-striped" style="width:100%">
      <thead>
      <tr>
        <th>选择</th><th>用户ID</th><th>用户名</th><th>状态</th><th>手机号码</th><th>默认地址</th><th>注册时间</th><th>用户头像</th>
      </tr>
      </thead>
      <tbody>
      <% for(User user : selectedUsers) {%>
      <tr>
        <td align="center"><input type="checkbox" id="<%=user.getUID()%>" onclick="chooseUser(String('<%=user.getUID()%>'))"></td>
        <td align="center"><%=user.getUID()%></td>
        <td align="center"><%=user.getUsername()%></td>
        <td align="center"><%=user.getStatusString()%></td>
        <td align="center"><%=user.getPhoneNumber()%></td>
        <td align="center"><%=user.getAddress()%></td>
        <td align="center"><%=user.getRegisterTime()%></td>
        <td align="center"><%=user.getPhoto()%></td>
      </tr>
      <%
        }
      %>
      <% if(selectedUsers.size() == 0) {%>
      <tr><%="没有数据！"%></tr>
      <%
        }
      %>
      </tbody>
      <tfoot>
      <tr>
        <th>选择</th><th>用户ID</th><th>用户名</th><th>状态</th><th>手机号码</th><th>默认地址</th><th>注册时间</th><th>用户头像</th>
      </tr>
      </tfoot>
    </table>
  </form>
  <div class="info"  style="border:0">
    <input type="submit" value="锁定用户" id="save" onclick="lockUser()"/>
    <input type="submit" value="解锁用户" id="save" onclick="unlockUser()"/>
    <input type="submit" value="激活用户" id="save" onclick="activateUser()"/>
  </div>
  <script>
      let chosen=[];  //UID
      function chooseUser(userID) {
        //var cost = document.querySelector("#cost");
        let checkbox = document.getElementById(userID);
        if(checkbox.checked === true){
          chosen.push(userID);
          console.log("true")
        }
        else{
          let cancel=[];
          for(let i = 0; i <chosen.length; i++) {
            if(chosen[i] !== userID) {
              console.log(chosen[i]+"!="+ userID+"put it into cancel[]!");
              cancel.push(chosen[i]);
            }
            else
              console.log(chosen[i]+"=="+ userID+"throw it!");
          }
          chosen = cancel;
          console.log("false");
        }
        for(let i = 0; i < chosen.length; i++) {
          //console.log(i)
          console.log("chosen["+i+"]="+chosen[i]);
        }
        /*chosen.push(userID);
        if(checkbox.checked === true){
            console.log("true"+userID);
        }
        else{
          console.log("false"+userID);
        }*/
      }

      function lockUser() {
        console.log(chosen.length);
        console.log(chosen[0])
        for(let i = 0; i < chosen.length; i++) {
          if(chosen[i] != 0) {
            document.UserForm.action="LockUserServlet";
            var opt = document.createElement("textarea");
            opt.name = "chosenUIDs";
            opt.value = chosen.toString();
            opt.style.display = "none";
            document.UserForm.appendChild(opt);
            var c = confirm("确定锁定所选用户？");
            if(c===true){
              document.UserForm.submit();
            }
            console.log("User "+chosen[i]+" is now locked away!");
          }
        }
      }

      function unlockUser() {
        console.log(chosen.length);
        console.log(chosen[0])
        for(let i = 0; i < chosen.length; i++) {
          if(chosen[i] != 0) {
            document.UserForm.action="UnlockUserServlet";
            var opt = document.createElement("textarea");
            opt.name = "chosenUIDs";
            opt.value = chosen.toString();
            opt.style.display = "none";
            document.UserForm.appendChild(opt);
            var c = confirm("确定解锁所选用户？");
            if(c===true){
              document.UserForm.submit();
            }
            console.log("User "+chosen[i]+" is now unlocked!");
          }
        }
      }

      function activateUser() {
        console.log(chosen.length);
        console.log(chosen[0])
        for(let i = 0; i < chosen.length; i++) {
          if(chosen[i] != 0) {
            document.UserForm.action="ActivateUserServlet";
            var opt = document.createElement("textarea");
            opt.name = "chosenUIDs";
            opt.value = chosen.toString();
            opt.style.display = "none";
            document.UserForm.appendChild(opt);
            var c = confirm("确定激活所选用户？");
            if(c===true){
              document.UserForm.submit();
            }
            console.log("User "+chosen[i]+" is now activated!");
          }
        }
      }

  </script>
</div>
<br>
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
  </br>
  <div class="copyright">
    Copyright&copy;2000-2020&nbsp;&nbsp;众神消亡&nbsp;版权所有
  </div>
</div>
</body>
<script src="js/jquery.min.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>

<script>

  //DataTable control
  $(document).ready(function() {
    $('#commodity_table').DataTable(
            {
              "paging": true,       <!-- 允许分页 -->
              "lengthChange": true, <!-- 允许改变每页显示的行数 -->
              "searching": true,    <!-- 允许内容搜索 -->
              "ordering": true,     <!-- 允许排序 -->
              "info": true,         <!-- 显示信息 -->
              "autoWidth": false,   <!-- 固定宽度 -->
              "selected": true
            }
    );
  } );

</script>
</html>


