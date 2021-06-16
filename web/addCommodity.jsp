<%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/5/6
  Time: 下午3:53
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="xyz.moment.here.po.Admin" %>
<%@ page import="xyz.moment.here.dao.AdminDAO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>
<%@ page import="xyz.moment.here.dao.CommodityTypeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="xyz.moment.here.po.CommodityType" %>
<%@ page import="xyz.moment.here.dao.CommodityDAO" %><%--
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
    <title>增加商品</title>
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
    <link rel="stylesheet" type="text/css" href="css/addCommodityStyle.css">
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
            List<CommodityType> types = CommodityTypeDAO.getAllTypes();
        %>
    </script>
</head>
<body>
<div class="top">
    <img src="./img/DEAL_logo.jpg" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">增加商品</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="adminHome.jsp"><div><label>系统概览</label> </div></a>
        <a href="adminProfile.jsp"><div><label>个人信息</label> </div></a>
        <a href="cart.jsp"><div><label>用户管理</label> </div></a>
        <a href="order.jsp"><div style="background: #aee2f8;box-shadow:0px 1px 10px rgba(0,0,0,0.2);"><label>商品管理</label> </div></a>
        <a href="ManageOrders.jsp"><div><label>订单管理</label> </div></a>
        <a href="index.jsp"><div><label>回到首页</label> </div></a>
        <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
    </div>
    <form action="./addCommodity.jsp" method="post">
        <%--<div class="info">
            <label>手机号码：<input type="text" name="phone"  placeholder="手机号码" value="${applicationScope.me.phoneNumber}"></label>
        </div>--%>
        <br>
        <div class="info">
            <label>商品名：<input type="text" name="commodityName"  placeholder="商品名" ></label>
        </div>
        <br>
        <div class="info">
            <label>类型：
                <%--<input type="text" name="commodityType" id="password1" placeholder="商品类型">--%>
                <select name="type">
                    <%--<option value="1">类型</option>--%>
                    <%
                        for(CommodityType type : types) {
                    %>
                            <option value="<%=type.getTID()%>"><%=type.getTypeName()%></option>
                    <%
                        }
                    %>
                </select>
            </label>
        </div>
        <br>
        <div class="info">
            <label>价格：
                <input type="text" id="price" name="commodityPrice" placeholder="商品价格">
            </label>
            <span id="tip"></span>
        </div>
        <br>
        <div class="info">
            <label >库存量：
                <input type="text" id="inventory" name="inventory" placeholder="库存量">
            </label>
        </div>
        <br>
        <div class="info">
            <label >状态：
                <select name="status">
                    <option value="1">在售</option>
                    <option value="0">已下架</option>
                    <option value="-1">已删除</option>
                </select>
            </label>
        </div>
        <br>
        <div class="info">
            <label >描述：
                <input type="text" id="description" name="description" placeholder="描述">
            </label>
        </div>
        <br>
        <div class="info">
            <label >图片：
                <input type="text" id="photo" name="photo" placeholder="图片">
            </label>
        </div>
        <br>
        <%--<div class="info">
            <label>收货地址：<textarea name="address" rows="5" cols="50">${applicationScope.me.address}</textarea></label>
        </div>--%>
        <br>
        <div class="info"  style="border:0">
            <input type="submit" value="提交" id="save" onclick="add()"/>
        </div>
    </form>
    <script>
        function add() {
            <%
                request.setCharacterEncoding("utf-8");
                if(request.getParameter("type") != null) {
                    int type = Integer.parseInt(request.getParameter("type"));
                    String name = request.getParameter("commodityName");
                    float price = Float.parseFloat(request.getParameter("commodityPrice"));
                    int inventory = Integer.parseInt(request.getParameter("inventory"));
                    String description = request.getParameter("description");
                    String photo = request.getParameter("photo");
                    int status = Integer.parseInt(request.getParameter("status"));

                    try {
                        CommodityDAO.addCommodity(type,name,price,inventory,description,photo,status);} catch (SQLException | ClassNotFoundException throwables) {
                        throwables.printStackTrace();
                    }
                }
            %>
            //location.reload();  //刷新页面
            alter("提交成功！");
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


