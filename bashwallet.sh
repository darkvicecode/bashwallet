#!/bin/bash
#
############################################
#
###   Bash Wallet v.1.0
#
###    by: r0mmelr
#
###   https://github.com/darkvicecode/bashwallet
#    darkvice.net
#    dark-vice.com
#    codezero.cc
#
#    GPL license
#
#############################################
#
# Wallet Transaction tracker

file=walletfile
touch "$file"

date=$(date +"%Y/%m/%d")

# Function to view all account balances
view_balances() {
  echo "--- Account Balances ---"
  awk '{ totals[$2] += $3; grand_total += $3 } END { for (acc in totals) printf "%-15s: %.2f\n", acc, totals[acc]; print "--------------------"; printf "%-15s: %.2f\n", "GRAND TOTAL", grand_total }' "$file"
}

# Function to display the menu
display_menu() {
  echo "---==============---"
  echo "--- DarkViceCode ---"
  echo "--- BASH Wallet  ---"
  echo "--------------------"
  echo "--- Wallet Menu  ---"
  echo "--------------------"
  echo "1. View Balances"
  echo "2. Add Transaction"
  echo "3. View Latest 20 Transactions"
  echo "4. Delete Transaction"
  echo "5. Edit Transaction"
  echo "6. Quit"
  echo -n "Enter your choice: "
}

# Function to list transactions with line numbers
list_with_numbers() {
  nl -ba "$file" | tail -n 20
}

# Function to delete a transaction
delete_transaction() {
  list_with_numbers
  read -p "Enter the line number to delete: " line_num
  if [[ "$line_num" =~ ^[0-9]+$ ]]; then
    awk -v ln="$line_num" 'NR != ln' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    echo "Transaction deleted."
  else
    echo "Invalid line number."
  fi
}

# Function to edit a transaction
edit_transaction() {
  list_with_numbers
  read -p "Enter the line number to edit: " line_num
  if [[ "$line_num" =~ ^[0-9]+$ ]]; then
    old_val=$(awk -v ln="$line_num" 'NR == ln' "$file")
    echo "Current: $old_val"
    read -p "Enter New Transaction (<account> <amount> <description>): " account amount desc
    if [[ -n "$account" && "$amount" =~ ^[[:alnum:]-]+$ ]]; then
      awk -v ln="$line_num" -v new="$date $account $amount $desc" 'NR == ln { print new; next } { print }' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
      echo "Transaction updated."
    else
      echo "Invalid input."
    fi
  else
    echo "Invalid line number."
  fi
}

#
#############################################
#
####   Bash Wallet v.1.0
#
####    by: r0mmelr
#
#    https://github.com/darkvicecode/bashwallet
#    darkvice.net
#    dark-vice.com
#    codezero.cc
#
#    GPL license
#
##############################################
#
# Function to add a Transaction
add_transaction() {
  read -p "Enter Transaction (<account> <amount> <description>): " account amount desc
  # Validation: account and amount are required, amount can be alphanumeric as requested
  if [[ -n "$account" && "$amount" =~ ^[[:alnum:]-]+$ ]]; then
    echo "$date $account $amount $desc" >> "$file"
    echo "Transaction added successfully."
  else
    echo "Invalid input. Please enter at least a valid account and amount (alphanumeric)."
  fi
}

# Main loop
while true; do
  display_menu
  read choice
  case $choice in
    1)
      echo "===================="
      echo "Date: $date"
      echo "--------------------"
      view_balances
      echo "===================="
      ;;
    2)
      add_transaction
      ;;
    3)
      echo "--- Latest 20 Transactions ---"
      tail -n 20 "$file"
      ;;
    4)
      delete_transaction
      ;;
    5)
      edit_transaction
      ;;
    6)
      echo "Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac
done

