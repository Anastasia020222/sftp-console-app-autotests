#!/usr/bin/expect

set host "172.29.159.27"
set port 22
set username "usersftp"
set password "usersftp"

set domain "test.domain"
set ip "192.168.0.4"

set expected_domain {
    "Domain: first.domain, ip: 192.168.0.1"
    "Domain: second.domain, ip: 192.168.0.2"
    "Domain: third.domain, ip: 192.168.0.3"
    "Domain: test.domain, ip: 192.168.0.4"
}

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
    send_error "Ошибка: Домен $domain уже существует.\n"
    exit 1
    }
}

expect {
  "Ip адрес $ip уже есть, попробуйте заново." {
    send_error "Ошибка: Ip адрес $ip уже есть, попробуйте заново.\n"
        exit 1
    }
  }
}

expect "Домен $domain успешно добавлен.\n"

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

foreach line $domain_lines {
    set line [string trim $line]
    set matched 0
    foreach exp $expected_domain {
        if {$line == $exp} {
            send_user "$line совпал с доменом: $exp\n"
            set matched 1
            break
        }
    }

    if {!$matched} {
        send_error "$line не совпал с ожидаемыми доменами.\n"
        exit 1
    }
}


expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "delete\r"

expect "Введите имя домена:"
send "$domain\r"

expect "Введите ip домена:"
send "$ip\r"

expect "Данные успешно удалены."

expect "Введите команду: list/get_ip/get_domain/add/delete/exit"
send "exit\r"