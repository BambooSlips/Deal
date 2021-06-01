<%--
  Created by IntelliJ IDEA.
  User: breeze
  Date: 2021/5/1
  Time: 下午10:09
  To change this template use File | Settings | File Templates.
--%>
<script>//1</script>
<%@ page import="xyz.moment.here.po.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="xyz.moment.here.po.Commodity" %>
<%@ page import="java.util.List" %>
<%@ page import="xyz.moment.here.dao.CommodityDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>商城</title>
  <link rel="stylesheet" type="text/css" href="css/indexStyle.css">
  <link rel="stylesheet" type="text/css" href="css/registerStyle.css">
  <style></style>
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
  </script>
</head>
<body>
<div class="top1">
  <a href="adminlogin.jsp" target="_blank">
    <img src="./img/logo.png" class="logo" />
  </a>
  <a href="#" id="userpage" name="userpage">
    <img src="img/usr.png" class="self">
    <p class="username"><%= username %></p>
  </a>


</div>
<div>
  <div style="border: orangered solid 1px; position: fixed; top: 32px; height:41px; left: 38%; width: 400px; z-index:1;">
    <input type="text" placeholder="请输入商品名称" id="inputArea"/>
    <input type="button" value="搜索" id="searchButton"/>
  </div>
</div>


<br><br><br><br><br><br>
<div id="banner">

  <ul>
    <li>
      <a href="commodity.jsp?id=1" id="mainlink" target="_blank">
        <img src="img/493993663.jpg" style="height: 470px; position: relative; left: 210px;" id="mainAD" alt="">
      </a>
    </li>
  </ul>
  <!-- 侧边栏 -->
  <div class="subnav">
    <ul>
      <li>
        <a href="#">服装衣物  <span> > </span>
          <div class="commodity" id="c1">敬请期待</div>
        </a>
      </li>

      <li><a href="#">日用百货  <span> > </span>
        <div class="commodity" id="c2">敬请期待</div></a>
      </li>

      <li><a href="#">数码电子  <span> > </span>
        <div class="commodity" id="c3">敬请期待</div></a>
      </li>

      <li><a href="#">医疗医药  <span> > </span>
        <div class="commodity" id="c4">敬请期待</div></a>
      </li>

      <li><a href="#">百味食品  <span> > </span>
        <div class="commodity" id="c5">敬请期待</div></a>
      </li>

      <li><a href="#">教育图书  <span> > </span>
        <div class="commodity" id="c6">敬请期待</div></a>
      </li>

      <li><a href="#">运动健身  <span> > </span>
        <div class="commodity" id="c7">敬请期待</div></a>
      </li>

      <li><a href="#">旅游出行  <span> > </span>
        <div class="commodity" id="c8">敬请期待</div></a>
      </li>
      <li><a href="#">工业制造  <span> > </span>
        <div class="commodity" id="c9">敬请期待</div></a>
      </li>
      <li><a href="#">家用电器  <span> > </span>
        <div class="commodity" id="c0">敬请期待</div></a>
      </li>
    </ul>
  </div>

  <!-- 小圆点 -->
  <div class="circle">
    <i class="current" id="pic0"></i>
    <i id="pic1"></i>
    <i id="pic2"></i>
    <i id="pic3"></i>
    <i id="pic4"></i>
    <i id="pic5"></i>
  </div>

  <div class="control">
    <button style="position: absolute; left: 0; border-radius: 0 5px 5px 0;" onclick="toLeft()">《</button>
    <button style="position: absolute; right: 0; border-radius: 5px 0 0 5px" onclick="toRight()">》</button>
  </div>

  <div class="timebook">
    <a href="#"><img src="./img/ad6.png" alt="" class="timebook ads" id="tad1"/></a>
    <a href="#"><img src="./img/ad7.png" alt="" class="timebook ads" id="tad2"/></a>
    <a href="#"><img src="./img/ad8.png" alt="" class="timebook ads" id="tad3"/></a>
  </div>

</div>
<br>
<div id="center">
  <ul>
    <li>
      <img src="./img/faerieQuee.png" width="242px" height="242px"/>
    </li>
    <li>
      <img src="./img/bookshelf0.jpg" width="242px"/>
    </li>
    <li>
      <img src="./img/watch1.jpg" width="242px"/>
    </li>
    <li id="li1">
      <img src="./img/javaWeb1.jpg" width="242px"/>
    </li>
  </ul>
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
  var userpage=document.querySelector("#userpage");
  <%
  //初始化用户
  User me = new User();
  /*if(session.getAttribute("birthday") != null){
    me.setBirthday(session.getAttribute("birthday").toString());
  }*/
  if(session.getAttribute("address") != null){
    me.setAddress(session.getAttribute("address").toString());
  }
  if(session.getAttribute("phone") != null){
    me.setPhoneNumber(session.getAttribute("phone").toString());
  }
  if(session.getAttribute("username") != null){
    me.setUID(session.getAttribute("UID").toString());
    me.setUsername(session.getAttribute("username").toString());
    me.setPassword(session.getAttribute("password").toString());
  %>
    //若用户已登录则显示其用户名并将用户头像导航至个人信息
    userpage.href = "myself.jsp";
    <c:set var="me" scope="application" value="<%= me%>"></c:set>
  <%
  }
  else{
  %>
    userpage.href = "login.jsp";
  <%
  }
  %>
  //-------------------------------------------------
  //从数据库中提取商品ID保存至数组中，再以6为周期循环播放图片
  let CIDs = [];
  let Imgs = [];
  <%
    //取得全部商品
    List<Commodity> allCommodities = new ArrayList<Commodity>();
    allCommodities = CommodityDAO.queryAllCommodities();
    for (Commodity commodity : allCommodities) {
  %>
      CIDs.push("<%= commodity.getCID()%>");
      Imgs.push("<%= commodity.getPhoto()%>")
      /*for (let x in CIDs) {
        document.writeln(x);
      }
      for (let x in Imgs) {
        document.writeln(x);
      }*/
  <%
    }
  %>

  let img = document.querySelector("#mainAD");
  let tad1 = document.querySelector("#tad1");
  let tad2 = document.querySelector("#tad2");
  let tad3 = document.querySelector("#tad3");
  let mainlink = document.querySelector("#mainlink");
  let i = 0;
  let num;

  //切换主广告
  function changeMainAD(){
    //6个一周期
    num = i%6;
    //let path = "./img/ad" + num + ".jpg";
    let path = "./img/"+Imgs[num];
    img.src = path.toString();
    console.log(path.toString());
    img.style.marginLeft="-10px";

    //设置图片链接
    mainlink.href = "commodity.jsp?cid="+CIDs[num];

    //图片下小圆点
    let circle1 = document.querySelector("#pic"+(num));
    if(num > 0){
      let circle0 = document.querySelector("#pic"+(num-1));
      circle0.style.background = "rgba(255, 255, 255, 0.4)";
    }
    else if(num===0){
      let circle0 = document.querySelector("#pic5");
      circle0.style.background = "rgba(255, 255, 255, 0.4)";
    }
    circle1.style.background = "rgba(0, 0, 0, 0.4)";
    i++;
  }

  //向左翻广告
  function toLeft() {
    let circle2 = document.querySelector("#pic"+(num));
    circle2.style.background = "rgba(255, 255, 255, 0.4)";
    let left = num - 1;
    let path;
    console.log("left:"+left);
    if(left >= 0){

    }
    else{
      left =5;
    }
    img.src = path.toString();
    img.style.marginLeft="-10px";
    mainlink.href = "commodity.jsp?cid="+CIDs[left];
    console.log(path.toString());
    let circle1 = document.querySelector("#pic"+(num));
    if(num > 0){
      let circle0 = document.querySelector("#pic"+(num-1));
      circle0.style.background = "rgba(255, 255, 255, 0.4)";
    }
    else if(num===0){
      let circle0 = document.querySelector("#pic5");
      circle0.style.background = "rgba(255, 255, 255, 0.4)";
    }
    circle1.style.background = "rgba(0, 0, 0, 0.4)";
    num--;
    i--;
  }

  //向右翻广告
  function toRight(){
    let circle2 = document.querySelector("#pic"+(num));
    circle2.style.background = "rgba(255, 255, 255, 0.4)";
    let left = num + 1;
    let path;
    if(left < 6){
      path= "./img/ad" + left + ".jpg";
    }
    else{
      path = "./img/ad" + 0 + ".jpg";
    }
    img.src = path.toString();
    img.style.marginLeft="-10px";
    mainlink.href = "commodity.jsp?cid="+CIDs[left];
    console.log(path.toString());
    let circle1 = document.querySelector("#pic"+(num));
    if(num > 0){
      let circle0 = document.querySelector("#pic"+(num-1));
      circle0.style.background = "rgba(255, 255, 255, 0.4)";
    }
    else if(num===0){
      let circle0 = document.querySelector("#pic5");
      circle0.style.background = "rgba(255, 255, 255, 0.4)";
    }
    circle1.style.background = "rgba(0, 0, 0, 0.4)";
    num++;
    i++;
  }

  //切换右侧边栏广告
  let j = 0;
  function changeTads() {
    let num = j%9 + 6;
    let path = "./img/ad" + num  + ".png";
    if(num < 13){
      tad1.src = path.toString() ;
      path = "./img/ad" + (num+1)  + ".png";
      tad2.src = path.toString();
      path = "./img/ad" + (num+2)  + ".png";
      tad3.src = path.toString();
    }
    else {
      tad1.src = path.toString() ;
      path = "./img/ad" + 6  + ".png";
      tad2.src = path.toString();
      path = "./img/ad" + 7  + ".png";
      tad3.src = path.toString();
    }
    j++;
  }
  changeTads();
  changeMainAD();
  setInterval(changeMainAD,3000);
  setInterval(changeTads,1000);
</script>
<script src="js/jquery-3.5.1.js"></script>
<script type ="text/javascript">
  /*判断是否到达页面底部
  $(window).scroll(function(){
    var scrollTop = $(this).scrollTop();
    var scrollHeight = $(document).height();
    var windowHeight = $(this).height();
    var position = scrollTop + windowHeight;
    console.log(scrollHeight.toFixed(0)+"--"+scrollTop+"--"+windowHeight+"--"+(scrollTop + windowHeight + 1).toFixed(0));
    if(( position +1).toFixed(0) >= scrollHeight.toFixed(0)){
      alert("已经到最底部了！");
    }
  });
   */
</script>

</body>
</html>



