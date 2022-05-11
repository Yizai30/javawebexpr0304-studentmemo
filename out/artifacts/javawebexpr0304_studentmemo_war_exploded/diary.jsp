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
    <title>Create My Diaries</title>
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
                <a href="#">修改内容</a><br>
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
                    <a href="#" onclick="storeDiary('${diary.id}','${diary.content}','${diary.mood}')" data-toggle="modal" data-target="#reviseModal">修改内容</a><br>
                    <a href="DeleteDiaryServlet?id=${diary.id}" class="del" onclick="if(confirm('确定删除'+'${diary.createTime}'+'的日记嘛?')==false)return false">删除日记</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<div class="container2">
    <button class="addbtn" data-toggle="modal" data-target="#addModal"></button>
</div>

<%--    模态框为当前用户添加日记    --%>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="addModalLabel" style="font-size:28px;font-weight: bold;">记录一下成长的一天</h4>
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
                    <input type="button" class="savebtn" value="添加" onclick="checkCard(this.form)"/>
                </div>
            </form>
        </div>
    </div>
</div>

<%--    模态框为当前用户修改日记    --%>
<div class="modal fade" id="reviseModal" tabindex="-1" role="dialog" aria-labelledby="reviseModalLabel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="reviseModalLabel" style="font-size:28px;font-weight: bold;">编辑内容</h4>
            </div>
            <form name="reviseForm" action="ReviseDiaryServlet" method="post">
                <div class="modal-body">
                    <%-- 设置 display: none 属性，隐藏id，使界面简洁 --%>
                    <span style="font-size:16px;font-weight: bold;margin-bottom: 6px;display: none">日记ID：</span>
                    <input id="rId" name="rId" style="border: none;outline: none;width: 30px;display: none" type="text" readonly/>
                    <p style="font-size: 16px;font-weight: bold;">日记：</p>
                    <textarea id="rDiaryContent" name="rDiaryContent" class="inputextarea"></textarea>
                    <p style="font-size: 16px;font-weight: bold;">心情：</p>
                    <textarea id="rMoodContent" name="rMoodContent" class="inputextarea"></textarea>
                </div>
                <div class="modal-footer">
                    <button type="button" class="closebtn" data-dismiss="modal">关闭</button>
                    <input type="button" class="savebtn" value="保存" onclick="checkRevise(this.form)"/>
                </div>
            </form>
        </div>
    </div>
</div>

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

    // 修改内容校验
    function checkRevise(form) {
        if (form.rDiaryContent.value === "") {
            alert("日记内容不能为空");
            form.rDiaryContent.focus();
            return false;
        }
        if (form.rMoodContent.value === "") {
            alert("心情内容不能为空");
            form.rMoodContent.focus();
            return false;
        }

        document.reviseForm.submit();
    }

    // 存储需要修改的 diary 的 id, content, mood
    function storeDiary(id, content, mood) {
        sessionStorage.setItem("rId", id);
        $('#rId').attr("value", sessionStorage.getItem("rId"));
        $('#rDiaryContent').val(content);
        $('#rMoodContent').val(mood);
    }
</script>
</body>
</html>
