# CodeMagic CI/CD Setup для ChickenAdventure

Инструкция по настройке автоматической сборки Android release APK и AAB в CodeMagic.

## Предварительные требования

1. Аккаунт в CodeMagic
2. Репозиторий проекта на GitHub/GitLab/Bitbucket
3. Release keystore файл (`-release.keystore`)

## Шаг 1: Загрузка keystore через Code signing identities

**ВАЖНО:** Используйте **Code signing identities**, а НЕ Secure files!

1. Перейдите в **Settings → Code signing identities**
2. Нажмите **Add identity**
3. Выберите **Android keystore**
4. Загрузите файл `-release.keystore`
5. Введите:
   - **Keystore password** — пароль от keystore
   - **Key alias** — алиас ключа
   - **Key password** — пароль от ключа (может совпадать с keystore password)

**КРИТИЧЕСКИ ВАЖНО:** 
- ❌ **НЕ коммитьте** `*.jks` или `*.keystore` файлы в репозиторий
- ✅ Храните keystore **только** в Code signing identities в CodeMagic
- ✅ Сделайте резервную копию keystore в безопасном месте (если потеряете — не сможете обновлять приложение в Google Play)

### Что делает CodeMagic автоматически

После загрузки keystore через Code signing identities, CodeMagic автоматически создаёт переменные окружения:

- `CM_KEYSTORE_PATH` — путь к keystore файлу
- `CM_KEYSTORE_PASSWORD` — пароль от keystore
- `CM_KEY_ALIAS` — алиас ключа
- `CM_KEY_PASSWORD` — пароль от ключа

**Вам НЕ нужно создавать эти переменные вручную!**

## Шаг 2: Настройка export_presets.cfg (один раз, локально)

В Godot Editor (локально):

1. Откройте **Project → Export**
2. Добавьте пресет **Android**
3. Настройте два пресета:
   - **"Android APK"** — для APK файла
   - **"Android AAB"** — для AAB файла (Google Play)
4. В настройках Android:
   - Включите **Use custom keystore**
   - Укажите путь к keystore (например, `res://android_signing/-release.keystore`)
   - Заполните alias и пароли **любыми заглушками** (они не используются на CI)
5. Сохраните `export_presets.cfg`
6. Закоммитьте `export_presets.cfg` **БЕЗ реального keystore файла**

**Важно:** На CI Godot использует Gradle signing через переменные CodeMagic, а не значения из `export_presets.cfg`. Поэтому заглушки в пресетах не критичны.

## Шаг 3: Запуск сборки

1. Перейдите в **Builds** в CodeMagic
2. Выберите workflow **`android-release`**
3. Нажмите **Start new build**
4. Выберите ветку/коммит для сборки

## Шаг 4: Получение артефактов

После успешной сборки:

1. Перейдите на страницу завершённого билда
2. В секции **Artifacts** скачайте:
   - `build/ChickenAdventure-release.apk` — APK файл
   - `build/ChickenAdventure-release.aab` — AAB файл (для Google Play)

## Структура проекта

```
AdventureChicken/
├── android_signing/          # Папка для keystore (создаётся на CI)
│   └── .gitkeep             # Пустая папка в репозитории
│   └── release.jks          # Keystore копируется сюда на CI (НЕ коммитится!)
├── keystore.properties      # Создаётся на CI с паролями (НЕ коммитится!)
├── build/                    # Папка для артефактов (игнорируется git)
├── codemagic.yaml            # Конфигурация CI/CD
├── export_presets.cfg        # Настройки экспорта Godot (путь к keystore указан)
└── project.godot             # Проект Godot
```

## Что нельзя коммитить

Следующие файлы/папки **НЕ должны** попадать в репозиторий:

- `*.jks`, `*.keystore` — keystore файлы
- `keystore.properties` — файл с паролями (создаётся только на CI)
- `build/`, `bin/`, `dist/` — папки с артефактами сборки
- `*.apk`, `*.aab` — собранные приложения
- `.godot/`, `.import/` — кэш Godot
- `.mono/` — кэш Mono (если используется)

Все эти пути уже добавлены в `.gitignore`.

## Как это работает

1. **Локально:** В `export_presets.cfg` указан путь к keystore (`res://android_signing/release.jks`) с пустыми паролями/алиасом
2. **На CI:** 
   - CodeMagic создаёт переменные `CM_KEYSTORE_PATH`, `CM_KEYSTORE_PASSWORD`, `CM_KEY_ALIAS`, `CM_KEY_PASSWORD`
   - Шаг "Prepare Android signing" копирует keystore из CodeMagic в `android_signing/release.jks`
   - Создаётся `keystore.properties` с паролями для Gradle
3. **При экспорте:** Godot находит keystore по пути из `export_presets.cfg` и использует его для подписи

**Преимущества этого подхода:**
- ✅ Не нужно патчить `export_presets.cfg` на CI через sed
- ✅ Keystore и пароли создаются только на CI, не коммитятся
- ✅ Работает стабильно между версиями Godot
- ✅ Keystore хранится безопасно в CodeMagic
- ✅ Нет риска случайно закоммитить keystore или пароли

## Troubleshooting

### Ошибка: "Keystore file not found"
- Убедитесь, что загрузили keystore через **Code signing identities** (НЕ Secure files!)
- Проверьте, что keystore правильно настроен в настройках проекта

### Ошибка при экспорте: "Invalid keystore"
- Проверьте правильность паролей и алиаса в Code signing identities
- Убедитесь, что keystore файл не повреждён

### APK/AAB не создаётся
- Проверьте логи сборки на наличие ошибок
- Убедитесь, что версия Godot в `GODOT_VERSION` соответствует версии проекта
- Проверьте, что export templates установлены корректно
- Убедитесь, что имена пресетов точно: **"Android APK"** и **"Android AAB"**

### APK/AAB не подписан
- Убедитесь, что keystore загружен через Code signing identities
- Проверьте, что в `export_presets.cfg` включено **Use custom keystore** для обоих пресетов

## Дополнительная информация

- [CodeMagic Documentation](https://docs.codemagic.io/)
- [CodeMagic Android Code Signing](https://docs.codemagic.io/code-signing/android-code-signing/)
- [Godot Export Documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)
