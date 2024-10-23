# Setup

**Lưu ý**: Project sử dụng flutter phiên bản `3.22.3`. Chạy `flutter pub get` trước khi làm những bước dưới

## 1. Chạy build runner để tạo các file json parse support

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## 2. Setup đa ngôn ngữ

- Chạy lệnh sau để tạo file key:

```bash
dart run easy_localization:generate -S assets/translations -O lib/app/localization -o locale_keys.g.dart -f keys
```

## 3. set up CLI

```bash
dart pub global activate flutterfire_cli
```

## 4. Setup Mason (Tuỳ chọn)

- Dùng mason để tạo GetX Page nhanh hơn. [Xem chi tiết tại đây](/mason.md)

# Code format setting

## Với VSCode

- Formatting code: Mặc định của VSCode.
- Thêm đoạn mã sau vào `.vscode/settings.json` (nếu chưa có thì tạo folder `.vscode` sau đó tạo file `settings.json`) để sắp xếp thứ tự import và format code không xuống dòng:

```json
{
  "editor.codeActionsOnSave": {
    "source.organizeImports": "always"
  },
  "dart.lineLength": 200,
  "editor.formatOnSave": true,
  "editor.formatOnType": true,
  "editor.selectionHighlight": false,
  "editor.suggestSelection": "first",
  "editor.tabCompletion": "onlySnippets",
  "editor.wordBasedSuggestions": "currentDocument"
}
```

## JetBrains IDE

- Vào `Settings` tìm `Code Style` và thay đổi `Line Length` thành **200** như hình:

![alt text](https://github.com/user-attachments/assets/515ebe76-c2a9-4382-8911-80062a11382e)

## Quy tắc và quy ước

Coding convention: https://dart.dev/effective-dart/style

1. **Cách đặt tên:**

   - Đặt tên English, có ý nghĩa.
   - Theo chuẩn của Dart:
     - Class: `UpperCamelCase`
     - File: `lowercase_with_underscores`
     - Variable: `lowerCamelCase`

2. **Sử dụng `private` với các hàm, biến chỉ sử dụng trong Class:**

   - Ví dụ: biến `count` chỉ sử dụng trong Class thì khai báo: `int _count;`

3. **Không sử dụng prefix:**

   - Good: `defaultTimeout`
   - Bad: `kDefaultTimeout`

4. **Sử dụng đóng mở ngoặc ở các đoạn mã `if/else`:**

   - Good:
     ```dart
     if (isWeekDay) {
       print('Bike to work!');
     } else {
       print('Go dancing or read a book!');
     }
     ```
   - Bad:
     ```dart
     if (overflowChars != other.overflowChars)
       return overflowChars < other.overflowChars;
     ```

5. **Check lint warning:** Khi save file, check tất cả các lint warning và không được để file còn lint warning.

6. **Với những mục có nhiều param thì phải thêm dấu phẩy ở cuối của param cuối để vscode auto format xuống dòng.** Ví dụ:

   - Không phẩy ở cuối:
     ```dart
     Text('welcome'.tr, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge)
     ```
   - Có phẩy ở cuối:
     ```dart
     Text(
       'welcome'.tr,
       textAlign: TextAlign.center,
       style: Theme.of(context).textTheme.headlineLarge,
     ),
     ```

7. **Tách hàm với các đoạn code dài (Đặc biệt chú ý file screen)**

8. **Chỉ sử dụng nháy đơn với String:**

   - Đúng: `'Đây là String'`
   - Sai: `"Đây là String"`

9. **Tất cả các String đều phải đặt trong file ngôn ngữ: `app/lang/vi.dart`**

10. **Tất cả constants phải đặt trong các file thuộc thư mục `app/constants`:**

    - `app_colors`: Khai báo constants mã màu `cardColor`, `schemeSeedColor`...
    - `app_nums`: Khai báo constants number `borderRadius`, `spacing`...
    - `app_strings`: Khai báo constants string `baseUrl`, `apiKey`...

11. **Cấu trúc đặt tên:**

`<Feature name>` + `<Detail (Có thể có hoặc không)>` + `<Type Class>`

- Đúng:
  - `LoginScreen` = Feature 'Login' + Type Class 'Screen'
  - `RegisterScreen` = Feature 'Register' + Type Class 'Screen'
  - `RegisterOtpScreen` = Feature 'Register' + Detail 'Otp' + Type Class 'Screen'
- Sai: `ScreenLogin`

12. **Quy ước tiền tố:**

| Loại         | Tiền tố   | Ví dụ            |
| ------------ | --------- | ---------------- |
| ảnh, sơ đồ   | `img`     | `imgContact`     |
| vector       | `svg`     | `svgContact`     |
| thumbnail    | `thumb`   | `thumbContact`   |
| banner       | `bn`      | `bnContact`      |
| button       | `btn`     | `btnContact`     |
| logo         | `logo`    | `logoContact`    |
| navi         | `nav`     | `navContact`     |
| tiêu đề      | `ttl`     | `ttlContact`     |
| text         | `txt`     | `txtContact`     |
| icon         | `icon`    | `iconContact`    |
| Background   | `bg`      | `bgContact`      |
| mũi tên      | `arrow`   | `arrowContact`   |
| line         | `line`    | `lineContact`    |
| pagetop      | `pagetop` | `pagetopContact` |
| spacer       | `spacer`  | `spacerContact`  |
| đang loading | `loading` | `loadingContact` |

13. **Chạy fix all trước khi commit**

- Phải chạy `dart fix --apply` và chạy lại code trước khi commit.
