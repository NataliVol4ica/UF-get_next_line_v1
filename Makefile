#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nkolosov <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/11/16 15:33:35 by nkolosov          #+#    #+#              #
#    Updated: 2017/11/16 15:33:35 by nkolosov         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME = test_gnl

RUN = sh run.sh
TESTF = ./tests
TEST8 =		8_test3 \
			8_test4 \
			8_test5
TEST8COMMANDS = $(patsubst %, $(RUN) $(TESTF)/00.basic_tests/% ;, $(TEST8))
TEST16 =	16_test0 \
			16_test1 \
			16_test2 
TEST16COMMANDS = $(patsubst %, $(RUN) $(TESTF)/01.middle_tests/% ;, $(TEST16))
TEST4 =		4_test0 \
			4_test1 \
			4_test2 \
			4_test6 \
			8_test7 \
			16_test8 \
			empty0 \
			empty1
TEST4COMMANDS = $(patsubst %, $(RUN) $(TESTF)/02.advanced_tests/% ;, $(TEST4))
TESTERROR =	#e_test0
TESTERRORCOMMANDS = $(patsubst $(TESTF)/e_tests/%, $(RUN) % ;, $(TESTERROR))
TESTBONUS =	#b_test0
TESTBONUSCOMMANDS = $(patsubst $(TESTF)/b_tests/%, $(RUN) % ;, $(TESTBONUS))

RUNANS = sh runans.sh
RUNANS8COMMANDS = $(patsubst %, $(RUNANS) $(TESTF)/00.basic_tests/% ;, $(TEST8))
RUNANS16COMMANDS = $(patsubst %, $(RUNANS) $(TESTF)/01.middle_tests/% ;, $(TEST16))
RUNANS4COMMANDS = $(patsubst %, $(RUNANS) $(TESTF)/02.advanced_tests/% ;, $(TEST4))
RUNANSERRORCOMMANDS = $(patsubst %, $(RUNANS) $(TESTF)/e_tests/% ;, $(TESTERROR))
RUNANSBONUSCOMMANDS = $(patsubst %, $(RUNANS) $(TESTF)/b_tests/% ;, $(TESTBONUS))

RED = '\033[0;31m'
GREEN = '\033[0;32m'
BLUE = '\033[0;34m'
PURPLE = '\033[0;35m'
CYAN = '\033[0;36m'
YELLOW = '\033[1;33m'
LBLUE = '\033[1;34m'
PINK = '\033[1;35m'
WHITE = '\033[1;37m'
NC = '\033[0m' # No Color

all: $(NAME)

$(NAME): get_next_line.o main.o
	make -C libft/ fclean && make -C libft/
	clang -o test_gnl main.o get_next_line.o -I libft/includes -L libft/ -lft

get_next_line.o: get_next_line.c
	clang -Wall -Wextra -Werror -I libft/includes -o get_next_line.o -c get_next_line.c

main.o: main.c
	clang -Wall -Wextra -Werror -I libft/includes -o main.o -c main.c

clean:
	/bin/rm get_next_line.o main.o

fclean: clean
	/bin/rm $(NAME)

re: fclean all

norm:
	clear
	norminette get_next_line.c get_next_line.h

test8: $(NAME)
	@echo ${CYAN}[Basic tests]${NC}
	@$(TEST8COMMANDS)

test16: $(NAME)
	@echo ${CYAN}[Middle tests]${NC}
	@$(TEST16COMMANDS)	

test4: $(NAME)
	@echo ${CYAN}[Advanced tests]${NC}
	@$(TEST4COMMANDS)

testerror: $(NAME)
	@echo ${CYAN}[Error management]${NC}
	@$(TESTERRORCOMMANDS)

testbonus: $(NAME)
	@echo ${CYAN}[Bonus parts]${NC}
	@$(TESTBONUSCOMMANDS)

testall: $(NAME)
	@clear
	@make test8
	@make test16
	@make test4
	@make testerror
	@make testbonus

test_gans:
	@$(RUNANS8COMMANDS)
	@$(RUNANS16COMMANDS)
	@$(RUNANS4COMMANDS)
	@$(RUNANSERRORCOMMANDS)
	@$(RUNANSBONUSCOMMANDS)


tclean:
	find . -name "*_ans" -delete

aclean:
	find . -name "*_cor" -delete
