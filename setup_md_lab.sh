#!/usr/bin/env bash

# setup_md_lab.sh
# Установка GROMACS + Avogadro + Grace + PyMOL (с фиксом для Python 3.12) на Ubuntu 24.04 / Lubuntu 24.04
# Запуск: 
#   wget https://raw.githubusercontent.com/ВАШ_ЮЗЕРНЕЙМ/ВАШ_РЕПОЗИТОРИЙ/main/setup_md_lab.sh
#   chmod +x setup_md_lab.sh
#   ./setup_md_lab.sh

set -euo pipefail

echo "=== Установка окружения для MD-лабораторной (Ubuntu/Lubuntu 24.04) ==="
echo "Текущее время: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 1. Обновляем систему
echo "→ 1. Обновление списков пакетов и апгрейд системы..."
sudo apt update && sudo apt upgrade -y

# 2. Основные зависимости
echo "→ 2. Установка build-essential, cmake, FFTW, OpenMPI, OpenBLAS, libstdc++..."
sudo apt install -y \
    build-essential \
    cmake \
    g++ \
    make \
    libfftw3-dev \
    libopenmpi-dev \
    openmpi-bin \
    libopenblas-dev \
    libstdc++-14-dev

# 3. GROMACS
echo "→ 3. Установка GROMACS и данных..."
sudo apt install -y gromacs gromacs-data

# 4. Avogadro + Grace + PyMOL (из репозиториев)
echo "→ 4. Установка Avogadro, Grace (xmgrace), PyMOL..."
sudo apt install -y avogadro grace pymol

# 5. universe + фикс PyMOL (imp → zombie-imp)
echo "→ 5. Включаем universe и ставим python3-zombie-imp..."
sudo add-apt-repository universe -y
sudo apt update
sudo apt install -y python3-zombie-imp

# 6. Проверка (не прерывает установку при ошибках)
echo ""
echo "=== Проверка установленного ПО ==="
echo -n "GROMACS версия:    "; gmx --version 2>/dev/null | head -n1 || echo "не запустился"
echo -n "Avogadro:           "; avogadro --version 2>/dev/null || echo "не запустился"
echo -n "xmgrace:            "; xmgrace -h >/dev/null 2>&1 && echo "OK" || echo "не запустился"
echo -n "PyMOL (тест запуска): "; pymol -c -d "quit" >/dev/null 2>&1 && echo "OK (без ошибки imp)" || echo "Проблема (возможно нужен snap-вариант)"

echo ""
echo "=== Установка завершена ==="
echo "Рекомендуемые команды для проверки:"
echo "  gmx --version"
echo "  avogadro"
echo "  xmgrace"
echo "  pymol"
echo ""
echo "Если PyMOL не стартует — попробуйте альтернативу:"
echo "  sudo snap install pymol-oss --classic"
echo "  pymol-oss"
echo ""
echo "Готово! Можете начинать лабораторную."
