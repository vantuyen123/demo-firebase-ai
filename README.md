# Flutter Demo AI 🤖

Ứng dụng Flutter demo tích hợp Google Generative AI (Gemini) thông qua Firebase SDK. Dự án minh họa cách xây dựng một giao diện chat thông minh với khả năng xử lý ngôn ngữ tự nhiên.

<!-- Thay thế 'demo.png' bằng đường dẫn tới file ảnh thực tế của bạn. 
     Bạn có thể dùng thẻ <img src="demo.png" width="300" /> nếu muốn chỉnh kích thước ảnh. -->
![Demo App Screenshot](demo.png)
<!-- Demo Video -->
<video src="assets/Simulator%20Screen%20Recording%20-%20iPhone%2015%20Pro%20-%202026-01-22%20at%2010.57.34.mov" controls width="300"></video>

## 🌟 Tính năng chính

* **Tích hợp Gemini:** Sử dụng model `gemini-2.5-flash` thông qua `package:firebase_ai`.
* **Giao diện Chat:** UI trực quan với bong bóng tin nhắn (User/Bot).
* **Hiệu ứng UX:** Hiển thị phản hồi của AI theo hiệu ứng máy đánh chữ (Typewriter effect).
* **Hỗ trợ Markdown:** Render văn bản định dạng đẹp mắt (đậm, nghiêng, list...) từ phản hồi của AI.
* **System Prompt:** Dễ dàng tùy chỉnh vai trò của AI (ví dụ: Chuyên gia toán học, Chuyên gia dinh dưỡng...) ngay trong code.

## 🛠 Công nghệ sử dụng

* Flutter - Framework phát triển ứng dụng đa nền tảng.
* Firebase Vertex AI - SDK để kết nối với các mô hình Gemini của Google.
* Dart - Ngôn ngữ lập trình.

## 🚀 Hướng dẫn cài đặt

### 1. Yêu cầu tiên quyết

* Flutter SDK đã được cài đặt và cấu hình môi trường.
* Một tài khoản Google/Firebase.

### 2. Thiết lập Firebase & Vertex AI

Để ứng dụng hoạt động, bạn cần kết nối với Firebase:

1. Truy cập Firebase Console và tạo một dự án mới.
2. **Quan trọng:** Nâng cấp dự án lên gói **Blaze (Pay as you go)** (Vertex AI yêu cầu gói này, tuy nhiên vẫn có hạn mức miễn phí cho việc test).
3. Vào mục **Build > Vertex AI in Firebase** và kích hoạt dịch vụ.
4. Cấu hình ứng dụng Flutter của bạn với Firebase (khuyên dùng `flutterfire_cli`):

    ```bash
    flutterfire configure
    ```

### 3. Chạy ứng dụng

Cài đặt các thư viện phụ thuộc:

```bash
flutter pub get
```

Chạy ứng dụng trên máy ảo hoặc thiết bị thật:

```bash
flutter run
```
