# CodeMagic CI/CD Setup для ChickenAdventure

Инструкция по настройке автоматической сборки Android release APK и AAB в CodeMagic.

## Предварительные требования

1. Аккаунт в CodeMagic
2. Репозиторий проекта на GitHub/GitLab/Bitbucket
3. Release keystore файл (`-release.keystore`)

## Шаг 1: Настройка переменных окружения в CodeMagic

В настройках проекта CodeMagic (Settings → Environment variables) создайте следующие переменные:

### Обязательные переменные:

- **`KEYSTORE_PASSWORD`** — пароль от keystore файла
- **`KEY_ALIAS`** — алиас ключа в keystore
- **`KEY_PASSWORD`** — пароль от ключа (может совпадать с `KEYSTORE_PASSWORD`)

### Опциональные переменные:

- **`GODOT_VERSION`** — версия Godot (по умолчанию: `4.2.2`)

**Важно:** Все пароли должны быть зашифрованы (CodeMagic автоматически шифрует значения переменных).

## Шаг 2: Загрузка Secure File (keystore)

1. Перейдите в **Settings → Secure files**
2. Нажмите **Upload file**
3. Загрузите файл `-release.keystore`
4. Запомните имя файла (в нашем случае это `-release.keystore`)
5. В настройках workflow (`codemagic.yaml`) убедитесь, что в секции `android_signing` указано:
   ```yaml
   android_signing:
     - keystore_reference
   ```

**КРИТИЧЕСКИ ВАЖНО:** 
- ❌ **НЕ коммитьте** `*.jks` или `*.keystore` файлы в репозиторий
- ✅ Храните keystore **только** как Secure file в CodeMagic
- ✅ Сделайте резервную копию keystore в безопасном месте (если потеряете — не сможете обновлять приложение в Google Play)

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
├── android_signing/          # Папка для keystore (создаётся автоматически на CI)
│   └── -release.keystore    # Копируется из Secure files на CI (НЕ в репо!)
├── build/                    # Папка для артефактов (игнорируется git)
├── codemagic.yaml            # Конфигурация CI/CD
├── export_presets.cfg        # Настройки экспорта Godot
└── project.godot             # Проект Godot
```

## Что нельзя коммитить

Следующие файлы/папки **НЕ должны** попадать в репозиторий:

- `*.jks`, `*.keystore` — keystore файлы
- `build/`, `bin/`, `dist/` — папки с артефактами сборки
- `*.apk`, `*.aab` — собранные приложения
- `.godot/`, `.import/` — кэш Godot
- `.mono/` — кэш Mono (если используется)

Все эти пути уже добавлены в `.gitignore`.

## Troubleshooting

### Ошибка: "Keystore file not found"
- Убедитесь, что загрузили keystore как Secure file
- Проверьте, что в `codemagic.yaml` указана секция `android_signing`

### Ошибка: "KEYSTORE_PASSWORD environment variable is not set"
- Создайте переменную окружения `KEYSTORE_PASSWORD` в настройках проекта

### Ошибка при экспорте: "Invalid keystore"
- Проверьте правильность паролей и алиаса
- Убедитесь, что keystore файл не повреждён

### APK/AAB не создаётся
- Проверьте логи сборки на наличие ошибок
- Убедитесь, что версия Godot в `GODOT_VERSION` соответствует версии проекта
- Проверьте, что export templates установлены корректно

## Дополнительная информация

- [CodeMagic Documentation](https://docs.codemagic.io/)
- [Godot Export Documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)

