<%@ page import="java.util.List" %>
<%@ page import="xyz.moment.here.po.OrderForm" %>
<%@ page import="xyz.moment.here.po.OrderItem" %>
<%--
  Created by IntelliJ IDEA.
  User: 众神消亡
  Date: 2020/12/22
  Time: 18:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的购物车</title>
    <link rel="stylesheet" type="text/css" href="css/commonStyle.css">
    <link rel="stylesheet" type="text/css" href="css/cartStyle.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.min.css">
    <%
        //检测是否已登录
        if(session.getAttribute("UID")!=null){
            //response.sendRedirect("myself.jsp");
        }
        else {
            response.sendRedirect("login.jsp");
        }

        List<OrderItem> myCart = (List<OrderItem>) session.getAttribute("myCart");
        if(myCart != null)
            System.out.println("myCart---> " + myCart.size());

    %>
    <c:set var="myCart" scope="application" value="<%= myCart%>"/>
</head>
<body>
<div class="top">
    <img src="./img/DEAL_logo.jpg" class="logo" alt="logo"/>
    <h2 style="margin-top:45px; margin-left:20px; float:left;">我的购物车</h2>
    <a href="#"><img src="./img/usr.png" class="user" alt="usersimg"></a>
</div>
<br>
<div class="main">
    <div class="sidebar">
        <a href="myself.jsp"><div><label>个人信息</label> </div></a>
        <a href="cart.jsp"><div style="background: #aee2f8;box-shadow:0px 1px 10px rgba(0,0,0,0.2);"><label>我的购物车</label> </div></a>
        <a href="order.jsp"><div><label>我的订单</label> </div></a>
        <a href="index.jsp"><div><label>回到首页</label> </div></a>
        <a href="LogoutServlet"><div><label>退出账号</label> </div></a>
    </div>
    <form style="border: none" name="orderForm">
        <div class="good" style="border: none">
                <table id="cart_table" class="table table-bordered table-striped" style="width:100%" name="cart_table">
                    <thead>
                    <tr>
                        <th>选择</th><th>商品名称</th><th>数量</th><th>单价</th><th>总价</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for(OrderItem orderItem : myCart) {%>
                    <tr>
                        <td align="center">
                            <input type="checkbox"
                                   name="<%=orderItem.getIID()%>"
                                   id="<%=orderItem.getIID()%>"
                                   onclick="settle(<%=orderItem.getPrice() * orderItem.getNumber()%>,<%=orderItem.getIID()%>)"
                            />
                        </td>
                        <td align="center"><%=orderItem.getName()%></td>
                        <td align="center"><%=orderItem.getNumber()%></td>
                        <td align="center"><%=orderItem.getPrice()%></td>
                        <td align="center"><%=orderItem.getPrice() * orderItem.getNumber()%></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td colspan="4" align="center" style="border-top: solid 1px; border-right: solid 1px">小计</td>
                        <!- DataTables使用colspan应补全其它td，否则回报错！-->
                        <td style="display:none"></td>
                        <td style="display:none"></td>
                        <td style="display:none"></td>

                        <td align="center" id="cost" style="border-top: solid 1px"></td>
                    </tr>
                    <% if(myCart.size() == 0) {%>
                    <tr><%="没有数据！"%></tr>
                    <%
                        }
                    %>
                    </tbody>
                    <tfoot>
                    <tr>
                        <th>选择</th><th>商品名称</th><th>数量</th><th>单价</th><th>总价</th>
                    </tr>
                    </tfoot>
                </table>
        </div>
        <div class="operations">
            <input class="op" type="button" value="清空购物车" onclick="clearCart()"/>
            <input class="op" type="button" value="删除所选" onclick="deleteCommodity()"/>
            <input class="op" type="button" value="立即购买" onclick="buyNow()"/>
        </div>
    </form>
    <script>
        let sum = 0;
        let chosen=[];  //IID
        function settle(price, boxid){
            let cost = document.querySelector("#cost");
            let checkbox = document.getElementById(boxid);
            if(checkbox.checked === true){
                chosen.push(boxid);
                console.log("true")
                sum += parseFloat(price);
                cost.innerHTML = sum;
            }
            else{
                let cancel=[];
                for(let i = 0; i <chosen.length; i++) {
                    if(chosen[i] !== boxid) {
                        console.log(chosen[i]+"!="+boxid+"put it into cancel[]!");
                        cancel.push(chosen[i]);
                    }
                    else
                        console.log(chosen[i]+"=="+boxid+"throw it!");
                }
                chosen = cancel;
                console.log("false");
                sum -= parseFloat(price);
                cost.innerHTML = sum;
            }
            for(let i = 0; i < chosen.length; i++) {
                //console.log(i)
                console.log("chosen["+i+"]="+chosen[i]);
            }
        }

        function clearCart(){
            document.orderForm.action="ClearCartServlet";
            var c = confirm("确定清空？");
            if(c===true){
                document.orderForm.submit();
            }
        }

        function deleteCommodity(){
            //删除源头即可
            document.orderForm.action="DeleteCommodityServlet";
            var opt = document.createElement("textarea");
            opt.name = "key";
            opt.value = chosen.toString();
            opt.style.display = "none";
            document.orderForm.appendChild(opt);
            var c = confirm("确定删除？");
            if(c===true){
                document.orderForm.submit();
            }
        }

        function buyNow(){
            document.orderForm.action="PurchaseServlet";
            var opt = document.createElement("textarea");
            opt.name = "key";
            opt.value = chosen.toString();
            opt.style.display = "none";
            document.orderForm.appendChild(opt);
            var c = confirm("确定购买？");
            if(c===true){
                document.orderForm.submit();
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
        $('#cart_table').DataTable(
            {
                "paging": true,       <!-- 允许分页 -->
                "lengthChange": true, <!-- 允许改变每页显示的行数 -->
                "searching": true,    <!-- 允许内容搜索 -->
                "ordering": false,     <!-- 允许排序 -->
                "info": true,         <!-- 显示信息 -->
                "autoWidth": false,   <!-- 固定宽度 -->
                "selected": true
            }
        );
    } );

</script>
</html>
