## Hướng dẫn sử dụng Mason cho dự án

Hướng dẫn này sẽ giúp bắt đầu sử dụng Mason để tạo và quản lý các template code trong dự án.

### 1. Cài đặt Mason CLI:

Sử dụng lệnh sau để cài đặt Mason CLI globally trên hệ thống:

```bash
dart pub global activate mason_cli
```

### 2. Tải các Bricks đã được định nghĩa:

Lệnh `mason get` được sử dụng để tải về các bricks đã được khai báo trong file `mason.yaml` của dự án. 

Chạy lệnh sau để tải về tất cả các bricks:

```bash
mason get
```

### 3. Tạo code từ Brick:

Để tạo code từ một brick, sử dụng lệnh `mason make <tên_brick>`, ví dụ:

```bash
mason make getx_page -o ./lib/presentation/modules
```

Lệnh này sẽ:

* Tìm kiếm brick có tên `getx_page`.
* Tạo code dựa trên brick đó.
* Lưu code vào thư mục `./lib/presentation/modules`.
