# Описание работы проекта с автотестами.

В данном проекте реализованы тесты для проверки консольного приложения sftp-console-app.

Проект использует java версии 11, т.к. в java версии 8 возникали проблемы с поддержкой более новой версии testNG.

В директории ```/src/test/resources/expect/``` хранятся позитивные и негативные сценарии expect скриптов.

В директории ```/test/java/tests``` храниться код с тестами.

В директории ```src/test/resources/testng.xml``` хранится файл testng.xml для управления запуском тестов testng.

## Настройка проекта

1. Скачать данный проект из репозитория https://github.com/Anastasia020222/sftp-console-app-autotests .
В проекте в папке lib хранятся jar файлы с проектами клиента и автотестов

2. Указать путь до файла .json с доменами на sftp-сервере
Перейти в pom.xml и заменить в поле ```<sftp.path></sftp.path>``` строку на ваш путь до файла

3. Нужно перейти в expect скрипты и заменить значения host, port, username, password на свои актуальные.
Этот пункт к сожалению не удалось доработать. В будущем можно попробовать данные параметры передавать при запуске программы
и производить авторизацию перед запуском тестов.

Команда для запуска jar-файла из корня директории проекта:

```java -cp lib/out/artifacts/autotest_console_app_jar/autotest-console-app.jar org.testng.TestNG src/test/resources/testng.xml```

## Описание тестов:
### Позитивные тесты:

Класс ```ConsoleAppPositiveTest``` содержит следующие тесты:

1) ```checkAddAddressDomain``` - Проверяем добавление новой записи
   Шаги:
1. Подключение к sftp-серверу
2. Ввод команды add
3. Ввод имени домена
4. Ввод ip адреса
5. Ввод команды list
6. Сравнение полученного списка доменов из пункта 5 с ожидаемым
   Постусловие:
   Удаление созданной записи
   Ожидаемый результат: Добавляемая запись была добавлена в список и при
   запросе командой list получаем добавленную запись.

2) ```checkGetAddressDomain``` - Проверяем получение домена
    Шаги:
1. Подключение к sftp-серверу
2. Ввод команды get_domain
3. Ввод ip адреса
   Ожидаемый результат: Вывод сообщения: Домен с ip адресом $ip:.*

3) ```checkDeleteAddressDomain``` - Проверка удаления записи
    Шаги:
1) Подключение к sftp-серверу
2) Добавление новой записи
3) Ввод команды delete
4) Ввод имени домена
5) Ввод ip адреса
6) Ввод команды list
7) Получение данные и поиск отсутствия записи
   Ожидаемый результат: Домен не совпал с ожидаемыми доменами. Домен удален

### Негативные тесты.

   Класс ```ConsoleAppNegativeTest``` содержит следующие тесты:
1) ```getDomainInvalidIp``` - Получение домена по несуществующему ip адресу в файле.
   Шаги:
1. Подключение к sftp-серверу
2. Введение команды get_domain
3. Введение ip адреса, которого нет в файле
   Ожидаемый результат: Вывод ошибки “Домен с ip адресом не был
   найден”

2) addAddressExitDomain - Добавление записи с существующим доменом в
   файле
   Шаги:
1. Подключение к sftp-серверу
2. Введение команды add
3. Введение имени домена существующего в файле
4. Введение ip адреса существующего в файле
   Ожидаемый результат: Вывод ошибки “Домен $domain уже есть,
   попробуйте заново”

3) ```addAddressInvalidIp``` - Добавление записи с невалидным ip адресом
   Шаги:
1. Подключение к sftp-серверу
2. Ввод команды add
3. Введение имени домена
4. Ввод невалидного ip адреса (с числом выходящим за границы 255)
   Ожидаемый результат: Вывод ошибки “Число n выходит за пределы
   диапазона от 0 до 255
