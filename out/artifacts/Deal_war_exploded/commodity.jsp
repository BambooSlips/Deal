<%@ page import="xyz.moment.here.po.Commodity" %>

<%@ page import="java.sql.SQLException" %>
<%@ page import="xyz.moment.here.dao.CommodityDAO" %>
<%--
  Created by IntelliJ IDEA.
  User: 众神消亡
  Date: 2020/12/19
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>商品详情</title>
    <link rel="stylesheet" type="text/css" href="css/commodityStyle.css">
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <style></style>
    <script>
        <%
            String sql = "select * from commodity where CID= ";
            Commodity commodity = new Commodity();
            pageContext.setAttribute("commodity",commodity);
        %>
            <c:set value="${param.cid}" property="CID" target="${commodity}"></c:set>
        <%
            sql = sql + commodity.getCID();
            System.out.println(sql);
            try {
                commodity = CommodityDAO.queryCommodity(sql);
                pageContext.setAttribute("commodity",commodity);
                commodity.setViewedTime(commodity.getViewedTime()+1);
                CommodityDAO.updateCommodity(commodity);
                session.setAttribute("c1",commodity);
                System.out.println("commodity.jsp:c1:commodity.getCID()="+commodity.getCID());
            }
            catch (SQLException throwables) {
                throwables.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>
        <c:set var="commodity" value="${commodity}" scope="application"></c:set>
    </script>
</head>
<body>
<div class="top">
    <img src="./img/DEAL_logo.jpg" class="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">商品详情</h2>

    <a class="port" href="CheckAccountServlet" target="_blank">
        <img src="img/usr.png" class="user" style="bottom: -10px; right:80px">
        ${(applicationScope.me.username!=null)?applicationScope.me.username:"未登录"}>
    </a>
</div>
<br><br>
<div class="main">
    <div class="left">
<%--        <img src="img/ad${param.id}.jpg" class="pics" alt="商品展示">--%>
        <img src="./img/${commodity.photo}" class="pics" alt="商品展示">
    </div>
    <div class="right">
        <p id="comName">${commodity.name}</p><hr>
        <br>
        <label style="color: #999; position: relative; left:10px;">售价：</label>
        <div class="price_now"><label style="color: white; font-size: 18px">￥${commodity.price}</label></div>
        <div class="price_prior"><label style="color: #999; text-decoration: line-through; font-size: 6px">￥${commodity.price}</label></div>
        <form action="PutinCartServlet" method="post">
            <label style="color: #999;">
                ${commodity.inventory}件已售&nbsp&nbsp&nbsp剩余${commodity.inventory}件
                ${commodity.description}
            </label><br>
            <label style="color: #999;">
                <div class="">配送至：</div>
                <textarea name="address" rows="10" cols="50">${applicationScope.me.address}</textarea>
            </label>
            <label><input type="text" name="num" value="1" class="num" /></label>

            <input type="button" value="+" onclick="add()" class="add"/>
            <input type="button" value="-" onclick="sub()" class="sub"/>
            <input type="submit" value="加入购物车" class="decision" id="putin"/>
        </form>
    </div>
    <a class="research">
        调查问卷
    </a>
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
    var choice = document.querySelectorAll(".option");
    var num = document.querySelector(".num");

    for(var i = 0; i < choice.length; i++){
        console.log(choice[i].value)
    }
    function choose() {

    }

    function add(){
        num.value ++;
    }

    function sub(){
        if(parseInt(num.value) > 0){
            num.value --;
        }
    }

</script>
</body>
</html>
