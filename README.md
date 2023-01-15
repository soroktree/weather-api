Приложение реализует функционал API для статистики по погоде: 

- /weather/current - Текущая температура
- /weather/historical - Почасовая температура за последние 24 часа
- /weather/historical/max - Максимальная темперетура за 24 часа
- /weather/historical/min - Минимальная темперетура за 24 часа
- /weather/historical/avg - Средняя темперетура за 24 часа
- /weather/by_time - Найти температуру ближайшую к переданному timestamp

- Данные о погоде хранятся локально.
- Используется кэширование.

Используются следующие библиотеки:
  - rufus scheduler 
  - sidekiq 
  - Rspec
  - VCR 
  - Rails.cache
 
 

Отдельно разработал простенький фронтенд для отображения погоды с использование Hotwire
- Можно расширить функционал добавив отображения графика/диаграммы погоды за последние 24 часа

<img src="https://github.com/soroktree/HotWireShort/blob/main/app/assets/images/f1.png" alt="screenshots" style="max-width: 100%;">
