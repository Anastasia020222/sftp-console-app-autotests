#!/usr/bin/expect

set host "172.29.159.27"
set port 22
set username "usersftp"
set password "usersftp"

set domain "test.domain"
set ip "192.168.0.4"

set expected_domain "Domain: test.domain, ip: 192.168.0.4"

spawn mvn exec:java

expect "Введите хост сервера:"
send "$host\r"

expect "Введите порт сервера:"
send "$port\r"

expect "Введите имя пользователя:"
send "$username\r"

expect "Введите пароль:"
send "$password\r"

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "add\r"

expect "Введите имя домена:"
send "$domain\r"

expect "Введите ip домена:"
send "$ip\r"

expect {
  "Домен $domain уже есть, попробуйте заново." {
    send_error "Ошибка: Домен уже существует.\n"
    exit 1
    }
}

expect {
  "Не удалось обновить файл:*" {
    send_error "Не удалось обновить файл.\n"
        exit 1
  }
}

expect "Домен $domain успешно добавлен."

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "list\r"

expect eof

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "delete\r"

expect "Введите имя домена:"
send "$domain\r"

expect "Введите ip домена:"
send "$ip\r"

expect "Данные с доменом $domain успешно удалены."

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "list\r"

expect eof

expect "Domain:*"

set output $expect_out(buffer)

set lines [split $output "\n"]

set domain_lines {}

foreach line $lines {
    if {[string match "Domain:*" $line]} {
        lappend domain_lines $line
    }
}

send_user "Проверяем что в полученном списке $domain удален"
foreach line $domain_lines {
    set line [string trim $line]
    set matched 0
    if {$line == $expected_domain} {
      set matched 1
      send_error "$line совпал с доменом: $expected_domain. Домен не был удален\n"
      exit 1
    }

    if {!$matched} {
        send_user "$line не совпал с ожидаемыми доменами. Домен удален\n"
    }
}

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "exit\r"