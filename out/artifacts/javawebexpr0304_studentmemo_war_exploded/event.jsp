<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/4/21
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
    <head>
        <title>Create Your DDLS</title>
        <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="./css/style02.css">
    </head>
    <body>
        <div style="height: 100%;width: 100%">
            <h1 style="color: #000;margin-left: 3%;font-weight: bold">My DDLS</h1>
            <div id="events" class="container">
                <div class="card">
                    <div class="content">
                        <h3>2016-08-08</h3>
                        <p>这是一个样例。</p>
                        <a href="#">编辑内容</a><br>
                        <button class="del">删除记录</button>
                    </div>
                </div>
                <c:forEach items="${eventList}" var="event">
                    <div class="card">
                        <div class="content">
                            <h3>${event.deadLine}</h3>
                            <p>${event.content}</p>
                            <a href="#" onclick="storeEvent('${event.id}','${event.deadLine}','${event.content}')" data-toggle="modal" data-target="#editModal">编辑内容</a><br>
                            <a href="DeleteEventServlet?id=${event.id}" class="del" onclick="if(confirm('确定删除该条原本期望在'+'${event.deadLine}'+'之前完成的事件嘛?')==false)return false">删除记录</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="container2">
          <button class="addbtn" data-toggle="modal" data-target="#myModal"></button>
        </div>

        <%--    模态框为当前用户添加一条事件记录    --%>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel" style="font-size:28px;font-weight: bold;">添加一项待做事件</h4>
                    </div>
                    <form name="recordForm" action="InsertEventServlet" method="post">
                        <div class="modal-body">
                            <p style="font-size: 16px;font-weight: bold;">截止时间：</p>
                            <input id="ddlYear" name="ddlYear" class="inputext" style="width: 88px" type="text" placeholder="YYYY">
                            <span style="font-size: 16px;font-weight: bold;">年</span>
                            <input id="ddlMonth" name="ddlMonth" class="inputext" style="width: 72px" type="text" placeholder="MM">
                            <span style="font-size: 16px;font-weight: bold;">月</span>
                            <input id="ddlDay" name="ddlDay" class="inputext" style="width: 72px" type="text" placeholder="DD">
                            <span style="font-size: 16px;font-weight: bold;">日</span>
                            <p style="font-size: 16px;font-weight: bold;">事件内容：</p>
                            <textarea id="eventContent" name="eventContent" class="inputextarea"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="closebtn" data-dismiss="modal">关闭</button>
                            <input type="button" class="savebtn" value="添加" onclick="checkCard(this.form)"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%--    模态框为当前用户修改一条事件记录    --%>
        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                        <h4 class="modal-title" id="editModalLabel" style="font-size:28px;font-weight: bold;">修改待做事件</h4>
                    </div>
                    <form name="editForm" action="EditEventServlet" method="post">
                        <div class="modal-body">
                            <span style="font-size:16px;font-weight: bold;margin-bottom: 6px;display: none">记录ID：</span>
                            <input id="eId" name="eId" style="border: none;outline: none;width: 30px;display: none" readonly/>
                            <p style="font-size: 16px;font-weight: bold;">截止时间：</p>
                            <input id="eDdlYear" name="eDdlYear" class="inputext" style="width: 88px" type="text" placeholder="YYYY">
                            <span style="font-size: 16px;font-weight: bold;">年</span>
                            <input id="eDdlMonth" name="eDdlMonth" class="inputext" style="width: 72px" type="text" placeholder="MM">
                            <span style="font-size: 16px;font-weight: bold;">月</span>
                            <input id="eDdlDay" name="eDdlDay" class="inputext" style="width: 72px" type="text" placeholder="DD">
                            <span style="font-size: 16px;font-weight: bold;">日</span>
                            <p style="font-size: 16px;font-weight: bold;">事件内容：</p>
                            <textarea id="eEventContent" name="eEventContent" class="inputextarea"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="closebtn" data-dismiss="modal">关闭</button>
                            <input type="button" class="savebtn" value="保存" onclick="checkEdit(this.form)"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%
            if (request.getSession().getAttribute("passwd") == null) {
                response.sendRedirect("JudgeLoginEventServlet");
            }
        %>

        <script src="./js/vanilla-tilt.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
        <script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script>

            // vanilla-tilt.js是一个平滑的3D倾斜JS库, 让玻璃效果更逼真, 具体参数配置可百度
            VanillaTilt.init(document.querySelectorAll(".card"),{
                max: 3,    // 最大倾斜度数
                speed: 330, // 倾斜转换的速度
                glare: true,    // 是否开启眩光效果
                "max-glare": 1  // 最大眩光的不透明度
            })
            VanillaTilt.init(document.querySelector(".addbtn"),{
                max: 5,
                speed: 300,
                glare: true,
                "max-glare": 1
            })

            // 卡片内容校验
            function checkCard(form) {
                if (!isYear(form.ddlYear.value)) {
                    alert("年份请输入 2022-2050 之间的数值");
                    form.ddlYear.focus();
                    return false;
                }
                if (!isMonth(form.ddlMonth.value)) {
                    alert("月份请输入 01-12 之间的数值");
                    form.ddlMonth.focus();
                    return false;
                }
                if (!isDay(form.ddlYear.value, form.ddlMonth.value, parseInt(form.ddlDay.value, 10))) {
                    alert("请输入存在的日期");
                    form.ddlDay.focus();
                    return false;
                }
                if (form.eventContent.value === "") {
                    alert("请输入事件内容");
                    form.eventContent.focus();
                    return false;
                }

                // 校验成功，创建卡片
                // createCard();
                document.recordForm.submit();
            }
            function isYear(str) {
                var reg=/^20(2[2-9]|[3-4][0-9]|50)$/;
                return reg.test(str);
            }
            function isMonth(str) {
                var reg=/^(0[1-9]|1[0-2])$/;
                return reg.test(str);
            }
            function isDay(year, month, day) {
                var bigMonth = ['01','03','05','07','08','10','12'];
                var smMonth = ['04','06','09','11'];
                if (bigMonth.indexOf(month) !== -1) {
                    if (day >= 1 && day <= 31) return true;
                    else return false;
                }
                else if (smMonth.indexOf(month) !== -1) {
                    if (day >= 1 && day <= 30) return true;
                    else return false;
                }
                else {
                    if (year % 100 !== 0 && year % 4 === 0
                        || year % 400 === 0) {
                        if (day >= 1 && day <= 29) return true;
                        else return false;
                    }
                    else {
                        if (day >= 1 && day <= 28) return true;
                        else return false;
                    }
                }
            }

            // 卡片修改校验
            function checkEdit(form) {
                if (!isYear(form.eDdlYear.value)) {
                    alert("年份需为 2022-2050 之间的数值");
                    form.eDdlYear.focus();
                    return false;
                }
                if (!isMonth(form.eDdlMonth.value)) {
                    alert("月份需为 01-12 之间的数值");
                    form.eDdlMonth.focus();
                    return false;
                }
                if (!isDay(form.eDdlYear.value, form.eDdlMonth.value, parseInt(form.eDdlDay.value, 10))) {
                    alert("需修改为存在的日期");
                    form.eDdlDay.focus();
                    return false;
                }
                if (form.eEventContent.value === "") {
                    alert("事件内容不能为空");
                    form.eEventContent.focus();
                    return false;
                }

                document.editForm.submit();
            }

            // 存储需要修改的 event 的 id, deadLine（需要进行字符串处理）, content
            function storeEvent(id, deadLine, content) {
                sessionStorage.setItem("eId", id);
                $('#eId').attr("value", sessionStorage.getItem("eId"));

                // 分割 deadLine
                var timeYMD = deadLine.toString().split("-");
                $('#eDdlYear').attr("value", timeYMD[0]);
                $('#eDdlMonth').attr("value", timeYMD[1]);
                $('#eDdlDay').attr("value", timeYMD[2]);

                $('#eEventContent').val(content);
            }

            // 点击添加按钮，创建新的卡片（测试用）
            function createCard() {

                // 找到添加卡片的区域
                let cardContainer = document.getElementById('events');

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
                    max: 3,    // 最大倾斜度数
                    speed: 330, // 倾斜转换的速度
                    glare: true,    // 是否开启眩光效果
                    "max-glare": 1  // 最大眩光的不透明度
                })

                // 获取记录截止时间, 并按紧迫程度排序
                var $divs = $('#events .card');
                $divs.sort(function(a,b){
                    var dateOfA = Date.parse($(a).find('h3').text());
                    var dateOfB = Date.parse($(b).find('h3').text());
                    return dateOfA - dateOfB;});
                $divs.detach().appendTo('#events');
            }

            // 删除相应卡片（测试用）
            function deleteCard(obj) {
                delObj = obj.parentNode.parentNode;
                parentContainer = delObj.parentNode;
                parentContainer.removeChild(delObj);
            }
        </script>
    </body>
</html>
