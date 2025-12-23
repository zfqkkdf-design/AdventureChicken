# Архитектура папок для векторной графики (SVG)

Эта папка содержит структуру для организации векторных файлов, которые заменят растровые текстуры (PNG).

## Структура папок:

```
вектор/
├── ui/                    # UI элементы интерфейса
│   ├── buttons/          # Кнопки (пауза, меню, настройки)
│   ├── icons/            # Иконки (яйца, семена, сердечки)
│   └── controls/         # Элементы управления (стрелки, джойстики)
│
├── game_objects/         # Игровые объекты
│   ├── player/          # Спрайты игрока
│   ├── obstacles/       # Препятствия (земля, воздух)
│   └── collectibles/    # Собираемые предметы (яйца, семена)
│
├── environment/          # Окружение
│   ├── sunmoon/         # Солнце и луна
│   ├── clouds/         # Облака
│   ├── background/     # Фоновые элементы
│   └── ground/         # Элементы земли/дороги
│
└── menu/                # Элементы меню
    ├── logo/           # Логотипы
    ├── buttons/        # Кнопки меню
    └── backgrounds/    # Фоны меню
```

## Текущие текстуры для замены:

### UI элементы (assets/ui/):
- `Group 811.png` → `ui/buttons/pause_button.svg`
- `Group 821.png` → `ui/controls/arrows.svg`

### Игровые объекты (assets/obstacle bonus/):
- `image 1951.png` → `game_objects/collectibles/egg.svg`
- `Group 823.png` → `game_objects/collectibles/seed.svg`

### Окружение (assets/sunmoon/):
- `Group 822.png` → `environment/sunmoon/sun.svg`
- `Group 830.png` → `environment/sunmoon/moon.svg`

### Окружение (assets/background/background game/):
- `Group (5).png` → `environment/clouds/cloud.svg`

### Меню паузы (assets/background/pause/):
- `Group 814.png` → `ui/buttons/restart_button.svg`
- `Group 815 (1).png` → `ui/buttons/home_button.svg`
- `Group 818.png` → `ui/buttons/resume_button.svg`

## Инструкции:

1. Загружайте SVG файлы в соответствующие папки согласно их назначению
2. Используйте понятные имена файлов на английском языке
3. После загрузки файлов они будут интегрированы в проект
4. Старые PNG текстуры можно будет удалить после проверки работоспособности

## Требования к SVG файлам:

- Формат: SVG 1.1 или выше
- ViewBox должен быть установлен для правильного масштабирования
- Рекомендуется использовать относительные единицы
- Цвета можно задавать через fill и stroke
- Размеры должны соответствовать оригинальным текстурам или быть масштабируемыми

