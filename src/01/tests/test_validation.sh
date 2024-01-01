#!/bin/bash

readonly GREEN='\033[1;36m'
readonly RESET='\033[0m'
readonly RED='\033[1;31m'

result_success () {
    echo -e "${1}:${GREEN}SUCCESS${RESET}"
}
result_fail () {
    echo -e "${1}:${RED}FAIL${RESET}"
}

start () {
    echo -e "\n========= ${1} =========\n"
}

start "VALIDATION"
source ../validation.sh

# TEST_1_VALIDATION Нормальные аргументы
TEST_1_VALIDATION () {
    validation "/home/" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_1_VALIDATION"
    else
        result_fail "TEST_1_VALIDATION"
    fi
}

# TEST_2_VALIDATION На вход подается больше 6 аргументов
TEST_2_VALIDATION () {
    validation "/home/" 3 "abcXYZ" 2 "abc.xyz" 50kb  21 > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_2_VALIDATION"
    else
        result_fail "TEST_2_VALIDATION"
    fi
}

# TEST_3_VALIDATION На вход подается меньше 6 аргументов
TEST_3_VALIDATION () {
    validation "/home/" 3 "abcXYZ" 2 "abc.xyz" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_3_VALIDATION"
    else
        result_fail "TEST_3_VALIDATION"
    fi
}

# TEST_4_VALIDATION На вход подается несуществующая директория
TEST_4_VALIDATION () {
    validation "/qwer/" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_4_VALIDATION"
    else
        result_fail "TEST_4_VALIDATION"
    fi
}

# TEST_5_VALIDATION На вход подается не директория, а файл
TEST_5_VALIDATION () {
    validation "/etc/adduser.conf/" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_5_VALIDATION"
    else
        result_fail "TEST_5_VALIDATION"
    fi
}

# TEST_6_VALIDATION У первого аргумента отсутствует '/' в начале (не абсолютный путь)
TEST_6_VALIDATION () {
    validation "home" 3 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_6_VALIDATION"
    else
        result_fail "TEST_6_VALIDATION"
    fi
}

# TEST_7_VALIDATION $2 задан не цифрами
TEST_7_VALIDATION () {
    validation "/home" 23a "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_7_VALIDATION"
    else
        result_fail "TEST_7_VALIDATION"
    fi
}

# TEST_8_VALIDATION $2 равен 0
TEST_8_VALIDATION () {
    validation "/home" 0 "abcXYZ" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_8_VALIDATION"
    else
        result_fail "TEST_8_VALIDATION"
    fi
}

# TEST_9_VALIDATION_VALIDATION $3 задан не буквами
TEST_9_VALIDATION () {
    validation "/home" 2 "a12w" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_9_VALIDATION"
    else
        result_fail "TEST_9_VALIDATION"
    fi
}

# TEST_10_VALIDATION $3 меньше одного символа
TEST_10_VALIDATION () {
    validation "/home" 2 "" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_10_VALIDATION"
    else
        result_fail "TEST_10_VALIDATION"
    fi
}

# TEST_11_VALIDATION $3 больше 7 символов
TEST_11_VALIDATION () {
    validation "/home" 2 "qwertyui" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_11_VALIDATION"
    else
        result_fail "TEST_11_VALIDATION"
    fi
}

# TEST_12_VALIDATION $3 7 символов
TEST_12_VALIDATION () {
    validation "/home" 2 "qwertyu" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_12_VALIDATION"
    else
        result_fail "TEST_12_VALIDATION"
    fi
}

# TEST_13_VALIDATION $3 1 символ
TEST_13_VALIDATION () {
    validation "/home" 2 "q" 2 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_13_VALIDATION"
    else
        result_fail "TEST_13_VALIDATION"
    fi
}

# TEST_14_VALIDATION $4 задан не цифрами
TEST_14_VALIDATION () {
    validation "/home" 2 "q" "a1" "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_14_VALIDATION"
    else
        result_fail "TEST_14_VALIDATION"
    fi
}

# TEST_15_VALIDATION $4 равен 0
TEST_15_VALIDATION () {
    validation "/home" 2 "q" 0 "abc.xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_15_VALIDATION"
    else
        result_fail "TEST_15_VALIDATION"
    fi
}

# TEST_16_VALIDATION $5 список букв имени файла меньше 1
TEST_16_VALIDATION () {
    validation "/home" 2 "q" 1 ".xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_16_VALIDATION"
    else
        result_fail "TEST_16_VALIDATION"
    fi
}

# TEST_17_VALIDATION $5 список букв имени файла больше 7
TEST_17_VALIDATION () {
    validation "/home" 2 "q" 1 ".xyz" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_17_VALIDATION"
    else
        result_fail "TEST_17_VALIDATION"
    fi
}

# TEST_18_VALIDATION $5 Отсутствует '.'
TEST_18_VALIDATION () {
    validation "/home" 2 "q" 1 "axyzatxt" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_18_VALIDATION"
    else
        result_fail "TEST_18_VALIDATION"
    fi
}

# TEST_19_VALIDATION $5 список букв расширения файла меньше 1
TEST_19_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza." 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_19_VALIDATION"
    else
        result_fail "TEST_19_VALIDATION"
    fi
}

# TEST_20_VALIDATION $5 список букв расширения файла больше 3
TEST_20_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txtt" 50kb > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_20_VALIDATION"
    else
        result_fail "TEST_20_VALIDATION"
    fi
}

# TEST_21_VALIDATION $5 список букв расширения файла равен 3
TEST_21_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_21_VALIDATION"
    else
        result_fail "TEST_21_VALIDATION"
    fi
}

# TEST_22_VALIDATION $5 список букв расширения файла равен 1
TEST_22_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.t" 50kb > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_22_VALIDATION"
    else
        result_fail "TEST_22_VALIDATION"
    fi
}

# TEST_23_VALIDATION $6 отсутствует размер файла (в цифрах)
TEST_23_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "kb" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_23_VALIDATION"
    else
        result_fail "TEST_23_VALIDATION"
    fi
}

# TEST_24_VALIDATION $6 отсутствует 'b' в конце аргумента
TEST_24_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "50k" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_24_VALIDATION"
    else
        result_fail "TEST_24_VALIDATION"
    fi
}

# TEST_25_VALIDATION $6 отсутствует 'k' в аргументе
TEST_25_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "50b" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_25_VALIDATION"
    else
        result_fail "TEST_25_VALIDATION"
    fi
}

# TEST_26_VALIDATION $6 размер 0kb
TEST_26_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "0kb" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_26_VALIDATION"
    else
        result_fail "TEST_26_VALIDATION"
    fi
}

# TEST_27_VALIDATION $6 размер 101kb
TEST_27_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "101kb" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_27_VALIDATION"
    else
        result_fail "TEST_27_VALIDATION"
    fi
}

# TEST_28_VALIDATION $6 размер 100kb
TEST_28_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "100kb" > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_28_VALIDATION"
    else
        result_fail "TEST_28_VALIDATION"
    fi
}

# TEST_29_VALIDATION $6 размер 1kb
TEST_29_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "1kb" > /dev/null
    if [ $? -eq 0 ]; then
        result_success "TEST_29_VALIDATION"
    else
        result_fail "TEST_29_VALIDATION"
    fi
}

# TEST_30_VALIDATION $6 размер 1a1kb
TEST_30_VALIDATION () {
    validation "/home" 2 "q" 1 "axyza.txt" "1a1kb" > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_30_VALIDATION"
    else
        result_fail "TEST_30_VALIDATION"
    fi
}

# TEST_31_VALIDATION без аргументов
TEST_31_VALIDATION () {
    validation > /dev/null
    if [ $? -eq 1 ]; then
        result_success "TEST_31_VALIDATION"
    else
        result_fail "TEST_31_VALIDATION"
    fi
}

TEST_1_VALIDATION
TEST_2_VALIDATION
TEST_3_VALIDATION
TEST_4_VALIDATION
TEST_5_VALIDATION
TEST_6_VALIDATION
TEST_7_VALIDATION
TEST_8_VALIDATION
TEST_9_VALIDATION
TEST_10_VALIDATION
TEST_11_VALIDATION
TEST_12_VALIDATION
TEST_13_VALIDATION
TEST_14_VALIDATION
TEST_15_VALIDATION
TEST_16_VALIDATION
TEST_17_VALIDATION
TEST_18_VALIDATION
TEST_19_VALIDATION
TEST_20_VALIDATION
TEST_21_VALIDATION
TEST_22_VALIDATION
TEST_22_VALIDATION
TEST_23_VALIDATION
TEST_24_VALIDATION
TEST_25_VALIDATION
TEST_26_VALIDATION
TEST_27_VALIDATION
TEST_28_VALIDATION
TEST_29_VALIDATION
TEST_30_VALIDATION
TEST_31_VALIDATION