#!/bin/bash

source ../validation.sh

# TEST_1 Нормальные аргументы
TEST_1 () {
    validation "/home/" 3 "abcXYZ" 2 "abc.xyz" 50kb
    if [ $? -eq 0 ]; then
        echo "Тест 1 пройден"
    else
        echo "Тест 1 не пройден"
    fi
}

# TEST_2 На вход подается больше 6 аргументов
TEST_2 () {
    validation "/home/" 3 "abcXYZ" 2 "abc.xyz" 50kb  21 > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 2 пройден"
    else
        echo "Тест 2 не пройден"
    fi
}

# TEST_3 На вход подается меньше 6 аргументов
TEST_3 () {
    validation "/home/" 3 "abcXYZ" 2 "abc.xyz" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 3 пройден"
    else
        echo "Тест 3 не пройден"
    fi
}

# TEST_4 На вход подается несуществующая директория
TEST_4 () {
    validation "/qwer/" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 4 пройден"
    else
        echo "Тест 4 не пройден"
    fi
}

# TEST_5 На вход подается не директория, а файл
TEST_5 () {
    validation "/etc/adduser.conf/" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 5 пройден"
    else
        echo "Тест 5 не пройден"
    fi
}

# TEST_6 У первого аргумента отсутствует '/' в начале (не абсолютный путь)
TEST_6 () {
    validation "home" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 6 пройден"
    else
        echo "Тест 6 не пройден"
    fi
}

# TEST_7 $2 задан не цифрами
TEST_7 () {
    validation "/home" 23a "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 7 пройден"
    else
        echo "Тест 7 не пройден"
    fi
}

# TEST_8 $2 равен 0
TEST_8 () {
    validation "/home" 0 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 8 пройден"
    else
        echo "Тест 8 не пройден"
    fi
}

# TEST_8 $3 задан не буквами
TEST_8 () {
    validation "/home" 2 "a12w" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 8 пройден"
    else
        echo "Тест 8 не пройден"
    fi
}

# TEST_9 $3 меньше одного символа
TEST_9 () {
    validation "/home" 2 "" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 9 пройден"
    else
        echo "Тест 9 не пройден"
    fi
}

# TEST_10 $3 больше 7 символов
TEST_10 () {
    validation "/home" 2 "qwertyui" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 10 пройден"
    else
        echo "Тест 10 не пройден"
    fi
}

# TEST_11 $3 7 символов
TEST_11 () {
    validation "/home" 2 "qwertyu" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        echo "Тест 11 пройден"
    else
        echo "Тест 11 не пройден"
    fi
}

# TEST_12 $3 1 символ
TEST_12 () {
    validation "/home" 2 "q" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        echo "Тест 12 пройден"
    else
        echo "Тест 12 не пройден"
    fi
}

# TEST_13 $4 задан не цифрами
TEST_13 () {
    validation "/home" 2 "q" "a1" "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 13 пройден"
    else
        echo "Тест 13 не пройден"
    fi
}

# TEST_14 $4 равен 0
TEST_14 () {
    validation "/home" 2 "q" 0 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 14 пройден"
    else
        echo "Тест 14 не пройден"
    fi
}

# TEST_15 $5 список букв имени файла меньше 1
TEST_15 () {
    validation "/home" 2 "q" 1 ".xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 15 пройден"
    else
        echo "Тест 15 не пройден"
    fi
}

# TEST_16 $5 список букв имени файла больше 7
TEST_16 () {
    validation "/home" 2 "q" 1 ".xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 16 пройден"
    else
        echo "Тест 16 не пройден"
    fi
}

# TEST_17 $5 Отсутствует '.'
TEST_17 () {
    validation "/home" 2 "q" 1 "axyzatxt" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 17 пройден"
    else
        echo "Тест 17 не пройден"
    fi
}

# TEST_18 $5 список букв расширения файла меньше 1
TEST_18 () {
    validation "/home" 2 "q" 1 "axyza." 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 18 пройден"
    else
        echo "Тест 18 не пройден"
    fi
}

# TEST_19 $5 список букв расширения файла больше 3
TEST_19 () {
    validation "/home" 2 "q" 1 "axyza.txtt" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 19 пройден"
    else
        echo "Тест 19 не пройден"
    fi
}

# TEST_20 $5 список букв расширения файла равен 3
TEST_20 () {
    validation "/home" 2 "q" 1 "axyza.txt" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        echo "Тест 20 пройден"
    else
        echo "Тест 20 не пройден"
    fi
}

# TEST_21 $5 список букв расширения файла равен 1
TEST_21 () {
    validation "/home" 2 "q" 1 "axyza.t" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        echo "Тест 21 пройден"
    else
        echo "Тест 21 не пройден"
    fi
}

# TEST_22 $6 отсутствует размер файла (в цифрах)
TEST_22 () {
    validation "/home" 2 "q" 1 "axyza.txt" "kb" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 22 пройден"
    else
        echo "Тест 22 не пройден"
    fi
}

# TEST_23 $6 отсутствует 'b' в конце аргумента
TEST_23 () {
    validation "/home" 2 "q" 1 "axyza.txt" "50k" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 23 пройден"
    else
        echo "Тест 23 не пройден"
    fi
}

# TEST_24 $6 отсутствует 'k' в аргументе
TEST_24 () {
    validation "/home" 2 "q" 1 "axyza.txt" "50b" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 24 пройден"
    else
        echo "Тест 24 не пройден"
    fi
}

# TEST_25 $6 размер 0kb
TEST_25 () {
    validation "/home" 2 "q" 1 "axyza.txt" "0kb" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 25 пройден"
    else
        echo "Тест 25 не пройден"
    fi
}

# TEST_26 $6 размер 101kb
TEST_26 () {
    validation "/home" 2 "q" 1 "axyza.txt" "101kb" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 26 пройден"
    else
        echo "Тест 26 не пройден"
    fi
}

# TEST_27 $6 размер 100kb
TEST_27 () {
    validation "/home" 2 "q" 1 "axyza.txt" "100kb" > /dev/null
    if [ $? -eq 0 ]; then
        echo "Тест 27 пройден"
    else
        echo "Тест 27 не пройден"
    fi
}

# TEST_28 $6 размер 1kb
TEST_28 () {
    validation "/home" 2 "q" 1 "axyza.txt" "1kb" > /dev/null
    if [ $? -eq 0 ]; then
        echo "Тест 28 пройден"
    else
        echo "Тест 28 не пройден"
    fi
}

# TEST_29 $6 размер 1a1kb
TEST_29 () {
    validation "/home" 2 "q" 1 "axyza.txt" "1a1kb" > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 29 пройден"
    else
        echo "Тест 29 не пройден"
    fi
}

# TEST_30 без аргументов
TEST_30 () {
    validation > /dev/null
    if [ $? -eq 1 ]; then
        echo "Тест 30 пройден"
    else
        echo "Тест 30 не пройден"
    fi
}

TEST_1
TEST_2
TEST_3
TEST_4
TEST_5
TEST_6
TEST_7
TEST_8
TEST_9
TEST_10
TEST_11
TEST_12
TEST_13
TEST_14
TEST_15
TEST_16
TEST_17
TEST_18
TEST_19
TEST_20
TEST_21
TEST_22
TEST_23
TEST_24
TEST_25
TEST_26
TEST_27
TEST_28
TEST_29
TEST_30