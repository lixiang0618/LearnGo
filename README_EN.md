
# LearnGo 🎓🐶
<div align="center">

[![中文](https://img.shields.io/badge/语言-中文-blue)](README.md)
&nbsp; | &nbsp;
[![English](https://img.shields.io/badge/Language-English-red)](README_EN.md)

</div>

> **LearnGo** is derived from the homophonic term "Lazy Dog." It is a subject knowledge assistant app based on Retrieval-Augmented Generation (RAG) that helps users quickly access relevant subject knowledge, generate intelligent and beautiful notes, perform real-time object recognition and translation, and accumulate vocabulary during their learning process after logging in. The app integrates multiple advanced technologies to provide a personalized learning experience.

> Because the author is just a lazy dog, HeHeHeHe....
---
```commandline
         Why are you waking me up so early!? 
        　　　∩∩
        　　（´･ω･）
        　  ＿|　⊃／(＿＿_
        　／ └-(＿＿＿_／
        　￣￣￣￣￣￣￣             Never mind, I'll go back to sleep ~~~
                                　　 ⊂⌒／ヽ-、＿_
                                　／⊂_/＿＿＿＿ ／
                                　￣￣￣￣￣￣￣
```

```
                        .----.                 |  I'm
                     _.'__    `.               |  at
                 .--(Lazy)(Dog)---/#\          |  Hua
               .' @          /###\             |  Shi
               :         ,   #####             |  Want
                `-..__.-' _.-\###/             |  to
                      `;_:    `"'              |  Skip          
                    .'"""""`.                  |  Class
                   /,  Lazy  ,\                |  and
                  //   Dog   \\                |  Go
                  `-._______.-'                |  Play
                  ___`. | .'___                | Holy
                 (______|______)               | Moly
```

---

## 📋 Table of Contents
1. [📱 App Overview](#app-overview)
2. [🎥 Project Showcase](#project-showcase)
3. [✨ Main Features](#main-features)
   - [📚 Subject Knowledge Assistant](#subject-knowledge-assistant)
   - [📝 Intelligent Note Generation Assistant](#intelligent-note-generation-assistant)
   - [🌍 AR Real-Time Recognition and Translation Assistant](#ar-real-time-recognition-and-translation-assistant)
   - [🔐 Login and Settings Features](#login-and-settings-features)
4. [🛠️ Technical Choices](#technical-choices)
   - [🔍 Prompt Engineering](#prompt-engineering)
   - [🔗 RAG Technology](#rag-technology)
   - [🖋️ OCR Optical Text Extraction](#ocr-optical-text-extraction)
   - [🎤 Speech Recognition](#speech-recognition)
   - [📄 Document Processing](#document-processing)
5. [🧑‍💻 Speech Recognition Programming Ideas](#speech-recognition-programming-ideas)
6. [🚀 Future Plans](#future-plans)
7. [🎥 Project Showcase](#project-showcase)

---

## App Overview
**LearnGo** is an all-in-one learning tool designed to enhance learning efficiency, with the following key features:
- Subject knowledge assistant based on Retrieval-Augmented Generation
- Supports speech recognition and real-time object translation
- Automatically generates intelligent notes and outputs them in Markdown format
- Supports document upload and OCR text extraction
- Multi-language input, local data encryption

---

## Feature Showcase
<img src="https://th.bing.com/th/id/OIP.QxSecOb9VIQgAVd9YwFtLAHaHa?w=179&h=180&c=7&r=0&o=5&dpr=2&pid=1.7" alt="视频图标" width="30" height="30">Detailed video feature demonstration：https://www.bilibili.com/video/BV1onyJYKEvf


> ### Login and Signup
> ![Login and Signup](Resources/LoginAndSignup%20-original-original.gif)

> ### Settings Page
> ![Settings Page](Resources/Setting%20-original-original.gif)

> ### Subject Chat Assistant
> ![Subject Chat Assistant](Resources/SuperChat%20-original-original.gif)

> ### Note Organization Assistant
> ![Note Organization Assistant](Resources/SuperNote%20-original-original.gif)

> ### AR Translation Assistant
> ![AR Translation Assistant](Resources/SuperScan%20-original-original.gif)

---

## Main Features
### Subject Knowledge Assistant
LearnGo provides powerful subject knowledge support by integrating various technologies, allowing users to interact with the subject assistant in the corresponding chat window.
#### Technical Choices
- **Prompt Engineering**: Optimizes model responses using a few-shot approach and Chain-of-Thought (CoT) technique.
- **RAG Technology**: Uses GraphRAG (TBD) and Embedding technology for knowledge retrieval.
- **OCR Optical Text Extraction**: Uses Optical Character Recognition technology to extract text from uploaded documents.
- **Speech Recognition**: Utilizes Apple's speech framework for voice input.
- **Document Processing**: Parses PDF documents using PDFKit.

#### Feature Overview
1. Users can interact with different subject assistants, such as asking "What is Prisoner's Dilemma?" in the game theory chat window.
2. The subject assistant will prioritize matching the established knowledge base and provide answers tailored to the user's needs using Prompt Engineering.
3. Supports uploading PDF files, where the system will extract text content through OCR for problem-solving.
4. Supports multi-language input.
5. Supports permanent local storage of chat history.

### Intelligent Note Generation Assistant
Generates high-quality study notes using a fine-tuned LLM.
#### Technical Choices
- **Fine-Tuning LLM**: Uses 150 selected notes to fine-tune the model, improving note quality.
- **OCR**: Extracts text from uploaded documents and generates notes based on keywords.
- **Prompt Engineering**: Optimizes the note format to ensure clear output structure.

#### Feature Overview
1. Users can jot down brief note keywords during lectures.
2. After the class, they can upload a PDF version of the course materials (lecture PPT or e-book).
3. By clicking generate, the app will organize the notes into a beautiful and well-structured format.
4. Supports multiple export formats, including saving images to the photo album and other file formats.

### AR Real-Time Recognition and Translation Assistant
Uses the camera for real-time object recognition and translates object names (in English) into Traditional and Simplified Chinese.
#### Technical Choices
- **Machine Learning Models**: MobileNetV2 and YOLOv3
- **Translation Dictionary**: CC-CEDICT Dictionary.

#### Feature Overview
> Currently, for easier testing, image recognition is used in the early development phase. Video recognition will be included in the future. The pronunciation feature is also integrated but not available on the simulator.
1. Users can choose the appropriate media (currently photos) and see it in the preview frame.
2. After confirming Scan, the two models will recognize the object's name (in English).
3. The recognized object name will then be translated into Traditional and Simplified Chinese.
4. Clicking on the name will play the corresponding language pronunciation (Cantonese for Traditional, Mandarin for Simplified).

### Login and Settings Features
#### Technical Choices:
- SettingUI: Uses an open-source component ([GitHub Link](https://github.com/aheze/Setting)).
- Login Page Design: Inspired by a video tutorial ([YouTube Link](https://www.youtube.com/watch?v=g4FeOJfAS-4&t=929s)).
#### Feature Overview:
1. Users need to log in each time they reopen the app. For first-time installations or sharing chat records, registration is required. Registration involves filling in Email, FullName, and Password. If an Email is detected locally, the system prompts the user to log in directly; otherwise, it indicates successful registration.
2. On the login screen, if the Email and password do not match, the user is prompted with a login failure. If they match, the user is welcomed and directed to the chat window selection page after 0.3 seconds.
3. Upon logging in, users see a bottom navigation bar including (SuperChat, SuperNote, SuperScan, Setting), corresponding to (RAG-based subject knowledge assistant, fine-tuned LLM intelligent note assistant, real-time object recognition and translation assistant, and settings page). Clicking takes the user to the respective page.
4. When clicking Setting, the settings page appears, showing the user's profile including avatar, FullName, and Email. Below are two buttons: "Allow Notifications" and "Change Theme." The first toggles notifications, while the second opens a widget for selecting "Day" or "Night" mode. The default is "Day," but switching to "Night" adjusts all page colors for nighttime use. The page also includes links to "Terms of Service," "Privacy & Security," and "About the App," which provide detailed information when clicked.

---

## Technical Choices
### Prompt Engineering
- **Few-Shot Prompt Engineering**: Provides several examples to guide the LLM in understanding the question format and desired response style.
- **Chain-of-Thought (CoT)**: Breaks down complex problems into sub-problems to guide the LLM in providing structured responses.

### RAG Technology
- **GraphRAG**: Enhances retrieval using knowledge graphs, treating knowledge pieces as nodes and relationships as edges.
> '''However, this technology is costly and is yet to be integrated. Currently, embedding (see below) is mainly used for retrieval.'''
- **Embedding Technology**: Converts text segments in the knowledge base into vector representations for retrieval using cosine similarity.

### OCR Optical Text Extraction
- Uses PDFKit and Vision frameworks to extract text from uploaded documents.
- Performs image preprocessing for complex documents


### Speech Recognition
- Employs Apple's Speech framework.
- Supports different languages and dialects, including Mandarin, Cantonese, and Japanese.

### Document Processing
- Uses PDFKit and custom tools to parse PDF documents.

---

### Speech Recognition Programming Ideas
1. **Import Frameworks**: Include the `Speech` and `AVFoundation` frameworks in the project.
2. **Request Permissions**: Use `SFSpeechRecognizer.requestAuthorization` to request speech recognition permission.
3. **Create an Audio Session**: Configure the audio session to optimize recording quality.
4. **Initialize the Recognition Request**: Create a `SFSpeechAudioBufferRecognitionRequest` object and set up audio input.
5. **Create the Recognition Task**: Use `SFSpeechRecognizer` to perform the speech recognition task.
6. **Handle Recognition Results**: Pass the recognized text to the input field in the system.
7. **Error Handling**: Prompt the user to restart recognition or adjust the noise environment if necessary.
---

## Future Plans
- Allow users to customize subjects and upload materials to build a personal knowledge base.
- Update the knowledge base to support more subjects and fields.
- Improve OCR accuracy to support more types of document formats.
- Add the ability for users to customize note templates or styles.
- Support speech recognition and translation for more languages.
---

## Project Showcase
<img src="https://th.bing.com/th/id/OIP.QxSecOb9VIQgAVd9YwFtLAHaHa?w=179&h=180&c=7&r=0&o=5&dpr=2&pid=1.7" alt="视频图标" width="30" height="30">Detail video for user：https://www.bilibili.com/video/BV1onyJYKEvf

---

