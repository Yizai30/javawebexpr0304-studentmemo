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
        <title>Edit Your Cards</title>
        <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/style02.css">
    </head>
    <body>
        <div id="records" class="container">
            <div class="card">
                <div class="content">
                    <h3>2016-08-08</h3>
                    <p>这是一个样例。</p>
                    <a href="#">更多内容</a><br>
                    <button class="del">删除记录</button>
                </div>
            </div>
        </div>
        <div class="container2">
          <button class="addbtn" data-toggle="modal" data-target="#myModal"></button>
        </div>

        <%--    模态框    --%>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel" style="font-size:28px;font-weight: bold;">添加一项待做事件</h4>
                    </div>
                    <div class="modal-body">
                        <p style="font-size: 16px;font-weight: bold;">截止时间：</p>
                        <input id="ddlYear" class="inputext" type="text" placeholder="YYYY"><span style="font-size: 16px;font-weight: bold;">年</span>
                        <input id="ddlMonth" class="inputext" type="text" placeholder="MM"><span style="font-size: 16px;font-weight: bold;">月</span>
                        <input id="ddlDay" class="inputext" type="text" placeholder="DD"><span style="font-size: 16px;font-weight: bold;">日</span>
                        <p style="font-size: 16px;font-weight: bold;">事件内容：</p>
                        <textarea id="eventContent" class="inputextarea"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button class="closebtn" data-dismiss="modal">关闭</button>
                        <button class="savebtn" data-dismiss="modal" onclick="createCard()">保存</button>
                    </div>
                </div>
            </div>
        </div>

        <%
            if (request.getSession().getAttribute("passwd") == null) {
                response.sendRedirect("RecordServlet");
            }
        %>

        <script src="./js/vanilla-tilt.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
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

            // 点击添加按钮，创建新的卡片
            function createCard() {

                // 找到添加卡片的区域
                let cardContainer = document.getElementById('records');

                // 待组装的节点
                let div01 = document.createElement('div');
                let div02 = document.createElement('div');
                let h3 = document.createElement('h3');
                let p = document.createElement('p');
                let a = document.createElement('a');
                let br = document.createElement('br');
                let del = document.createElement('button');

                // 待填充的值
                let ddlYear = document.getElementById('ddlYear').value;
                let ddlMonth = document.getElementById('ddlMonth').value;
                let ddlDay = document.getElementById('ddlDay').value;
                let eventContent = document.getElementById('eventContent').value;

                // 设置节点属性
                div01.setAttribute('class', 'card');
                div02.setAttribute('class', 'content');
                a.setAttribute('href', '#');
                del.setAttribute('class', 'del');
                del.setAttribute('onclick', 'deleteCard(this)');

                // 设置节点的值
                h3.innerText = ddlYear + "-" + ddlMonth + "-" + ddlDay;
                p.innerText = eventContent;
                a.innerText = "更多内容";
                del.innerText = "删除记录";

                // 组装节点元素
                cardContainer.appendChild(div01);
                div01.appendChild(div02);
                div02.appendChild(h3);
                div02.appendChild(p);
                div02.appendChild(a);
                div02.appendChild(br);
                div02.appendChild(del);

                // 渲染卡片的玻璃效果
                VanillaTilt.init(document.querySelectorAll(".card"),{
                    max: 15,    // 最大倾斜度数
                    speed: 400, // 倾斜转换的速度
                    glare: true,    // 是否开启眩光效果
                    "max-glare": 1  // 最大眩光的不透明度
                })

                // 获取记录截止时间, 并按紧迫程度排序
                var $divs = $('#records .card');
                $divs.sort(function(a,b){
                    var dateOfA = Date.parse($(a).find('h3').text());
                    var dateOfB = Date.parse($(b).find('h3').text());
                    return dateOfA - dateOfB;});
                $divs.detach().appendTo('#records');
            }

            // 删除相应卡片
            function deleteCard(obj) {
                delObj = obj.parentNode.parentNode;
                parentContainer = delObj.parentNode;
                parentContainer.removeChild(delObj);
            }
        </script>
    </body>
</html>
