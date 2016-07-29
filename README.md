# flashpark
一款基于即时通讯的停车app 项目
已经完成基础页面部分搭建 
一．项目界面架构
1.	ThirdLibs 三方库集成 ，目前只有支付宝支付
2.	MyTools  工具类目  
3.	Ch eWeiChu (车位主)  分成车位出租，车位管理，订单管理三大模块
具体界面内容已经细化
4.	TingCheRen (停车人)分成车位筛选，车场详情，搜索结果地图界面，搜索结果列表界面，车位详情界面
5.	CeBianLan  (侧边栏) 
RePassword  (密码重置)
SendBackViewController (找回密码)
LoginVC (登陆)
Register(注册)
GeRenXinxi (个人中心)
MyWallet (我的钱包)
CheLiangGuanLiVC (车辆管理)内含分为 车辆详情，车辆认证，车辆添加
LiShiDingDanVC  (历史订单)
MySetting  (设置)
6.	MainViewController (中心界面) 实现侧滑等基本功能，主页面主要两个scrollView 切换界面
7.	BaseView  (基础界面)
MyHeader.pch  常用宏定义 以及 接口定义 
二．接口进度
现已完成用户注册模块接口全部对接完成
附近停车场参数固定值 ，附近停车场详情待测
订单列表接口完成，订单详情，支付待测
用户信息更新接口完成， 用户设置更新待测

车为主添加车位成功，具体页面需求可能另行更改（照片字段以下均不可用）
车位主查询页面地址可见 ，具体参数需要进一步添加
车为主修改页面搭建完成，接口待测
发布车位以及车位审核待测 

融云获取token 接口调试完成

三．项目依赖简介
主要采用cocoapods 导入现在流行的第三方库
现已经导入AFNetworking，
           baiduMapkit,
           GYHttpMock,
           iOS-AlipaySDK,
           MBProgressHUD
           MJRefresh
           Realm,RongCloudImKit,SDWebImage 
现己经集成百度地图，融云即时通讯，Realm 轻量级数据库
