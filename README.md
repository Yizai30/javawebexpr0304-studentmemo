### 学生备忘录

#### 编写目的

<u>*帮助开发人员理解项目的业务逻辑*</u>

#### 术语描述

#### 项目概述

大学阶段是人们真正步入社会的过渡期，大学生在学习知识之外，更重要的是学会如何应对来自于外界的信息，如何调整自己的生活节奏或生活方式，从而能够更快地适应新的生活环境，面对新的挑战。大学生们日常会接触到<u>*各种各样的活动宣传，不定时的课程调整通知，纷繁庞杂的新鲜知识，各型各色的娱乐方式*</u>。现如今互联网生态日趋成熟，对于当代大学生来说，每天需要从来自于网络的海量信息中，筛选出具备较高的价值的，能够为自己提供帮助的内容，是比较困难的。与此同时，还面会临着如何规划好**课程、课业、课外学习、娱乐放松、人际交往、职业**等方面的安排的压力。

#### 项目目标

学生备忘录旨在帮助大学生们记录下自己的各种想法、各种目标，以实现更合理的自我调整和规划，学会如何分清主次，做好取舍。

- 用户友好（操作简朴，用色清新）
- 拒绝PVP

- 保证颜值

#### 需求分析



#### 总体设计

##### 系统功能概述（条纹列述）

##### 系统功能总图（模块结构图）

#### 模块详细设计

##### 后端组织

###### Servlet

- `LoginServlet`
- `RegisterServlet`
- `IndexServlet`
- `RecordServlet`

###### 数据库（DAO）

- 用户表（ID、用户名、性别、年龄、邮箱）
- 密码表（ID、用户名、密码）
- 日记录表（ID、用户名、创建时间、截止时间、记录内容、是否完成）
- 

##### 前端页面

- 登录页面（背景有动效）
- 注册页面（背景有动效）

- 主页（显示当天日期、时间），可跳转到日记录编辑页（通过点击下拉框中的链接），触发下拉框的文本为”今天做些什么好呢？“，下拉框中的链接文本为”编辑事件“。

- 日记录编辑页（以卡片形式展示，按时间的临近程度顺序排列，时间精确到天，卡片上有`更多内容`链接和`删除记录`按钮），点击网页右上角的添加按钮，弹出交互式窗口，读取用户输入的截止时间，以及事件内容，交互式窗口右下角包括关闭和保存按钮。

#### 编码规范

#### 软件测试