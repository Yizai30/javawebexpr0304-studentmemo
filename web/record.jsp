<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/4/21
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Welcome To STM</title>
        <link rel="stylesheet" href="./css/style02.css">
    </head>
    <body>
        <div id="records" class="container">
          <div class="card">
            <div class="content">
              <h3>2016-08-08</h3>
              <p>Realistic glass card hover effect,
                  realistic glass card hover effect,
                  realistic glass card hover effect.
              </p>
              <a href="#">Read More</a>
            </div>
          </div>
          <div class="card">
            <div class="content">
              <h3>2015-08-08</h3>
              <p>Realistic glass card hover effect,
                  realistic glass card hover effect,
                  realistic glass card hover effect.
              </p>
              <a href="#">Read More</a>
            </div>
          </div>
          <div class="card">
            <div class="content">
              <h3>2014-08-08</h3>
              <p>Realistic glass card hover effect,
                  realistic glass card hover effect,
                  realistic glass card hover effect.
              </p>
              <a href="#">Read More</a>
            </div>
          </div>
          <div class="card">
            <div class="content">
              <h3>2013-08-08</h3>
              <p>Realistic glass card hover effect,
                  realistic glass card hover effect,
                  realistic glass card hover effect.
              </p>
              <a href="#">Read More</a>
            </div>
          </div>
          <div class="card">
            <div class="content">
              <h3>2012-08-08</h3>
              <p>Realistic glass card hover effect,
                  realistic glass card hover effect,
                  realistic glass card hover effect.
              </p>
              <a href="#">Read More</a>
            </div>
          </div>
        </div>
        <div class="container2">
          <button class="addbtn"></button>
        </div>
        <script src="./js/vanilla-tilt.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script>
          // vanilla-tilt.js是一个平滑的3D倾斜JS库, 让玻璃效果更逼真, 具体参数配置可百度
          VanillaTilt.init(document.querySelectorAll(".card"),{
            max: 15,    // 最大倾斜度数
            speed: 400, // 倾斜转换的速度
            glare: true,    // 是否开启眩光效果
            "max-glare": 1  // 最大眩光的不透明度
          })
          VanillaTilt.init(document.querySelector(".addbtn"),{
            max: 5,
            speed: 300,
            glare: true,
            "max-glare": 1
          })
        
          // 获取记录截止时间, 并按紧迫程度排序
          var $divs = $('#records .card');
          $divs.sort(function(a,b){
            var dateOfA = Date.parse($(a).find('h3').text());
            var dateOfB = Date.parse($(b).find('h3').text());
            return dateOfA - dateOfB;});
          $divs.detach().appendTo('#records');
        </script>
    </body>
</html>
