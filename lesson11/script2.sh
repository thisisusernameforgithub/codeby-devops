#!/bin/bash

# константы
readonly FOLDER="$HOME/myfolder"
readonly SCRIPT1PATH="$HOME/script1.sh"
readonly FILE2="file_2"
readonly PERMISSIONS=664
readonly TMP=".tmp"

# запускаем первый скрипт для подготовки окружения. весь вывод отправляется в /dev/null чтобы не мусорить в консоли
bash "$SCRIPT1PATH" > /dev/null

# считаем сколько файлов лежит в директории. ls выводит список, а wc -l считает количество строк
# shellcheck disable=SC2012
FILE_COUNT=$(ls "$FOLDER" | wc -l)
echo "количество файлов в директории $FOLDER - $FILE_COUNT"

# изменяем права на втором файле
FILE2="$FOLDER/$FILE2"
# 664 означает: владелец - читает/пишет, группа - читает/пишет, когда остальные только "читают"
chmod "$PERMISSIONS" "$FILE2"
echo "права файла $FILE2 назначены на $PERMISSIONS"

# ищем все пустые файлы в директории. find с флагом -type f ищет только файлы, а -empty отфильтровывает пустые файлы
EMPTY_FILES=$(find "$FOLDER" -type f -empty)

# проверяем, что переменная не пустая (-n)
if [ -n "$EMPTY_FILES" ]; then
    echo "найдены пустые файлы:"
    echo "$EMPTY_FILES"

    # удаляем все найденные пустые файлы
    find "$FOLDER" -type f -empty -delete
    echo "пустые файлы удалены"
else
    echo "пустых файлов не найдено"
fi

# обрабатываем оставшиеся непустые файлы
echo "обработка непустых файлов (оставляем только первую строку)"

# этот цикл проходит по всем объектам в папке
for file in "$FOLDER"/*; do
    # проверяем, что это файл (-f) и что он не пустой (-s)
    if [ -f "$file" ] && [ -s "$file" ]; then

        # head -n 1 берет только первую строку из файла. сохраняем ее во временный файл чтобы не потерялось при перезаписи
        head -n 1 "$file" > "${file}${TMP}"

        # заменяем оригинал временным файлом
        mv "${file}${TMP}" "$file"
        echo "файл $file обработан (оставлена только первая строка)"
    fi
done
