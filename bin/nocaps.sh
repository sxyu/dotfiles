#!/bin/bash
echo -e "$(dumpkeys | grep ^keymaps)\nkeycode 58 = Escape" | sudo loadkeys
