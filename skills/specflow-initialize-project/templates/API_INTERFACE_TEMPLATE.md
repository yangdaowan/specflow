# <功能名称> — 接口文档

> 依据 GB/T 8567-2006《计算机软件文档编制规范》编制。
> 生成日期：YYYY-MM-DD | 来源：`.specflow/specs/active/<feature-name>/SPEC.md`

## 1. 接口概览

| 接口路径 | 方法 | 鉴权 | 用途 |
|----------|------|------|------|
| <路径> | GET/POST/PUT/DELETE | <JWT / API Key / 无> | <业务用途> |

## 2. 接口详情

### 2.1 <接口名称>

#### 请求
- **方法**：<GET / POST>
- **路径**：`<完整路径>`
- **Headers**：
  | Header | 值 | 必填 |
  |--------|-----|------|
  | Authorization | Bearer <token> | 是 |
  | Content-Type | application/json | 是 |

- **Query Parameters**（如适用）：
  | 参数 | 类型 | 必填 | 说明 |
  |------|------|------|------|
  | <参数> | <类型> | 是/否 | <说明> |

- **Request Body**（如适用）：
  ```json
  {
    "field1": "value1",
    "field2": "value2"
  }
  ```

  | 字段 | 类型 | 必填 | 说明 |
  |------|------|------|------|
  | field1 | string | 是 | <说明> |
  | field2 | number | 否 | <说明> |

#### 响应

- **Success (200)**：
  ```json
  {
    "code": 0,
    "data": {},
    "message": "ok"
  }
  ```

- **Error (4xx/5xx)**：

  | 状态码 | 错误码 | 说明 |
  |--------|--------|------|
  | 400 | INVALID_PARAM | <参数校验失败> |
  | 401 | UNAUTHORIZED | <未登录或 Token 过期> |
  | 403 | FORBIDDEN | <权限不足> |
  | 404 | NOT_FOUND | <资源不存在> |
  | 500 | INTERNAL_ERROR | <服务器内部错误> |

## 3. 调用时序

> 文字描述跨接口的调用顺序。

1. <步骤1：调用哪个接口>
2. <步骤2：拿到返回后做什么>
3. <步骤3：调用下一个接口>

## 4. 安全鉴权说明
- 认证方式：<JWT / OAuth2.0 / Session>
- 权限粒度：<接口级 / 数据级>
- Token 刷新策略：<自动刷新 / 过期重新登录>
- 频率限制：<如适用>

> ---
> *本文档由 SpecFlow `specflow-generate-deliverables` 自动生成。*
> *缺失信息已标注 `[待补充]`，请人工审核后补全。*
