<%@ page import="xyz.moment.here.service.CommodityFilter" %>
<%@ page import="xyz.moment.here.po.Commodity" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>管理</title>
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">

    <script>
        <%
            if(session.getAttribute("adminname") == null || "".equals(session.getAttribute("adminname"))){
               response.sendRedirect("adminlogin.jsp");
            }

            CommodityFilter cf = new CommodityFilter();
            List<Commodity> selectedCommodities = null;
            try {
                selectedCommodities = cf.allCommodities();
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }
        %>
    </script>
</head>
<body>
<div class="top">
    <img src="./img/logo.png" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">商品管理</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="adminHome.jsp"><div><label>系统概览</label> </div></a>
        <a href="adminProfile.jsp"><div><label>个人信息</label> </div></a>
        <a href="ManageUsers.jsp"><div><label>用户管理</label> </div></a>
        <a href="ManageCommodities.jsp"><div style="background: #aee2f8;box-shadow:0 1px 10px rgba(0,0,0,0.2);"><label>商品管理</label> </div></a>
        <a href="ManageOrders.jsp"><div><label>订单管理</label> </div></a>
        <a href="index.jsp"><div><label>回到首页</label> </div></a>
        <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
    </div>
    <table id="commodity_table" class="table table-bordered table-striped" style="width:100%">
        <thead>
            <tr>
                <th>序号</th><th>商品名</th><th>发布日期</th><th>价格</th><th>库存量</th><th>浏览量</th>
            </tr>
        </thead>
        <tbody>
            <% for(Commodity commodity : selectedCommodities) {%>
            <tr>
                <td align="center"><a href="<%="./alterCommodity.jsp?cid="+commodity.getCID()%>"><%=commodity.getCID()%></a></td>
                <td align="center"><%=commodity.getName()%></td>
                <td align="center"><%=commodity.getPublishedDate()%></td>
                <td align="center"><%=commodity.getPrice()%></td>
                <td align="center"><%=commodity.getInventory()%></td>
                <td align="center"><%=commodity.getViewedTime()%></td>
            </tr>
            <%
                }
            %>
                <% if(selectedCommodities.size() == 0) {%>
                        <tr><%="没有数据！"%></tr>
                <%
                    }
            %>
        </tbody>
        <tfoot>
        <tr>
            <th>序号</th><th>商品名</th><th>发布日期</th><th>价格</th><th>库存量</th><th>浏览量</th>
        </tr>
        </tfoot>
    </table>
    <div class="info"  style="border:0">
        <a href="./addCommodity.jsp" target="_blank">
            <input type="submit" value="增加商品" id="save" onclick=""/>
        </a>
        <input type="submit" value="删除商品" id="save" onclick="alter()"/>
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
<%--<script src="js/jquery.dataTables.min.js"></script>
<script src="js/dataTables.bootstrap.min.js"></script>
<script src="js/jsgrid.min.js"></script>--%>
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

