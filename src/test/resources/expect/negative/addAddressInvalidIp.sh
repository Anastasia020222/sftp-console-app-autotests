#!/usr/bin/expect

set host "172.29.159.27"
set port 22
set username "usersftp"
set password "usersftp"

set domain "first.domain"
set ip "192.346.0.1"

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
  "Число 346 выходит за пределы диапазона от 0 до 255." {
    send_error "Число 346 выходит за пределы диапазона от 0 до 255.\n"
    exit 1
  }
}