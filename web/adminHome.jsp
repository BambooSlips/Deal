
<%@ page import="xyz.moment.here.po.Admin" %>
<%@ page import="xyz.moment.here.dao.AdminDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>
<%@ page import="xyz.moment.here.service.UserFilter" %>
<%@ page import="xyz.moment.here.service.CommodityFilter" %>
<%@ page import="xyz.moment.here.dao.CommodityTypeDAO" %><%--
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

        <%
            UserFilter uf = new UserFilter();
            int totalNumber = 0;
            int normalNumber = 0;
            int lockedNumber = 0;
            int inactiveNumber = 0;
            try {
                totalNumber = uf.allUsers().size();
                normalNumber = uf.normalUsers().size();
                lockedNumber = uf.lockedUsers().size();
                inactiveNumber = uf.inactiveUsers().size();
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }

            CommodityFilter commodityFilter = new CommodityFilter();
            int totalCommodities = 0;
            float totalIncome = 0;
            int totalTypes = 0;
            int totalInventory = 0;
            int totalViewdTime = 0;
            int onSale = 0;
            int discontinued = 0;
            int deleted = 0;

            try {
                totalCommodities = commodityFilter.allCommodities().size();
                totalIncome = commodityFilter.totalPrice();
                totalTypes = CommodityTypeDAO.getAllTypes().size();
                totalInventory = commodityFilter.totalInventory();
                totalViewdTime = commodityFilter.totalViewTime();
                onSale = commodityFilter.onSale().size();
                discontinued = commodityFilter.discontinuued().size();
                deleted = commodityFilter.deleted().size();
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }

        %>
    </script>
</head>
<body>
<div class="top">
    <img src="./img/logo.png" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">我的个人信息</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="adminHome.jsp"><div style="background: #aee2f8;box-shadow:0px 1px 10px rgba(0,0,0,0.2);"><label>系统概览</label> </div></a>
        <a href="adminProfile.jsp"><div><label>个人信息</label> </div></a>
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
            <label>用户：<br>
                <label>总用户：<%=totalNumber%></label><br>
                <label>正常用户：<%=normalNumber%></label><br>
                <label>锁定用户：<%=lockedNumber%></label><br>
                <label>未激活用户：<%=inactiveNumber%></label><br>
            </label>
        </div>
        <br>
        <div class="info">
            <label>商品：<br>
                <label>总商品：<%=totalCommodities%></label><br>
                <label>总商品浏览量：<%=totalViewdTime%></label><br>
                <label>总商品库存：<%=totalInventory%></label><br>
                <label>商品预计总收入：<%=totalIncome%></label><br>
                <label>商品类型：<%=totalTypes%></label><br>
                <label>上架商品：<%=onSale%></label><br>
                <label>下架商品：<%=discontinued%></label><br>
                <label>已删除商品：<%=deleted%></label><br>
            </label>
        </div>
        <br>
        <div class="info">
            <label>订单：

            </label>
            <span id="tip"></span>
        </div>
        <br>
        <%--<div class="info">
            <label >上次登录时间：
                <label style="position: relative; left: 75px">${admin.lastLogin}</label>
            </label>
        </div>
        <br>--%>
        <%--<div class="info">
            <label>收货地址：<textarea name="address" rows="5" cols="50">${applicationScope.me.address}</textarea></label>
        </div>--%>
        <br>
        <div class="info"  style="border:0">
            <input type="submit" value="保存修改" id="save" onclick="alter()"/>
        </div>
    </form>
    <script>

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

