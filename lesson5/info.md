Создать в своем репозитории ветку lesson5 и в корне репозитория папку lesson5 для сохранения результатов домашнего задания.

1. Разместить в папку файл answers.md следующего содержания (вместо символов --- вписать ответ на вопрос):

```text
1. What is the decimal equivalent of 01001010?
Your Answer: ---
2. How many subnets and how many hosts in subnet are there for the network
address 80.160.0.0/20?
Your Answer: ---
3. What is the last usable host address of prefix 182.144.10.0/29?
Your Answer: ---
4. IP address 10.145.100.6/27 is a part of which host range?
Your Answer: ---
5. How many IP addresses can be assigned to hosts, for Subnet Mask
255.255.255.02
Your Answer: ---
6. If you need to have 5 subnets, which subnet mask do you use?
Your Answer: ---
7. What is the broadcast address of prefix 172.18.16.0/21?
Your Answer: ---
```

2. Создать 2 ВМ: client и server (Пример реализации)
   - Запретить входящий ICMP трафик на server с помощью IPTables
   - Разрешить входящие SSH подключения от client к server, через конфигурацию SSH
   - Загрузить конфигурации в репозиторий
3. Создать 2 ВМ: client и server (Пример реализации)
   - Настроить OpenVPN server на server
   - Настроить OpenVPN client на client, подключить его к серверу
   - Настроить доступ клиента в Интернет только через подключение к серверу через OpenVPN
   - Загрузить конфигурации в репозиторий

> **После того, как куратор примет работу, не забудьте в ответ на задание отправить сообщение «Д/З зачтено в GitHub репозитории куратором».**
