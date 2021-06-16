<%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/5/16
  Time: 下午4:37
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="xyz.moment.here.po.Admin" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>
<%@ page import="xyz.moment.here.service.OrderFilter" %>
<%@ page import="xyz.moment.here.po.OrderForm" %>
<%@ page import="java.util.List" %>
<%@ page import="xyz.moment.here.po.OrderItem" %>
<%@ page import="xyz.moment.here.dao.OrderItemDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理订单</title>
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
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

        <%
            OrderFilter orderFilter = new OrderFilter();
            List<OrderForm> selectedOrders = orderFilter.allOrders();
        %>
    </script>
</head>
<body>
<div class="top">
    <img src="./img/DEAL_logo.jpg" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">管理>订单管理</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="adminHome.jsp"><div><label>系统概览</label> </div></a>
        <a href="adminProfile.jsp"><div><label>个人信息</label> </div></a>
        <a href="ManageUsers.jsp"><div><label>用户管理</label> </div></a>
        <a href="ManageCommodities.jsp"><div><label>商品管理</label> </div></a>
        <a href="ManageOrders.jsp"><div style="background: #aee2f8;box-shadow:0px 1px 10px rgba(0,0,0,0.2);"><label>订单管理</label> </div></a>
        <a href="index.jsp"><div><label>回到首页</label> </div></a>
        <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
    </div>
    <form name="OrderTable" method="post">
        <table id="order_table" class="table table-bordered table-striped" style="width:100%">
            <thead>
            <tr>
                <th>选择</th><th>订单号</th><th>用户名</th><th>商品名</th><th>件数</th><th>总价格</th><th>手机号码</th><th>目的地址</th><th>购买时间</th>
            </tr>
            </thead>
            <tbody>
            <% for(OrderForm orderForm : selectedOrders) {
                OrderItem orderItem = new OrderItem();
                try {
                    orderItem = OrderItemDAO.queryItem(orderForm.getOID());
                } catch (SQLException | ClassNotFoundException throwables) {
                    throwables.printStackTrace();
                }
            %>
            <tr>
                <td align="center"><input type="checkbox" id="<%=orderForm.getUID()%>" onclick="chooseUser(String('<%=orderForm.getUID()%>'))"></td>
                <td align="center"><%=orderForm.getOID()%></td>
                <td align="center"><%=orderForm.getUsername()%></td>
                <td align="center"><%=orderItem.getName()%></td>
                <td align="center"><%=orderItem.getNumber()%></td>
                <td align="center"><%=orderForm.getTotalPrice()%></td>
                <td align="center"><%=orderForm.getPhoneNumber()%></td>
                <td align="center"><%=orderForm.getAddress()%></td>
                <td align="center"><%=orderForm.getCreatedTime()%></td>
            </tr>
            <%
                }
            %>
            <% if(selectedOrders.size() == 0) {%>
                <tr><%="没有数据！"%></tr>
            <%
                }
            %>
            </tbody>
            <tfoot>
            <tr>
                <th>选择</th><th>订单号</th><th>用户名</th><th>商品名</th><th>件数</th><th>总价格</th><th>手机号码</th><th>目的地址</th><th>购买时间</th>
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
    $(document).ready(function() {
        $('#order_table').DataTable(
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

