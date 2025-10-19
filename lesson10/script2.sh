#!/bin/bash

FOLDER="$HOME/myfolder"

# :)
bash $HOME/script1.sh > /dev/null

# Определяет, как много файлов создано в папке myfolder
FILE_COUNT=$(ls | wc -l)
echo "Количество файлов в директории $FOLDER - $FILE_COUNT"

# Исправляет права второго файла с 777 на 664
FILE2="$FOLDER/file_2"
chmod 664 "$FILE2"
echo "Права файла $FILE2 назначены на 664"

# Определяет пустые файлы и удаляет их
EMPTY_FILES=$(find "$FOLDER" -type f -empty)
if [ -n "$EMPTY_FILES" ]; then
echo "Найдены пустые файлы:"
echo "$EMPTY_FILES"
find "$FOLDER" -type f -empty -delete
echo "Пустые файлы удалены"
else
echo "Пустых файлов не найдено"
fi

# Удаляет все строки кроме первой в остальных файлах
echo "Обработка непустых файлов (оставляем только первую строку)"
for file in "$FOLDER"/*; do
if [ -f "$file" ] && [ -s "$file" ]; then
head -n 1 "$file" > "${file}.tmp"
mv "${file}.tmp" "$file"
echo "Файл $file обработан (оставлена только первая строка)"
fi
done