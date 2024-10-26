# LearnGo 🎓🐶

---
<div style="text-align: center; margin: 20px 0; border: 1px solid #dcdcdc; border-radius: 10px; background-color: #f9f9f9; padding: 15px;">
    <h3 style="color: #ff4500;">⚠️ 注意事项</h3>
    <ul style="list-style-type: none; padding: 0; font-size: 16px;">
        <li>- 本项目为华中师范大学信息管理学院移动应用开发课程的 <strong>期末作品</strong></li>
        <li>- <strong>仅用作学习交流</strong></li>
        <li>- <strong>本人不为该项目用于任何非经过本人同意的途径所产生的风险负责。</strong></li>
    </ul>
</div>

---



<div align="center">

[![中文](https://img.shields.io/badge/语言-中文-blue)](README.md)
&nbsp; | &nbsp;
[![English](https://img.shields.io/badge/Language-English-red)](README_EN.md)

</div>

> **LearnGo** 源自谐音【懒狗】，是一款基于增强检索生成 (RAG) 的学科知识助手应用，旨在帮助用户在登录后的学习过程中快速获取相关学科的知识、生成智能精美笔记、实时物体识别翻译并积累词汇。应用整合了多项先进技术，提供个性化的学习体验。

> 因为作者就是懒狗 嘻嘻 
---
```commandline
         没早八叫我起床干嘛！？ 
        　　　∩∩
        　　（´･ω･）
        　  ＿|　⊃／(＿＿_
        　／ └-(＿＿＿_／
        　￣￣￣￣￣￣￣             没事我先睡了哈 ~~~
                                　　 ⊂⌒／ヽ-、＿_
                                　／⊂_/＿＿＿＿ ／
                                　￣￣￣￣￣￣￣
```

```
                        .----.                 |  我
                     _.'__    `.               |  在
                 .--(懒)(狗)---/#\              |  华
               .' @          /###\             |  师
               :         ,   #####             |  很
                `-..__.-' _.-\###/             |  想
                      `;_:    `"'              |  翘          
                    .'"""""`.                  |  课
                   /,  懒  ,\                  |  出
                  //   狗   \\                 |  去
                  `-._______.-'                |  玩
                  ___`. | .'___                | Holy
                 (______|______)               | Moly

```

---


## 📋 目录
1. [📱 App 概述](#app-概述)
2. [🎥 项目展示](#项目展示)
3. [✨ 主要功能](#主要功能)
   - [📚 学科知识助手](#学科知识助手)
   - [📝 智能笔记生成助手](#智能笔记生成助手)
   - [🌍 AR实时识别翻译助手](#ar实时识别翻译助手)
   - [🔐 登录与设置功能](#登录与设置功能)
4. [🛠️ 技术选型](#技术选型)
   - [🔍 Prompt Engineering](#prompt-engineering)
   - [🔗 RAG 技术](#rag-技术)
   - [🖋️ OCR 光学文本提取](#ocr-光学文本提取)
   - [🎤 语音识别](#语音识别)
   - [📄 文档处理](#文档处理)
5. [🧑‍💻 语音识别编程思路](#语音识别编程思路)
6. [🚀 未来规划](#-未来规划)



---

## App 概述
<div style="background-color: #f0f8ff; padding: 20px; border-radius: 10px; border: 1px solid #dcdcdc;">
    <h2 style="color: #2e8b57; text-align: center;">LearnGo</h2>
    <p style="font-size: 18px; text-align: center;">
        <strong>LearnGo</strong> 是一款集多种功能于一体的学习工具，旨在提升用户的学习效率，主要特点包括：
    </p>
    <ul style="font-size: 16px; line-height: 1.6; margin-top: 10px;">
        <li>📚 基于增强检索生成的学科知识助手</li>
        <li>🎤 支持语音识别和实时物体翻译</li>
        <li>📝 自动生成智能笔记并以 <strong>Markdown</strong> 格式输出渲染</li>
        <li>📄 支持文档上传和 <strong>OCR</strong> 文字提取</li>
        <li>🌐 多语言输入、本地存储加密数据</li>
    </ul>
</div>


---

## 功能展示
<div style="text-align: center; margin-top: 30px;">
    <a href="https://www.bilibili.com/video/BV1onyJYKEvf" style="display: inline-block; padding: 15px 25px; background-color: #f0f8ff; border: 2px solid #1e90ff; border-radius: 12px; text-decoration: none; color: #1e90ff; font-size: 20px; font-weight: bold; box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1); transition: transform 0.2s, box-shadow 0.2s;">
        <img src="https://th.bing.com/th/id/OIP.QxSecOb9VIQgAVd9YwFtLAHaHa?w=179&h=180&c=7&r=0&o=5&dpr=2&pid=1.7" alt="视频图标" width="35" height="35" style="vertical-align: middle; margin-right: 12px;">
        视频详细功能演示
    </a>
</div>

<table align="center">
    <tr>
        <td align="center">
            <strong>登陆注册</strong><br>
            <img src="Resources/LoginAndSignup -original-original.gif" alt="登录注册">
        </td>
        <td align="center">
            <strong>设置页面</strong><br>
            <img src="Resources/Setting -original-original.gif" alt="设置页面">
        </td>
    </tr>
    <tr>
        <td align="center">
            <strong>学科聊天助手</strong><br>
            <img src="Resources/SuperChat -original-original.gif" alt="学科聊天助手">
        </td>
        <td align="center">
            <strong>笔记整理助手</strong><br>
            <img src="Resources/SuperNote -original-original.gif" alt="笔记整理助手">
        </td>
    </tr>
    <tr>
        <td align="center">
            <strong>AR翻译助手</strong><br>
            <img src="Resources/SuperScan -original-original.gif" alt="AR翻译助手">
        </td>
        <td align="center">
            <strong>完整功能演示视频</strong><br>
            <a href="https://www.bilibili.com/video/BV1onyJYKEvf" target="_blank">
                点击查看哔哩哔哩视频
            </a>
        </td>
    </tr>
</table>

---

## 主要功能
### 学科知识助手
通过整合多种技术，LearnGo 提供了强大的学科知识支持，用户可以通过选择对应学科的聊天窗口与该学科助手进行交互。
#### 技术选型
- **Prompt Engineering**: 使用少量示例和思维链 (CoT) 技术优化模型响应。
- **RAG 技术**: 采用 GraphRAG（待定） 和嵌入 (Embedding) 技术进行知识检索。
- **OCR 光学文本提取**: 利用光学字符识别技术提取上传文档的文本。
- **语音识别**: 使用 Apple 的语音框架进行语音输入。
- **文档处理**: 利用 PDFKit 进行 PDF 文档的解析。

#### 功能概述
1. 用户可与不同学科的助手互动，例如在博弈论聊天窗口提问【What is Prison Dilemma?】。
2. 学科助手会优先匹配已建立的知识库，结合 Prompt Engineering 提供符合用户需求的回答。
3. 支持上传 PDF 文件，系统将通过 OCR 提取文本内容并用于问题解答。
4. 支持多语言输入。
5. 支持本地永久存储聊天记录。

### 智能笔记生成助手
通过微调后的 LLM 生成高质量的学习笔记。
#### 技术选型
- **Fine-Tuning LLM**: 利用 150 份精选笔记微调模型，提升生成笔记的质量。
- **OCR**: 提取上传文档的文本，结合关键词生成笔记。
- **Prompt Engineering**: 优化笔记的格式，确保输出内容结构清晰。

#### 功能概述
1. 用户可以在课堂上记录琐碎的笔记关键字。
2. 课后选择该堂课的资料PDF格式文件上传（授课的PPT或是电子书）。
3. 点击生成就可以整理出十分精美和有条理的笔记。
4. 支持多种格式导出，可以导出图片到相册，也可以保存为其他文件。


### AR实时识别翻译助手
调用摄像头实时识别物体，并对物体名称（英文）翻译成【繁体中文】与【简体中文】。
#### 技术选型
- **机器学习模型**: MobileNetV2 和 YOLOv3
- **翻译词典**: CC-CEDICT 词典。

#### 功能概述
> 前期开发为了方便测试，目前使用的是图片识别，视频识别已经放在前瞻功能之中使用。
> 点击发音的功能也已经集成但是模拟器中不可用。
1. 用户可以选择合适的媒体（目前是照片），在预览框中可见。
2. 确认Scan后两个模型会分别给出识别到的物体名称（英文）。
3. 同时会将MobileNetV2识别出的物体名称分别翻译为繁体中文和简体中文。
4. 同时点击名称会呈现单词的对应语言发音。（繁中->粤语 简中->普通话）


### 登录与设置功能
#### 技术选型：
- SettingUI: 使用开源组件（[GitHub链接](https://github.com/aheze/Setting)）。
- 登录页面设计: 参考视频教程（[YouTube链接](https://www.youtube.com/watch?v=g4FeOJfAS-4&t=929s)）。
#### 功能概述： 
1. 用户每次重新打开 App 都需要登录，如果是第一次安装或想共享聊天记录，需要进行注册。注册时需填写 Email、FullName 和 Password。如果检测到本地已有注册的 Email，系统会提示用户直接登录，反之则提示注册成功。
2. 在登录界面，如果密码和 Email 不匹配，会有提示登录失败，匹配成功则欢迎用户并在 0.3 秒后跳转至聊天窗口选择页面。
3. 登录完成后，用户会看到底部导航栏，包括（SuperChat、SuperNote、SuperScan、Setting），分别对应（基于增强检索生成(RAG)的学科知识助手、基于微调 LLM 的智能笔记生成助手、基于实时物体识别与翻译的单词积累助手、设置页面）。点击即可进入相应页面。
4. 用户点击 Setting 时可进入设置页面，顶部显示用户信息简介，包括头像、FullName 和 Email。下方有两个按钮【允许通知】和【改变主题】。点击前者可开关通知，后者会弹出小组件，供用户选择【Day】或【Night】主题模式。默认为【Day】主题，切换为【Night】主题后，所有页面配色会适应夜晚使用。页面下方还有【服务条款】、【隐私和安全】、【关于App】的链接，点击可查看详细信息。


---

## 技术选型
### Prompt Engineering
- **Few-Shot Prompt Engineering**: 提供多个示例以引导 LLM 理解问题的格式和期望回答风格。
- **Chain-of-Thought (CoT)**: 将复杂问题分解为子问题，逐步引导 LLM 提供结构化的回答。

### RAG 技术
- **GraphRAG**: 使用知识图谱增强检索，将知识片段作为节点，节点间的关系作为边。
> '''但此项技术花费较高，目前待整合。目前主要还是基于Embedding（见下）进行检索。'''
- **嵌入 (Embedding) 技术**: 将知识库中的文本段落转换为向量表示，通过余弦相似度进行检索。

### OCR 光学文本提取
- 使用 PDFKit 和 Vision 框架提取上传的文档文本。
- 对复杂文档进行图像预处理，如二值化和去噪。

### 语音识别
- 使用 Apple 的语音框架实现语音输入。
- 支持多种不同语言，方便不同地区的用户使用。
> 目前支持的语言：粤语、英语、普通话（Cantonese、English、Mandarin）
- 实时监听语音识别结果，并将识别的文本经过Prompting整理传递给 LLM 处理。

### 文档处理
- 使用 PDFKit 解析 PDF 文件并提取文本内容。
- 支持对标注和注释的处理。



### 语音识别编程思路
1. **导入框架**: 在项目中引入 `Speech` 和 `AVFoundation` 框架。
2. **请求权限**: 使用 `SFSpeechRecognizer.requestAuthorization` 请求语音识别权限。
3. **创建音频会话**: 配置音频会话，优化录音效果。
4. **初始化识别请求**: 创建 `SFSpeechAudioBufferRecognitionRequest` 对象并配置音频输入。
5. **识别任务的创建**: 使用 `SFSpeechRecognizer` 执行语音识别任务。
6. **处理识别结果**: 将识别出的文本传递给系统中的输入框。
7. **故障处理**: 提示用户重新启动识别或调整音噪环境。

---

## 🌟 未来规划

[//]: # (<h2>🌟 未来规划</h2>)
<div style="border: 2px solid #4CAF50; padding: 10px; border-radius: 8px; background-color: #f9f9f9;">
    <p><strong>⭕️ 未完成 | 🔄 进行中 | ✅ 已完成</strong></p>
    <ul style="list-style: none; padding-left: 0;">
        <li>⭕️ <strong>增加用户自定义学科并由用户上传资料建立个人知识库。</strong></li>
        <li>⭕️ <strong>对知识库进行更新以支持更多的学科和领域。</strong></li>
        <li>✅ <strong>提升 OCR 精度，支持更多种类的文档格式。</strong></li>
        <li>🔄 <strong>增加用户自定义笔记模板或风格的功能。</strong></li>
        <li>🔄 <strong>支持更多语种的语音识别和翻译。</strong></li>
    </ul>
</div>


---



希望这款应用能为您的学习生活带来便捷的体验！
