#!/bin/bash

check_command() {
    if [[ $? -ne 0 ]]; then
        echo "Erreur lors de l'exécution de la commande: $1"
        exit 1
    fi
}

free_data=$(free)
check_command "free"
mem_data=$(echo "$free_data" | grep 'Mem:')
free_mem=$(echo "$mem_data" | awk '{print $4}')
buffers=$(echo "$mem_data" | awk '{print $6}')
cache=$(echo "$mem_data" | awk '{print $7}')
total_free=$((free_mem + buffers + cache))

if echo "$free_data" | grep -q 'Échange:'; then
    used_swap=$(echo "$free_data" | grep 'Échange:' | awk '{print $3}')
else
    used_swap=$(echo "$free_data" | grep 'Swap:' | awk '{print $3}')
fi

echo -e "Free memory:\t$total_free kB ($((total_free / 1024)) MB)\nUsed swap:\t$used_swap kB ($((used_swap / 1024)) MB)"

if [[ $used_swap -eq 0 ]]; then
    echo "Félicitations ! Aucun swap n'est utilisé."
elif [[ $used_swap -lt $total_free ]]; then
    echo "Libération du swap..."
    sudo swapoff -a
    check_command "swapoff"
    sudo swapon -a
    check_command "swapon"
else
    echo "Pas assez de mémoire libre pour libérer le swap. Arrêt."
    exit 1
fi
