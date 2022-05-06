<%--
  Created by IntelliJ IDEA.
  User: Mena
  Date: 2022/5/6
  Time: 17:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>Edit Your Cards</title>
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/style03.css">
</head>
<body>
<div style="height: 100%;width: 100%">
    <h1 style="color: #000;margin-left: 3%;font-weight: bold">My Diaries</h1>
    <div id="diaries" class="container">
        <div class="card">
            <div class="content01">
                <h3>2016-08-08</h3>
                <lable style="font-weight: bold">日记：</lable><p>这是日记样例内容。</p>
                <lable style="font-weight: bold">心情：</lable><p>这是心情样例内容。</p>
            </div>
            <div class="content02">
                <a href="#">更多内容</a><br>
                <button class="del">删除日记</button>
            </div>
        </div>
        <c:forEach items="${diaryList}" var="diary">
            <div class="card">
                <div class="content01">
                    <h3>${diary.createTime}</h3>
                    <lable style="font-weight: bold">日记：</lable><p>${diary.content}</p>
                    <lable style="font-weight: bold">心情：</lable><p>${diary.mood}</p>
                </div>
                <div class="content02">
                    <a href="#">更多内容</a><br>
                    <a href="DeleteDiaryServlet?id=${diary.id}" class="del" onclick="if(confirm('确定删除'+'${diary.createTime}'+'的日记嘛?')==false)return false">删除日记</a>
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
                <h4 class="modal-title" id="myModalLabel" style="font-size:28px;font-weight: bold;">记录一下成长的一天</h4>
            </div>
            <form name="diaryForm" action="InsertDiaryServlet" method="post">
                <div class="modal-body">
                    <p style="font-size: 16px;font-weight: bold;">今天是：</p>
                    <input id="diaryYear" name="diaryYear" class="inputext" style="width: 88px" type="text" placeholder="YYYY">
                    <span style="font-size: 16px;font-weight: bold;">年</span>
                    <input id="diaryMonth" name="diaryMonth" class="inputext" style="width: 72px" type="text" placeholder="MM">
                    <span style="font-size: 16px;font-weight: bold;">月</span>
                    <input id="diaryDay" name="diaryDay" class="inputext" style="width: 72px" type="text" placeholder="DD">
                    <span style="font-size: 16px;font-weight: bold;">日</span>
                    <p style="font-size: 16px;font-weight: bold;">日记：</p>
                    <textarea id="diaryContent" name="diaryContent" class="inputextarea"></textarea>
                    <p style="font-size: 16px;font-weight: bold;">心情：</p>
                    <textarea id="moodContent" name="moodContent" class="inputextarea"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="closebtn" data-dismiss="modal">关闭</button>
                    <input type="button" class="savebtn" value="保存" onclick="checkCard(this.form)"/>
                </div>
            </form>
        </div>
    </div>
</div>



<%
    if (request.getSession().getAttribute("passwd") == null) {
        response.sendRedirect("JudgeLoginDiaryServlet");
    }
%>

<script src="./js/vanilla-tilt.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script>

    // vanilla-tilt.js是一个平滑的3D倾斜JS库, 让玻璃效果更逼真, 具体参数配置可百度
    VanillaTilt.init(document.querySelectorAll(".card"),{
        max: 1,    // 最大倾斜度数
        speed: 300, // 倾斜转换的速度
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
        if (!isYear(form.diaryYear.value)) {
            alert("年份请输入 2022-2050 之间的数值");
            form.diaryYear.focus();
            return false;
        }
        if (!isMonth(form.diaryMonth.value)) {
            alert("月份请输入 01-12 之间的数值");
            form.diaryMonth.focus();
            return false;
        }
        if (!isDay(form.diaryYear.value, form.diaryMonth.value, parseInt(form.diaryDay.value, 10))) {
            alert("请输入存在的日期");
            form.diaryDay.focus();
            return false;
        }
        if (form.diaryContent.value === "") {
            alert("请输入日记内容");
            form.diaryContent.focus();
            return false;
        }
        if (form.moodContent.value === "") {
            alert("请输入心情内容");
            form.moodContent.focus();
            return false;
        }

        // 校验成功，创建卡片
        // createCard();
        document.diaryForm.submit();
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

    // 点击添加按钮，创建新的卡片
    function createCard() {

        // 找到添加卡片的区域
        let cardContainer = document.getElementById('diaries');

        // 待组装的节点
        let div01 = document.createElement('div');
        let div02 = document.createElement('div');
        let div03 = document.createElement('div');
        let h3 = document.createElement('h3');
        let lbl01 = document.createElement('label');
        let lbl02 = document.createElement('label');
        let p01 = document.createElement('p');
        let p02 = document.createElement('p');
        let a = document.createElement('a');
        let br = document.createElement('br');
        let del = document.createElement('button');

        // 待填充的值
        let diaryYear = document.getElementById('diaryYear').value;
        let diaryMonth = document.getElementById('diaryMonth').value;
        let diaryDay = document.getElementById('diaryDay').value;
        let diaryContent = document.getElementById('diaryContent').value;
        let moodContent = document.getElementById('moodContent').value;

        // 设置节点属性
        div01.setAttribute('class', 'card');
        div02.setAttribute('class', 'content01');
        div03.setAttribute('class', 'content02');
        lbl01.setAttribute('style', 'font-weight: bold');
        lbl02.setAttribute('style', 'font-weight: bold');
        a.setAttribute('href', '#');
        del.setAttribute('class', 'del');
        del.setAttribute('onclick', 'deleteCard(this)');

        // 设置节点的值
        h3.innerText = diaryYear + "-" + diaryMonth + "-" + diaryDay;
        p01.innerText = diaryContent;
        p02.innerText = moodContent;
        a.innerText = "更多内容";
        del.innerText = "删除记录";

        // 组装节点元素
        cardContainer.appendChild(div01);
        div01.appendChild(div02);
        div01.appendChild(div03);
        div02.appendChild(h3);
        div02.appendChild(lbl01);
        div02.appendChild(p01);
        div02.appendChild(lbl02);
        div02.appendChild(p02);
        div03.appendChild(a);
        div03.appendChild(br);
        div03.appendChild(del);

        // 渲染卡片的玻璃效果
        VanillaTilt.init(document.querySelectorAll(".card"),{
            max: 3,    // 最大倾斜度数
            speed: 330, // 倾斜转换的速度
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
