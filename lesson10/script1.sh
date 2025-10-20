#!/bin/bash

MYFOLDER="$HOME/myfolder"

# создаем директорию myfolder
if [ ! -d "$MYFOLDER" ]; then
mkdir -p "$MYFOLDER"
echo "директория $MYFOLDER создана"
else
echo "диреткория $MYFOLDER уже существует и это не ошибка"
fi

# файл 1 - имеет две строки: 1) приветствие, 2) текущее время и дата
FILE1="$MYFOLDER/file_1"
echo "ПРЕВЕД МЕДВЕД!!1!ОДЫН" > "$FILE1"
echo "$(date '+%Y-%m-%d %H:%M:%S')" >> "$FILE1"
echo "файл $FILE1 с приветствие и текущей датой/временем создан"

# файл 2 - пустой файл с правами 777
FILE2="$MYFOLDER/file_2"
> "$FILE2"
chmod 777 "$FILE2"
echo "файл $FILE2 с правами 777 создан"

# файл 3 - одна строка длиной в 20 случайных символов
FILE3="$MYFOLDER/file_3"
tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 20 > "$FILE3"
echo "файл $FILE3 с 20тью случайными символами создан"

# файлы 4, 5 - пустые файлы
FILE4="$MYFOLDER/file_4"
FILE5="$MYFOLDER/file_5"
touch "$FILE4"
touch "$FILE5"
echo "файл $FILE4 и $FILE5 пустые, созданы"