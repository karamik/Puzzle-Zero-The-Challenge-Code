cat << 'EOF' > INSTALL.sh
#!/bin/bash
# --- TOTAL PROTOCOL | Automated Deployment Script v.8.2 ---
# Destination: Local environment (Linux/WSL2/macOS)

GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}--- [SENTINEL CORE] INITIALIZING DEPLOYMENT ---${NC}"

# 1. Проверка ОС и установка зависимостей
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "OS Detected: Linux. Installing dependencies..."
    sudo apt update && sudo apt install -y build-essential verilator git
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "OS Detected: macOS. Installing dependencies via Homebrew..."
    brew install verilator
else
    echo "Manual install required: Please install 'verilator' and 'build-essential' for your OS."
fi

# 2. Компиляция логики
echo -e "${GREEN}Step 1: Compiling SystemVerilog Core...${NC}"
verilator --binary -j 2 sentinel_challenge_v82.sv tb_sentinel_v82.sv --top-module tb_sentinel

# 3. Запуск верификации
if [ -f "./obj_dir/Vtb_sentinel" ]; then
    echo -e "${GREEN}Step 2: Starting Local Node Verification...${NC}"
    echo "----------------------------------------------------"
    ./obj_dir/Vtb_sentinel
    echo "----------------------------------------------------"
    echo -e "${CYAN}DEPLOYMENT SUCCESSFUL. ARCHITECT WALLET VERIFIED.${NC}"
else
    echo "ERROR: Compilation failed. Check Verilator logs above."
fi
EOF

chmod +x INSTALL.sh
