# 榮和美早午餐｜前端網頁視覺設計規範 (Frontend Design System Spec)

本文件專為前端工程師（UI/UX 切版與系統架構）設計，統整「榮和美早午餐」全站視覺色彩、字體排版、CSS 變數配置及 UI 元件規範。

---

## 1. CSS 變數定義 (CSS Variables)

請直接將以下變數放入全域樣式表（`:root`）中：

```css
:root {
  /* Brand Colors */
  --color-brand-red: #B91C1C;       /* 主品牌紅：LOGO 標籤底色、主按鈕、強調標題 */
  --color-brand-red-hover: #991B1B; /* 品牌紅 Hover 狀態 */
  --color-warm-amber: #F59E0B;      /* 蛋黃暖橘：點綴、警示、評分星號、Secondary Hover */
  --color-lettuce-green: #16A34A;   /* 生菜鮮綠：蔬菜點綴、促銷標籤、狀態提示 */

  /* Neutral & Base Colors */
  --color-bg-cream: #FAF6F0;        /* 溫暖米白：網頁主背景、區塊卡片底色（取代死白） */
  --color-surface-white: #FFFFFF;   /* 純白：輸入框、彈窗、特殊卡片高光 */
  --color-text-dark: #291E1A;       /* 內文深褐：主文字、插畫深色線條（比純黑溫暖） */
  --color-text-muted: #6B5E59;      /* 次要文字：註解、描述、弱化標籤 */
  --color-border-line: #8B1E1E;     /* 線條深紅褐：外框、分割線、卡片邊框 */

  /* Typography */
  --font-heading: 'Zen Antique Soft', 'Iansui', serif;
  --font-body: 'Noto Sans TC', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;

  /* Spacing & Radii */
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 16px;
  --radius-full: 9999px;
  --border-frame: 2px solid var(--color-border-line);
}
```

---

## 2. 色彩對照表 (Color Palette & Print Values)

提供前端開發與可能需要對齊輸出印刷時的數值對照：

| 顏色名稱 | 用途說明 | HEX / Web | RGB | CMYK（印刷參考） |
| :--- | :--- | :--- | :--- | :--- |
| **Brand Red（品牌深紅）** | LOGO 標籤底色、Primary Button、強烈標題 | `#B91C1C` | `185, 28, 28` | `C:20 M:95 Y:95 K:10` |
| **Warm Amber（蛋黃暖橘）** | 蛋黃點綴色、Secondary Hover、小標籤 | `#F59E0B` | `245, 158, 11` | `C:0 M:40 Y:95 K:0` |
| **Lettuce Green（生菜鮮綠）** | 蔬菜點綴、促銷/健康標籤、次要點綴 | `#16A34A` | `22, 163, 74` | `C:80 M:0 Y:90 K:0` |
| **Background Cream（溫暖米白）** | 全站背景底色、卡片底色（取代 `#FFFFFF`） | `#FAF6F0` | `250, 246, 240` | `C:2 M:3 Y:6 K:0` |
| **Text Dark Brown（內文深褐）** | 主文字、插畫描邊線條 | `#291E1A` | `41, 30, 26` | `C:60 M:70 Y:70 K:60` |
| **Border / Line（線條深紅褐）** | 邊框線、復古招牌外框、按鈕外框 | `#8B1E1E` | `139, 30, 30` | `C:30 M:95 Y:85 K:30` |

---

## 3. 字體規範 (Typography System)

全站採用 **2 款 Google Fonts 免費商用字體**（OFL 授權）：

### 字體 CDN 引用方式
請在 HTML 的 `<head>` 中載入：
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@400;500;700&family=Zen+Antique+Soft&display=swap" rel="stylesheet">
```

### 角色分配
1. **主標題與視覺重點 (`--font-heading`)**：`'Zen Antique Soft', serif`
   - **應用場景**：Hero 大標題、菜單大類別標題（如：漢堡、蛋餅、熱食、三明治）。
   - **特色**：筆觸圓潤飽滿、帶有手寫楷書的復古溫度，呼應招牌字體風格。
2. **介面與內文閱讀 (`--font-body`)**：`'Noto Sans TC', sans-serif`
   - **應用場景**：菜單品項名稱、價格、導覽列（Navbar）、按鈕文字、營業資訊、頁尾。
   - **特色**：高辨識度、易讀性極佳，適合各尺寸螢幕。

### 字級與行高規範 (Type Scale)

| 標籤 / 類別 | Font Family | Size (Desktop) | Size (Mobile) | Weight | Line Height |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **H1 (Hero Title)** | `--font-heading` | `40px` ~ `48px` | `30px` ~ `34px` | 700 (Bold) | `1.2` |
| **H2 (Category Title)** | `--font-heading` | `26px` ~ `28px` | `22px` ~ `24px` | 700 (Bold) | `1.3` |
| **H3 (Card Title)** | `--font-body` | `18px` ~ `20px` | `16px` ~ `18px` | 600 (SemiBold) | `1.4` |
| **Body (Menu Item)** | `--font-body` | `16px` | `15px` | 400 (Regular) | `1.5` |
| **Caption (Subtext/Notes)** | `--font-body` | `13px` ~ `14px` | `12px` ~ `13px` | 400 (Regular) | `1.4` |

---

## 4. UI 元件與排版規範 (UI Components & Layout)

### 4.1. 圓形徽章分類圖示 (Category Icons)
用於分類快速導覽（例如：漢堡、熱食、三明治、蛋餅）：
- **外框規範**：外圈為雙層圓環（外粗內細，線寬約 `3px` 與 `1.5px`，顏色為 `--color-brand-red`）。
- **底圖配置**：透明去背（PNG/SVG），置於米白底色背景上。
- **下半部標籤**：使用弧形或半圓色塊，底色為 `--color-brand-red`，文字反白 (`--color-surface-white`)，使用 `--font-heading`。
- **尺寸推薦**：
  - Desktop: `140px × 140px`
  - Mobile: `80px × 80px`

### 4.2. 復古卡片與外框 (Frames & Cards)
- **背景底色**：強制使用 `--color-bg-cream` (`#FAF6F0`)，避免大面積使用 `#FFFFFF` 破壞插畫復古手感。
- **邊框樣式**：
  ```css
  .retro-card {
    background-color: var(--color-bg-cream);
    border: 2px solid var(--color-border-line);
    border-radius: var(--radius-md);
    box-shadow: 3px 3px 0px rgba(139, 30, 30, 0.15);
  }
  ```

### 4.3. 按鈕規範 (Buttons)

#### Primary Button（主要動作，如：立即點餐、查看地圖）
```css
.btn-primary {
  background-color: var(--color-brand-red);
  color: var(--color-surface-white);
  font-family: var(--font-body);
  font-weight: 500;
  padding: 10px 24px;
  border-radius: var(--radius-full);
  border: none;
  transition: background-color 0.2s ease, transform 0.1s ease;
}
.btn-primary:hover {
  background-color: var(--color-brand-red-hover);
  transform: translateY(-1px);
}
```

#### Secondary Button（次要動作，如：觀看菜單、營業時間）
```css
.btn-secondary {
  background-color: transparent;
  color: var(--color-brand-red);
  border: 2px solid var(--color-brand-red);
  font-family: var(--font-body);
  font-weight: 500;
  padding: 8px 22px;
  border-radius: var(--radius-full);
  transition: all 0.2s ease;
}
.btn-secondary:hover {
  background-color: var(--color-brand-red);
  color: var(--color-surface-white);
}
```

---

## 5. 圖檔引用與響應式建議 (Responsive & Assets)

1. **去背圖標 (Icons)**：建議輸出為透明背景 PNG 或 WebP，尺寸統一為 512×512px 原圖，透過前端 CSS 控制 `width: 100%`。
2. **主視覺橫幅 (Hero Banner)**：寬高比建議為 `16:9`，在桌機維持置中包含，手機版邊界需預留至少 `16px` 安全邊距。
3. **地圖展示區塊**：外層加上復古褐色邊框與內縮陰影，維持與選單看板相同的復古招牌風格。