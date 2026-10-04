# Endfield Hide UID

终末地左下角 UID 隐藏 MOD，适用于 **Rocket 管理器 / XXMI 的 EFMI（DirectX 11）**。

只需一个 `mod.ini`。无需 DLL、插件加载器、菜单或快捷键；启用后自动隐藏。

## 安装

从 [Releases](https://github.com/VannilaCat/Endfield-HideUID/releases) 下载并解压，把 `HideUID` 文件夹导入 Rocket，归类到终末地的“终末地其他”并启用，然后通过 Rocket 启动游戏。

也可以手动把该文件夹放入 EFMI 的 `Mods` 目录；游戏已运行时按 `F10` 重新加载。

Rocket 的典型目录：`Rocket 管理器/backing/Mods/AE/终末地其他/HideUID/`。

## 停用 / 卸载

在 Rocket 中停用本 MOD，或者删除 `HideUID` 文件夹，然后按 `F10` 重新加载。无需修改游戏目录。

## 范围

- 隐藏普通游戏 HUD **左下角 UID 文本**，保留旁边的 Ping 和其他 HUD。
- 通过 ShaderRegex 给原始文字着色器添加局部像素裁剪，保留原来的文字渲染逻辑，不包含游戏原始着色器或资源。
- 需要 EFMI 和 DirectX 11；Vulkan 下不会生效。
- 不是全界面账号信息过滤器，不保证个人资料页、登录页或其他位置的 UID 都隐藏。
- 自定义 UI 缩放、宽屏比例或版本更新导致 UID 位置变化时，可以修改 `mod.ini` 顶部的 `$left / $right / $top / $bottom`。数值为屏幕宽高的比例，原点在左上角。
- 与同样修改主 UI 文字着色器的 MOD 可能冲突，避免同时启用多个 UID / HUD 隐藏 MOD。

## 技术资料

目标文字着色器：`8241579e34ea6fc2`。该标识由当前客户端导出的原始着色器确认；公共识别参考为 [Advanced UID & HUD Control](https://gamebanana.com/mods/657485)。本 MOD 没有复制或改编该作品的 INI、HLSL、资源或功能实现。

实现语法依据：[3DMigoto ShaderRegex 文档](https://github.com/bo3b/3Dmigoto/blob/master/Dependencies/d3dx.ini)、[EFMI](https://github.com/SpectrumQT/EFMI-Package)。

原创 INI 源码采用 MIT 许可。压缩包里的 `HideUID/mod.ini` 就是完整 MOD 源码。

## 验证

2026-10-04：在 Rocket 内置 EFMI 1.4.8、终末地 DirectX 11 客户端上验证。规则精确匹配当前客户端导出的文字着色器；安装后由用户手动按 `F10` 热重载，确认 UID 隐藏生效。

发布包只含原创 INI、说明和许可，不含 DLL、游戏文件、其他作者的 MOD、账号信息或诊断日志。
