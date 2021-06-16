<%@ page import="xyz.moment.here.po.Commodity" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="xyz.moment.here.service.CommodityFilter" %><%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/6/15
  Time: 下午4:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>搜索商品</title>
    <link rel="stylesheet" type="text/css" href="css/indexStyle.css">
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/myselfStyle.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <script>
        //显示用户名
        <%
            String username = "未登录";
        %>
        var userpage=document.querySelector("#userpage");
        <%
          if(session.getAttribute("username") != null){
            username = session.getAttribute("username").toString();
        %>
        <%
          }
          else{
        %>
        userpage.href = "login.jsp";
        <%
          }
        %>

        <%
            List<Commodity> selectedCommodities = new ArrayList<>();
            CommodityFilter commodityFilter = new CommodityFilter();
            request.setCharacterEncoding("utf-8");
            String keywords = request.getParameter("keywords");
            System.out.println(keywords);
            try {
                selectedCommodities = commodityFilter.selectCommodities(keywords);
                System.out.println("get "+selectedCommodities.size()+" commodities");
            } catch (SQLException | ClassNotFoundException throwables) {
                throwables.printStackTrace();
            }
        %>
    </script>
</head>
<body id="body">
<div class="top1">
    <a href="adminlogin.jsp" target="_blank">
        <img src="./img/DEAL_logo.jpg" class="logo" />
    </a>
    <a href="#" id="userpage" name="userpage">
        <img src="img/usr.png" class="self">
        <p class="username"><%= username %></p>
    </a>
</div>
<div>
    <div style="border: orangered solid 1px; position: fixed; top: 32px; height:41px; left: 38%; width: 400px; z-index:1;">
        <form action="SearchCommoditiesServlet" method="post">
            <input type="text" placeholder="请输入商品名称" id="inputArea" name="keywords"/>
            <input type="submit" value="搜索" id="searchButton" name="searchButton" style="border:1px solid #CCC; transition:all 0.6s;"/>
        </form>
    </div>
</div>

<br><br><br><br><br><br>

<div id="banner">
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
</body>
</html>
