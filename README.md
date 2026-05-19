Bash Wallet CLI is a personal account income / expense tracker for bash shell , works on terminal framebuffer tty only no X11 required,
works inside a gnu screen session,
tested in android with termux bash

#how to run:

# linux
# chmod +x bashwallet.sh
# ./bashwallet.sh

# android (install termux and bash)
# chmod +x bashwallet.sh
# bash bashwallet.sh

Features:
- View Account balance totals
- Add / Edit / Delete Transactions
- View Latest 20 transactions

How to add transactions:

--------------------                   
--- Wallet Menu  ---
--------------------
1. View Balances
2. Add Transaction
3. View Latest 20 Transactions
4. Delete Transaction
5. Edit Transaction
6. Quit
Enter your choice: 2

Enter Transaction [account] [amount] [description]:

how to add income:

cash 500 income-from-work

how to add expense:

cash -100 grocery


*Transaction Data is saved in a flat text file named walletfile
