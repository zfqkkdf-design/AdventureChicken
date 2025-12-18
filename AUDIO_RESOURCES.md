# Руководство по добавлению звуков и музыки

## Бесплатные ресурсы без авторских прав (Royalty-Free)

### Рекомендуемые сайты:

#### 1. **OpenGameArt.org** (Рекомендуется)
- URL: https://opengameart.org
- Лицензия: CC0, CC-BY, CC-BY-SA
- Качество: Высокое
- Бесплатно: Да
- Регистрация: Не требуется (но рекомендуется)
- **Лучший выбор для игровых звуков**

#### 2. **Freesound.org**
- URL: https://freesound.org
- Лицензия: CC0, CC-BY, различные
- Качество: От среднего до высокого
- Бесплатно: Да (с ограничениями без регистрации)
- Регистрация: Рекомендуется для лучшего доступа
- **Отличный выбор для звуковых эффектов**

#### 3. **Pixabay Music**
- URL: https://pixabay.com/music
- Лицензия: Pixabay License (можно использовать в коммерческих проектах)
- Качество: Хорошее
- Бесплатно: Да
- Регистрация: Не требуется
- **Лучший выбор для фоновой музыки**

#### 4. **Mixkit.co**
- URL: https://mixkit.co/free-stock-music/
- Лицензия: Mixkit License (бесплатная для коммерческого использования)
- Качество: Хорошее
- Бесплатно: Да
- Регистрация: Не требуется
- **Удобный интерфейс для поиска**

#### 5. **Incompetech (Kevin MacLeod)**
- URL: https://incompetech.com/music/royalty-free/
- Лицензия: Creative Commons
- Качество: Профессиональное
- Бесплатно: Да (требуется указание авторства)
- Регистрация: Не требуется
- **Классическая библиотека для игр**

#### 6. **Zapsplat.com**
- URL: https://www.zapsplat.com
- Лицензия: ZapSplat Standard License (бесплатная для коммерческого использования)
- Качество: Профессиональное
- Бесплатно: Да (требуется бесплатная регистрация)
- Регистрация: Требуется (бесплатно)
- **Огромная библиотека профессиональных звуков**

---

## Какие звуки нужны для игры

### Звуковые эффекты (Sound Effects):
1. **jump.ogg** - Звук прыжка курицы
2. **duck.ogg** - Звук наклона/приседания
3. **collect_egg.ogg** - Сбор яйца (приятный звук)
4. **collect_seed.ogg** - Сбор семечка (приятный звук)
5. **hit.ogg** - Столкновение с препятствием
6. **game_over.ogg** - Game Over звук

### Фоновая музыка (Background Music):
1. **bg_music.ogg** - Основная фоновая музыка (должна зацикливаться)
   - Ритмичная, энергичная музыка для раннера
   - Подходящие стили: chiptune, 8-bit, upbeat electronic, cheerful

---

## Рекомендуемые поисковые запросы

### Для звуковых эффектов:
- "chicken jump" / "bird jump"
- "collect coin" / "pickup item"
- "game hit" / "damage sound"
- "game over" / "fail sound"
- "whoosh" (для duck)

### Для музыки:
- "chiptune" / "8-bit"
- "runner game music"
- "upbeat electronic"
- "happy game music"
- "endless runner background"

---

## Структура папок

Создайте следующую структуру в проекте:

```
assets/
├── audio/
│   ├── music/
│   │   └── bg_music.ogg
│   └── sfx/
│       ├── jump.ogg
│       ├── duck.ogg
│       ├── collect_egg.ogg
│       ├── collect_seed.ogg
│       ├── hit.ogg
│       └── game_over.ogg
```

---

## Формат файлов

### Рекомендуемый формат: **OGG Vorbis**
- Меньший размер файла
- Хорошее качество сжатия
- Поддерживается Godot

### Альтернативы:
- **WAV** - Без сжатия, высокое качество, больший размер
- **MP3** - Поддерживается, но OGG предпочтительнее

### Настройки для OGG:
- **Музыка**: Стерео, качество 4-5 (хороший баланс размер/качество)
- **Звуковые эффекты**: Моно или стерео, качество 4-6

---

## Как конвертировать аудио в OGG

### Онлайн конвертеры:
1. CloudConvert: https://cloudconvert.com
2. Convertio: https://convertio.co
3. Online-Convert: https://www.online-convert.com

### Desktop приложения:
1. **Audacity** (бесплатно) - https://www.audacityteam.org
2. **FFmpeg** (командная строка)

### Пример конвертации через FFmpeg:
```bash
# Конвертация в OGG Vorbis
ffmpeg -i input.wav -codec:a libvorbis -qscale:a 5 output.ogg

# Для музыки (стерео, качество 4)
ffmpeg -i input.mp3 -codec:a libvorbis -qscale:a 4 output.ogg

# Для звуков (моно, качество 5)
ffmpeg -i input.wav -ac 1 -codec:a libvorbis -qscale:a 5 output.ogg
```

---

## Интеграция в Godot

### Шаги:

1. **Создайте папки**:
   - `assets/audio/music/`
   - `assets/audio/sfx/`

2. **Импортируйте файлы**:
   - Перетащите файлы в Godot
   - Godot автоматически создаст `.import` файлы

3. **Настройки импорта**:
   - Выберите файл в FileSystem
   - В Import tab установите:
     - **Loop**: Включить для музыки, выключить для звуков
     - **Format**: OGG Vorbis (если еще не OGG)
     - **Loop Offset**: 0 (для музыки с циклом)

4. **Добавьте AudioStreamPlayer узлы**:
   - В сцене Game.tscn добавьте:
     - `AudioStreamPlayer` для фоновой музыки (имя: MusicPlayer)
     - `AudioStreamPlayer` для звуковых эффектов (имя: SFXPlayer)

---

## Быстрый старт - Рекомендуемые треки

### Для быстрого тестирования, можно использовать:

1. **Музыка**:
   - Pixabay → Поиск: "8-bit music" или "chiptune"
   - Incompetech → Категория "Game" → "8-Bit March" или похожие

2. **Звуки**:
   - OpenGameArt → Поиск: "jump", "coin", "hit"
   - Freesound → Поиск: "chicken", "jump", "collect"

---

## Лицензии - Важно!

При использовании звуков убедитесь:

1. **CC0** - Можно использовать без указания авторства (лучший вариант)
2. **CC-BY** - Требуется указание авторства
3. **CC-BY-SA** - Требуется указание авторства и сохранение лицензии

### Где указывать авторство:
- В README.md проекта
- В меню настроек игры
- В описании в магазинах приложений

---

## Пример файла credits.txt

Создайте файл `CREDITS.md` в корне проекта:

```markdown
# Audio Credits

## Music
- Background Music: [Название] by [Автор] (CC-BY / CC0)

## Sound Effects
- Jump sound: [Название] by [Автор] (CC-BY / CC0)
- Collect sound: [Название] by [Автор] (CC-BY / CC0)
- ...
```

---

## Следующие шаги

После загрузки звуков:
1. Создайте структуру папок
2. Загрузите файлы в папки
3. Проверьте импорт в Godot
4. Добавьте AudioStreamPlayer узлы в сцены
5. Интегрируйте звуки в код (см. следующий файл)

---

## Полезные ссылки

- [Godot Audio Documentation](https://docs.godotengine.org/en/stable/classes/class_audiostreamplayer.html)
- [OpenGameArt Audio Search](https://opengameart.org/art-search-advanced?keys=&field_art_type_tid%5B%5D=13)
- [Freesound Browse](https://freesound.org/browse/)
- [Pixabay Music](https://pixabay.com/music/)

