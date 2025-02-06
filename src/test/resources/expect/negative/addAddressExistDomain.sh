#!/usr/bin/expect

set host "172.29.159.27"
set port 22
set username "usersftp"
set password "usersftp"

set domain "test.domain"
set ip "192.168.0.15"

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
    send_error "Домен $domain уже есть, попробуйте заново.\n"
    exit 1
  }
}