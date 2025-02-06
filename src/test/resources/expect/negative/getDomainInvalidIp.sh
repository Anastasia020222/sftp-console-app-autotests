#!/usr/bin/expect

set host "172.29.159.27"
set port 22
set userName "usersftp"
set password "usersftp"

set domain "get_domain"
set ip "192.168.0.8"

spawn mvn exec:java

expect "Введите хост сервера:"
send "$host\r"

expect "Введите порт сервера:"
send "$port\r"

expect "Введите имя пользователя:"
send "$userName\r"

expect "Введите пароль:"
send "$password\r"

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "get_domain\r"

expect "Введите ip адрес:"
send "$ip\r"

expect {
  "Домен с $ip адресом не был найден" {
    send_error "Домен с $ip адресом не был найден\n"
    exit 1
  }
}