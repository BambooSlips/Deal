
<%@ page import="java.util.List" %>

<%@ page import="java.sql.SQLException" %>
<%@ page import="xyz.moment.here.po.OrderForm" %>
<%@ page import="xyz.moment.here.dao.OrderFormDAO" %>
<%@ page import="xyz.moment.here.po.OrderItem" %>
<%@ page import="xyz.moment.here.dao.OrderItemDAO" %><%--
  Created by IntelliJ IDEA.
  User: 众神消亡
  Date: 2020/12/22
  Time: 22:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的</title>
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <script>
        <%
        //检测是否已登录
        if(session.getAttribute("UID")!=null){
            //response.sendRedirect("myself.jsp");
        }
        else {
            response.sendRedirect("login.jsp");
        }

        List<OrderForm> myOrders = null;
        try {
            myOrders = OrderFormDAO.queryAllUserOrders(session.getAttribute("UID").toString());}
        catch (SQLException | ClassNotFoundException throwables) {
            throwables.printStackTrace();
        }
        if(myOrders != null)
            System.out.println("myOrders---> " + myOrders.size());

    %>
        <c:set var="myOrders" scope="application" value="<%= myOrders%>"/>
    </script>
</head>
<body>
<div class="top">
    <img src="./img/logo.png" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">我的</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="myself.jsp"><div><label>个人信息</label></div></a>
        <a href="cart.jsp"><div><label>我的购物车</label></div></a>
        <a href="order.jsp"><div style="background: #aee2f8;box-shadow:0px 1px 10px rgba(0,0,0,0.2);"><label>我的订单</label> </div></a>
        <a href="index.jsp"><div><label>回到首页</label> </div></a>
        <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
    </div>
    <form>
        <%--<table border="1">
            <tr style="background-color:#aee2f8;">
                <th>商品名称</th><th>数量</th><th>成交时间</th><th>总价</th>
            </tr>

            <c:forEach var="order" items="${applicationScope.myOrders}" varStatus="status">
                <tr <c:if test="${status.index % 2 == 1 }">style="background-color:rgb(247,249,252);"</c:if> >
                    <td>${order.OID}</td>
                    <td align="center">${order.createdTime}</td>
                    <td>${order.totalPrice}</td>
                    <td align="center">${order.phoneNumber}</td>
                </tr>
            </c:forEach>
        </table>--%>
            <table id="order_table" class="table table-bordered table-striped" style="width:100%">
                <thead>
                <tr>
                    <th>选择</th><th>订单号</th><th>商品名称</th><th>成交日期</th><th>数量</th><th>总价</th>
                </tr>
                </thead>
                <tbody>
                <% for(OrderForm orderForm : myOrders) {
                    OrderItem orderItem = new OrderItem();
                    try {
                        orderItem = OrderItemDAO.queryItem(orderForm.getOID());
                    } catch (SQLException | ClassNotFoundException throwables) {
                        throwables.printStackTrace();
                    }
                %>
                <tr>
                    <td align="center">
                        <input type="checkbox"
                               name="<%=orderForm.getOID()%>"
                               id="<%=orderForm.getOID()%>"
                               onclick=""
                        />
                    </td>
                    <td align="center"><%=orderForm.getOID()%></td>
                    <td align="center"><%=orderItem.getName()%></td>
                    <td align="center"><%=orderForm.getCreatedTime()%></td>
                    <td align="center"><%=orderItem.getNumber()%></td>
                    <td align="center"><%=orderForm.getTotalPrice()%></td>
                </tr>
                <%
                    }
                %>
                <% if(myOrders.size() == 0) {%>
                <tr><%="没有数据！"%></tr>
                <%
                    }
                %>
                </tbody>
                <tfoot>
                <tr>
                    <th>选择</th><th>订单号</th><th>商品名称</th><th>成交日期</th><th>数量</th><th>总价</th>
                </tr>
                </tfoot>
            </table>
    </form>
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
<script src="js/jquery.min.js"></script>
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
<script>

    //DataTable control
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

