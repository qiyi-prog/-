# 外卖点餐应用 - HarmonyOS

## 项目介绍

这是一个基于 HarmonyOS 的外卖点餐应用，用户可以浏览餐品、添加到购物车、查看购物车内容并结算。

## 功能特性

✅ **餐品浏览** - 分类展示不同餐品  
✅ **购物车功能** - 添加/删除餐品，控制数量  
✅ **实时价格计算** - 自动计算购物车总价  
✅ **购物车弹窗** - 点击头像查看购物车详情  
✅ **清空购物车** - 一键清空所有餐品  
✅ **网络请求** - 使用 Network Kit 获取后端数据  

## 项目结构

```
├── entry/src/main/
│   ├── ets/
│   │   ├── MainAbility/
│   │   │   └── MainAbility.ets          # 主能力类
│   │   ├── pages/
│   │   │   └── FoodOrderPage.ets        # 主页面
│   │   ├── components/
│   │   │   ├── FoodList.ets             # 食品列表组件
│   │   │   ├── FoodItem.ets             # 食品项组件
│   │   │   └── ShoppingCart.ets         # 购物车弹窗组件
│   │   ├── models/
│   │   │   └── FoodModel.ets            # 数据模型
│   │   └── services/
│   │       └── ApiService.ets           # 网络请求服务
│   ├── resources/
│   │   └── base/
│   │       └── colors.json              # 颜色资源
│   └── module.json5                     # 模块配置
└── README.md                            # 本文件
```

## 主要技术点

### 1. 网络权限申请

在 `module.json5` 中配置网络权限：

```json
"permissions": [
  "ohos.permission.INTERNET",
  "ohos.permission.GET_NETWORK_INFO"
]
```

### 2. 网络请求

使用 Network Kit 发送 GET 请求获取餐品数据：

```typescript
let httpRequest = http.createHttp();
httpRequest.request(url, {
  method: http.RequestMethod.GET,
  connectTimeout: 5000,
  readTimeout: 5000
});
```

### 3. 状态管理

使用 ArkUI 状态装饰器管理应用状态：

- `@State` - 组件级状态
- `@Link` - 状态传递
- `@ObjectLink` - 对象属性监听
- `@Prop` - 只读属性

### 4. 组件通信

通过函数回调进行组件间通信，实现数据和事件的双向流动。

## 使用方法

### 1. 环境准备

- DevEco Studio 4.0 或更高版本
- HarmonyOS SDK 5.0 或更高版本
- 鸿蒙模拟器

### 2. 启动后端服务

确保后端服务运行在 `http://127.0.0.1:3000`

```bash
node server.js  # 或你的启动命令
```

### 3. 后端接口格式

`GET /data/foods` 返回格式：

```json
[
  {
    "tag": "98147100",
    "name": "杂粮主食",
    "foods": [
      {
        "id": 4056954171,
        "name": "五常稻花香米饭",
        "like_ratio_desc": "",
        "month_saled": 1000,
        "unit": "约300克",
        "food_tag_list": [],
        "price": 5,
        "picture": "http://127.0.0.1:3000/static/7.jpeg",
        "description": "浓浓的稻米清香，软糯Q弹有嚼劲",
        "tag": "热销",
        "count": 120
      }
    ]
  }
]
```

### 4. 运行应用

1. 在 DevEco Studio 中打开项目
2. 连接鸿蒙模拟器
3. 点击 **Run** 按钮编译并运行
4. 应用将自动加载餐品列表

## 功能演示

### 主要页面流程

1. **应用启动** → 自动加载餐品数据
2. **浏览餐品** → 左侧分类，右侧列表
3. **添加购物车** → 点击 **+** 按钮
4. **查看购物车** → 点击底部外卖员头像
5. **清空购物车** → 点击购物车中的"清空"按钮

## 注意事项

⚠️ **后端地址** - 确保修改 `ApiService.ets` 中的 `BASE_URL` 为正确的后端地址

⚠️ **网络权限** - 应用需要 INTERNET 和 GET_NETWORK_INFO 权限

⚠️ **图片加载** - 图片地址必须是��访问的 HTTP URL

## 常见问题

**Q: 为什么加载不出数据？**

A: 
1. 检查后端服务是否正在运行
2. 确认后端地址是否正确（`http://127.0.0.1:3000`）
3. 检查应用是否有网络权限
4. 查看模拟器网络设置

**Q: 如何修改后端地址？**

A: 编辑 `entry/src/main/ets/services/ApiService.ets`，修改 `BASE_URL` 变量。

**Q: 如何添加更多颜色？**

A: 编辑 `entry/src/main/resources/base/colors.json`，添加新的颜色对象。

## 学习目标

通过本项目，你将学到：

✓ 网络权限的申请和配置  
✓ 使用 Network Kit 发送网络请求  
✓ ArkUI 组件化开发  
✓ 状态管理和组件通信  
✓ 列表和网格布局  
✓ 触摸事件处理  
✓ 弹窗和动画效果  

## 许可证

Apache License 2.0

## 联系方式

- GitHub: [@qiyi-prog](https://github.com/qiyi-prog)
