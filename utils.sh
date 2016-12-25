#!/bin/bash

#Some sourceable utilities.

absPath() {
	#Depends python3.
	python3 -c "import os; print(os.path.abspath('.'));"
}
