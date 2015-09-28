# HeiDabai接口
----

以下参数为所有接口必传参数:

| 必传参数名 | 含义 |
| -------- | ----- |
| deviceUUID | string,设备号 |
| deviceTypeName | string,设备类型 |
| os | string,设备系统 |
| osVer | string,设备版本 |
| appVer | string,app版本号 |
| authToken | string,授权Token,除请求验证码、登录、注册、修改密码外为必传参数

以下参数为所有通用接口返回函数:

| 返回参数名 | 含义 |
| --------- | ---- |
| Code | int,对应状态码 |
| Content | string,设备类型 |
| ErrorMsg | string,错误信息 |
| ServerTime | long,当前服务器时间戳 |

状态码含义:

| 状态码 | 含义 |
|-------|-----|
| 8200 | 请求成功 |
| 8600 | 缺少参数 |
| 8700 | 服务器内部错误 |
| 8900 | 请求数据有误 |
| 9000 | 无操作权限 |

## 登录

---

### 请求验证码

地址：URL/auth/getvcode

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| mobile | string | 手机号码 |

example:

```
{	
    "mobile":"18868816591"
}
```
#### response

example:

```
{
    "Code": 8200,
    "Content": {},
    "ErrorMsg": "",
    "ServerTime": 1442296377982
}
```

---

###注册

地址：URL/auth/register

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| mobile | string | 手机号码 |
| password | string | 密码 |
| vCode | string | 验证码 |

example:

```
{
    "mobile":"18868816591",
    "vCode":"123456",
    "password":"42CA2CDB2FA9935A8E1D86E5E9993918"
}
```
#### response

| params | type | desc |
| ------ | ---- | ---- |
| AuthToken | string | 授权密令 |
| Mobile | string | 手机号 |
| NickName | string | 用户昵称 |
| UserID | int | 用户标识 |
| UserType | int | 用户类型，0为普通用户，1为商家 |

example:

```
{
    "Code": 8200,
    "Content": {
        "AuthToken": "eyJpYXQiOjE0NDIzMDIyNjYsImFsZyI6IkhTMjU2IiwiZXhwIjoxNDczODM4MjY2fQ.eyJ1aWQiOm51bGx9.Y6YudDTjpHX0yeit-OsBGexXAmubJymBJ8cT8DOWT_0",
        "Mobile": "18868816591",
        "NickName": "hdb_16591",
        "UserID": 1,
        "UserType": 0
    },
    "ErrorMsg": "",
    "ServerTime": 1442302266721
}
```

---

### 登录

地址：URL/auth/login

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| mobile | string | 手机号码 |
| password | string | 密码 |

example:

```
{
    "mobile":"18868816591",
    "password":"42CA2CDB2FA9935A8E1D86E5E9993918"
}
```
#### response

| params | type | desc |
| ------ | ---- | ---- |
| AuthToken | string | 授权密令 |
| Mobile | string | 手机号 |
| NickName | string | 用户昵称 |
| UserID | int | 用户标识 |
| UserType | int | 用户类型，0为普通用户，1为商家 |

example:

```
{
    "Code": 8200,
    "Content": {
        "AuthToken": "eyJpYXQiOjE0NDIzMDI5MjgsImFsZyI6IkhTMjU2IiwiZXhwIjoxNDczODM4OTI4fQ.eyJ1aWQiOjF9.ob-s5gvLA1d6h7_xsYro3HIGtn-2EcuZRQ86GM8E-PQ",
        "Mobile": "18868816591",
        "NickName": "hdb_16591",
        "UserID": 1,
        "UserType": 0
    },
    "ErrorMsg": "",
    "ServerTime": 1442302928803
}
```

---

### 修改密码

地址：URL/auth/changepwd

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| mobile | string | 手机号码 |
| password | string | 密码 |
| vCode | string | 验证码 |

example:

```
{
    "mobile":"18868816591",
    "vCode":"123456",
    "password":"A7DE481BCD92A946FF20C54B805C56B7"
}
```
#### response

| params | type | desc |
| ------ | ---- | ---- |
| AuthToken | string | 授权密令 |
| Mobile | string | 手机号 |
| NickName | string | 用户昵称 |
| UserID | int | 用户标识 |
| UserType | int | 用户类型，0为普通用户，1为商家 |

example:

```
{
    "Code": 8200,
    "Content": {
        "AuthToken": "eyJpYXQiOjE0NDIzMDQ0NTMsImFsZyI6IkhTMjU2IiwiZXhwIjoxNDczODQwNDUzfQ.eyJ1aWQiOjF9.S423Ww--OFEp3ao6k2uz7zx-yIIfIg15igug-IvpYzM",
        "Mobile": "18868816591",
        "NickName": "hdb_16591",
        "UserID": 1,
        "UserType": 0
    },
    "ErrorMsg": "",
    "ServerTime": 1442304453664
}
```
---
### 退出登录

地址：URL/auth/logout

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| authToken | string | 授权密令 |

example:

```
{
    "authToken":"eyJpYXQiOjE0NDIzMDQ0NTMsImFsZyI6IkhTMjU2IiwiZXhwIjoxNDczODQwNDUzfQ.eyJ1aWQiOjF9.S423Ww--OFEp3ao6k2uz7zx-yIIfIg15igug-IvpYzM"
}
```
#### response

example:

```
{
    "Code": 8200,
    "Content": {},
    "ErrorMsg": "",
    "ServerTime": 1442304619798
}
```

---
### 获取当前用户信息

地址：URL/auth/logout

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| authToken | string | 授权密令 |

example:

```
{
"authToken":"eyJleHAiOjE0NzQ5NjUyMTksImlhdCI6MTQ0MzQyOTIxOSwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjJ9.N6O20hZ0ePIQufICpTmEsuLkUcwz35RI0TbnCwQl3Ig"
}
```
#### response

| params | type | desc |
| ------ | ---- | ---- |
| AuthToken | string | 授权密令 |
| Mobile | string | 手机号 |
| NickName | string | 用户昵称 |
| UserID | int | 用户标识 |
| UserType | int | 用户类型，0为普通用户，1为商家 |
| Store | object | 拥有商铺信息，当前用户不为商家时无该字段 |
| AddressName | string | 商铺地址 |
| CreateTime | long | 创建时间 |
| Latitude | float | 经度 |
| Longitude | float | 纬度 |
| StoreID | int | 商铺ID |
| StoreName | string | 商铺名称 |


example:

```
{
    "Code": 8200,
    "Content": {
        "AuthToken": "eyJleHAiOjE0NzQ5NjUyMTksImlhdCI6MTQ0MzQyOTIxOSwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjJ9.N6O20hZ0ePIQufICpTmEsuLkUcwz35RI0TbnCwQl3Ig",
        "Mobile": "18868816592",
        "NickName": "hdb_16592",
        "Store": {
            "AddressName": "杭州市下城区和平大厦",
            "CreateTime": 1443400516000,
            "Latitude": 30.297,
            "Longitude": 30.297,
            "StoreID": 2,
            "StoreName": "优衣库"
        },
        "UserID": 2,
        "UserType": 1
    },
    "ErrorMsg": "",
    "ServerTime": 1443430867040
}
```


---
---
## 图片处理
---
### 图片上传
地址: URL/upload/upImage

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| image  | file | 图片文件 |

<div style="color:red;font-size:20px">
注:请求格式为form-data
</div>

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| url | string | 图片地址 |

example:

```
{
    "Code": 8200,
    "Content": {
        "url": "static/upload/image/welcome@2015_09_16__10_09_47.png"
    },
    "ErrorMsg": "",
    "ServerTime": 1442398187224
}
```
---
---
## 商铺
---
### 获取周围商铺列表
地址: URL/store/getstores

#### request:

| params | type | desc |
| ------ | ---- | ---- |

参数待定

example:

```

```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| AddressName | string | 商铺地址 |
| CreateTime | long | 创建时间 |
| Latitude | float | 经度 |
| Longitude | float | 纬度 |
| StoreID | int | 商铺ID |
| StoreName | string | 商铺名称 |

example:

```
{
    "Code": 8200,
    "Content": [
        {
            "AddressName": "杭州市下城区和平大厦",
            "CreateTime": 1443229911000,
            "Latitude": 30.297,
            "Longitude": 30.297,
            "StoreID": 1,
            "StoreName": "情趣用品"
        },
        {
            "AddressName": "杭州市下城区和平大厦",
            "CreateTime": 1443400516000,
            "Latitude": 30.297,
            "Longitude": 30.297,
            "StoreID": 2,
            "StoreName": "优衣库"
        }
    ],
    "ErrorMsg": "",
    "ServerTime": 1443434231361
}
```

---

### 注册商铺
地址: URL/store/regStore

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| authToken  | string | 授权密令 |
| name | string | 商家姓名 |
| idCard | string | 身份证号码 |
| businessLicense | string | 营业执照号码 |
| idCardPic | string | 身份证图片地址 |
| blPic | string | 营业执照图片地址 |
| addressName | string | 商铺地址 |
| storeName | string | 商铺名称 |
| latitude | float | 经度 |
| longitude | float | 纬度 |

example:

```
{
    "authToken": "eyJleHAiOjE0NzQ5NjUyMTksImlhdCI6MTQ0MzQyOTIxOSwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjJ9.N6O20hZ0ePIQufICpTmEsuLkUcwz35RI0TbnCwQl3Ig",
    "name":"周翔",
    "idCard":"3213123123213123123132",
    "businessLicense":"83819389129030912930123",
    "idCardPic":"E69CAAE6A087E9A298-1@1442423621763.jpg",
    "blPic":"20130816041327331@1442931380571.jpg",
    "addressName":"杭州市下城区和平大厦",
    "storeName":"优衣库",
    "latitude":120.181042,
    "longitude":30.297037
}
```

#### response:

example:

```
{
    "Code": 8200,
    "Content": {},
    "ErrorMsg": "",
    "ServerTime": 1443429316198
}
```

---

### 根据ID获取商铺信息
地址: URL/store/getstorebyid

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| storeID | int | 商铺ID |

example:

```
{
    "storeID":2
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| AddressName | string | 商铺地址 |
| CreateTime | long | 创建时间 |
| Latitude | float | 经度 |
| Longitude | float | 纬度 |
| StoreID | int | 商铺ID |
| StoreName | string | 商铺名称 |

example:

```
{
    "Code": 8200,
    "Content": {
        "AddressName": "杭州市下城区和平大厦",
        "CreateTime": 1443400516000,
        "Latitude": 30.297,
        "Longitude": 30.297,
        "StoreID": 2,
        "StoreName": "优衣库"
    },
    "ErrorMsg": "",
    "ServerTime": 1443433659452
}
```

---


### 获取商品种类列表
地址: URL/store/getproducttypelist

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| authToken  | string | 授权密令 |
| storeID | int | 商铺ID |

example:

```
{
    "authToken": "eyJleHAiOjE0NzQ5NjUyMTksImlhdCI6MTQ0MzQyOTIxOSwiYWxnIjoiSFMyNTYifQ.eyJ1aWQiOjJ9.N6O20hZ0ePIQufICpTmEsuLkUcwz35RI0TbnCwQl3Ig",
    "storeID":2
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| TypeID  | int | 种类ID |
| TypeName | string | 种类名称 |


example:

```
{
    "Code": 8200,
    "Content": [
        {
            "TypeID": 3,
            "TypeName": "新品上架"
        }
    ],
    "ErrorMsg": "",
    "ServerTime": 1443431450045
}
```

---

### 添加商品种类
地址: URL/store/addproducttype

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| authToken  | string | 授权密令 |
| storeID | int | 商铺ID |
| typeName | string | 种类名称 |

example:

```
{
    "authToken": "eyJpYXQiOjE0NDMyNTg2ODMsImFsZyI6IkhTMjU2IiwiZXhwIjoxNDc0Nzk0NjgzfQ.eyJ1aWQiOjF9.0L-DoXWQ1sN4p9ABdI64JIE82llHQMq2wJh2NzEV0GE",
    "storeID":1,
    "typeName":"休闲裤"
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| TypeID  | int | 种类ID |
| TypeName | string | 种类名称 |


example:

```
{
    "Code": 8200,
    "Content": {
        "TypeID": 4,
        "TypeName": "休闲裤"
    },
    "ErrorMsg": "",
    "ServerTime": 1443431738906
}
```

---

### 添加商品
地址: URL/store/addproduct

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| authToken  | string | 授权密令 |
| storeID | int | 商铺ID |
| productName | string | 商品名称 |
| typeID | int | 种类ID |
| mainPictureURL | string | 主要图片地址 |
| price | int | 商品价格 |
| description | string | 商品描述 |
| pictureURLs | list\<string> | 细节图片地址列表 |

example:

```
{
    "authToken": "eyJpYXQiOjE0NDMyNTg2ODMsImFsZyI6IkhTMjU2IiwiZXhwIjoxNDc0Nzk0NjgzfQ.eyJ1aWQiOjF9.0L-DoXWQ1sN4p9ABdI64JIE82llHQMq2wJh2NzEV0GE",
    "storeID":1,
    "productName":"新裤子4",
    "typeID":4,
    "mainPictureURL":"20130816041327331@1442931380571.jpg",
    "price":500,
    "description":"好衣服啊x",
    "pictureURLs":["E69CAAE6A087E9A298-1@1442423621763.jpg","20130816041327331@1442931380571.jpg"]
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| ProductID | int | 商品ID |
| ProductName | string | 商品名称 |
| MainPictureURL | string | 主要图片地址 |
| Price | int | 商品价格 |
| Description | string | 商品描述 |
| PictureURLs | list\<string> | 细节图片地址列表 |

example:

```
{
    "Code": 8200,
    "Content": {
        "Description": "好衣服啊x",
        "MainPictureURL": "20130816041327331@1442931380571.jpg",
        "PictureURLs": [
            "E69CAAE6A087E9A298-1@1442423621763.jpg",
            "small_20130816041327331@1442931380571.jpg"
        ],
        "Price": 500,
        "ProductID": 6,
        "ProductName": "新裤子4"
    },
    "ErrorMsg": "",
    "ServerTime": 1443431906226
}
```

---

### 根据商铺获取商品列表
地址: URL/store/getproductsbystore

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| storeID | int | 商铺ID |

example:

```
{
    "storeID":1
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| Type | object | 商品种类 |
| TypeID | int | 种类ID |
| TypeName | string | 种类名称 |
| ProductList | list\<object> | 某种类下的商品列表 |
| ProductID | int | 商品ID |
| MainPictureURL | string | 主要图片地址 |

example:

```
{
    "Code": 8200,
    "Content": [
        {
            "ProductList": [],
            "Type": {
                "TypeID": 1,
                "TypeName": "新品上架"
            }
        },
        {
            "ProductList": [
                {
                    "MainPictureURL": "20130816041327331@1442931380571.jpg",
                    "ProductID": 1
                }
            ],
            "Type": {
                "TypeID": 2,
                "TypeName": "皮衣"
            }
        },
        {
            "ProductList": [
                {
                    "MainPictureURL": "20130816041327331@1442931380571.jpg",
                    "ProductID": 2
                },
                {
                    "MainPictureURL": "20130816041327331@1442931380571.jpg",
                    "ProductID": 3
                },
                {
                    "MainPictureURL": "20130816041327331@1442931380571.jpg",
                    "ProductID": 4
                }
            ],
            "Type": {
                "TypeID": 4,
                "TypeName": "休闲裤"
            }
        }
    ],
    "ErrorMsg": "",
    "ServerTime": 1443432442957
}
```

---

### 根据种类获取商品列表
地址: URL/store/getproductsbytype

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| typeID | int | 种类ID |

example:

```
{
    "typeID":4
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| ProductID | int | 商品ID |
| MainPictureURL | string | 主要图片地址 |

example:

```
{
    "Code": 8200,
    "Content": [
        {
            "MainPictureURL": "20130816041327331@1442931380571.jpg",
            "ProductID": 2
        },
        {
            "MainPictureURL": "20130816041327331@1442931380571.jpg",
            "ProductID": 3
        },
        {
            "MainPictureURL": "20130816041327331@1442931380571.jpg",
            "ProductID": 4
        },
        {
            "MainPictureURL": "20130816041327331@1442931380571.jpg",
            "ProductID": 5
        },
        {
            "MainPictureURL": "20130816041327331@1442931380571.jpg",
            "ProductID": 6
        }
    ],
    "ErrorMsg": "",
    "ServerTime": 1443432795770
}
```

---

### 根据ID获取商品详情
地址: URL/store/getproductdetail

#### request:

| params | type | desc |
| ------ | ---- | ---- |
| productID | int | 商品ID |

example:

```
{
    "productID":6
}
```

#### response:

| params | type | desc |
| ------ | ---- | ---- |
| ProductID | int | 商品ID |
| ProductName | string | 商品名称 |
| MainPictureURL | string | 主要图片地址 |
| Price | int | 商品价格 |
| Description | string | 商品描述 |
| PictureURLs | list\<string> | 细节图片地址列表 |

example:

```
{
    "Code": 8200,
    "Content": {
        "Description": "好衣服啊x",
        "MainPictureURL": "20130816041327331@1442931380571.jpg",
        "PictureURLs": [
            "E69CAAE6A087E9A298-1@1442423621763.jpg",
            "small_20130816041327331@1442931380571.jpg"
        ],
        "Price": 500,
        "ProductID": 6,
        "ProductName": "新裤子4"
    },
    "ErrorMsg": "",
    "ServerTime": 1443432966691
}
```

---
