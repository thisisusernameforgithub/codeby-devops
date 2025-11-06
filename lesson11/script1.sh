#!/bin/bash

# константы
readonly MYFOLDER="$HOME/myfolder"
readonly TEXT="ПРЕВЕД МЕДВЕД!!1!ОДЫН"
readonly TIMESTAMP='+%Y-%m-%d %H:%M:%S'
readonly PERMISSION=777
readonly RANDOM_LENGTH=20
readonly CHARSET='A-Za-z0-9'

# проверяем существование директории перед ее созданием. -d проверяет наличие директории, а ! инвертирует результат
if [ ! -d "$MYFOLDER" ]; then
    # mkdir -p создает все промежуточные директории если нужно + не выдает ошибку в случае, если директория уже существует
    mkdir -p "$MYFOLDER"
    echo "директория $MYFOLDER создана"
else
    echo "директория $MYFOLDER уже существует и это не ошибка"
fi

# приветствие и
FILE1="$MYFOLDER/file_1"

# > перезаписывает файл полностью и старое содержимое удаляется
echo "$TEXT" > "$FILE1"

# >> добавляет строку в конец файла без удаления предыдущего содержимого. date форматирует текущую дату и время в читаемый вид
# shellcheck disable=SC2005
echo "$(date "$TIMESTAMP")" >> "$FILE1"
echo "файл $FILE1 с приветствием и текущей датой/временем создан"

# файл создается пустым с максимальными правами
FILE2="$MYFOLDER/file_2"

# > создает пустой файл или очищает уже существующий
# shellcheck disable=SC2188
> "$FILE2"

# 777 дает всем права на чтение/запись/выполнение
chmod "$PERMISSION" "$FILE2"
echo "файл $FILE2 с правами $PERMISSION создан"

# файл заполняется случайными символами
FILE3="$MYFOLDER/file_3"

# /dev/urandom генерирует случайные байты. tr фильтрует только буквы и цифры, а остальное дропает. head -c 20 берет первые 20 символов из потока
tr -dc "$CHARSET" < /dev/urandom | head -c "$RANDOM_LENGTH" > "$FILE3"
echo "файл $FILE3 с $RANDOM_LENGTH случайными символами создан"

# эти два файлы просто пустышки
FILE4="$MYFOLDER/file_4"
FILE5="$MYFOLDER/file_5"

# создает пустой файл
touch "$FILE4"
touch "$FILE5"
echo "файлы $FILE4 и $FILE5 пустые, созданы"
