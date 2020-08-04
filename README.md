基于ThinkPHP 6.0、Redis、Layui的在线练习系统
===============

> 该教程使用thinkphp6作为web端的后端开发框架，使用layui来布局页面的样式，通过redis来处理代码的判断流程，目前可以支持php代码的判断，可以参照B站的视频教程学习 https://www.bilibili.com/video/BV1ha4y1E76t/ 

## 安装、配置

第一步、将 tp_gojc.sql 导入到你所使用的MySQL数据库中

第二步、需要在 config 目录中配置你的数据库以及调试信息

第三步、修改app\common.php 文件，替换成你的邮箱、密码

第四步、配置 app 目录下面的三个 task 文件，具体操作可以按照视频来学习

第五步、配置你的定时任务，参考视频

第六步、将该代码部署到你的网站上就可以了哈
