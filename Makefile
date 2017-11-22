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

NAME = test_gnl_file
NAME2 = test_gnl_std

RUN = sh run.sh
TESTFOLD = ./tests
T8S =		8_test0 \
			8_test1 \
			8_test2
T8F =		8_test3 \
			8_test4 \
			8_test5
T8C_F = $(patsubst %, $(RUN) $(NAME) $(TESTFOLD)/00.basic_tests/% ;, $(T8F))
T8C_S = $(patsubst %, $(RUN) $(NAME2) $(TESTFOLD)/00.basic_tests/% ;, $(T8S))
T16F =		16_test0 \
			16_test1 \
			16_test2 
T16S =		16_test3 \
			16_test4 \
			16_test5 
T16C_F = $(patsubst %, $(RUN) $(NAME) $(TESTFOLD)/01.middle_tests/% ;, $(T16F))
T16C_S = $(patsubst %, $(RUN) $(NAME2) $(TESTFOLD)/01.middle_tests/% ;, $(T16S))
T4_F =		4_test0 \
			4_test1 \
			4_test2
T4_S =		4_test3 \
			4_test4 \
			4_test5
T4_E = 		4_test6 \
			8_test7 \
			16_test8 \
			empty0 \
			empty1
T4C_F = $(patsubst %, $(RUN) $(NAME) $(TESTFOLD)/02.advanced_tests/% ;, $(T4F))
T4C_S = $(patsubst %, $(RUN) $(NAME2) $(TESTFOLD)/02.advanced_tests/% ;, $(T4S))
T4C_E = $(patsubst %, $(RUN) $(NAME2) $(TESTFOLD)/02.advanced_tests/% ;, $(T4E))
TESTERROR =	#e_test0
TESTERRORCOMMANDS = $(patsubst $(TESTFOLD)/e_tests/%, $(RUN) % ;, $(TESTERROR))
TESTBONUS =	#b_test0
TESTBONUSCOMMANDS = $(patsubst $(TESTFOLD)/b_tests/%, $(RUN) % ;, $(TESTBONUS))

RUNANS = sh runans.sh
AT8C_F = $(patsubst %, $(RUNANS) $(NAME) $(TESTFOLD)/00.basic_tests/% ;, $(T8F))
AT8C_S = $(patsubst %, $(RUNANS) $(NAME2) $(TESTFOLD)/00.basic_tests/% ;, $(T8S))
AT16C_F = $(patsubst %, $(RUNANS) $(NAME) $(TESTFOLD)/01.middle_tests/% ;, $(T16F))
AT16C_S = $(patsubst %, $(RUNANS) $(NAME2) $(TESTFOLD)/01.middle_tests/% ;, $(T16S))
AT4C_F = $(patsubst %, $(RUNANS) $(NAME) $(TESTFOLD)/02.advanced_tests/% ;, $(T4F))
AT4C_S = $(patsubst %, $(RUNANS) $(NAME2) $(TESTFOLD)/02.advanced_tests/% ;, $(T4S))
AT4C_E = $(patsubst %, $(RUNANS) $(NAME2) $(TESTFOLD)/02.advanced_tests/% ;, $(T4E))

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

$(NAME): get_next_line.o main.o main2.o
	#make -C libft/ fclean && make -C libft/
	clang -o $(NAME) main.o get_next_line.o -I libft/includes -L libft/ -lft
	clang -o $(NAME2) main2.o get_next_line.o -I libft/includes -L libft/ -lft

get_next_line.o: get_next_line.c
	clang -Wall -Wextra -Werror -I libft/includes -o get_next_line.o -c get_next_line.c

main.o: main.c
	clang -Wall -Wextra -Werror -I libft/includes -o main.o -c main.c

main2.o: main2.c
	clang -Wall -Wextra -Werror -I libft/includes -o main2.o -c main2.c

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
	@$(T8C_S)
	@$(T8C_F)

test16: $(NAME)
	@echo ${CYAN}[Middle tests]${NC}
	@$(T16C_F)
	@$(T16C_S)	

test4: $(NAME)
	@echo ${CYAN}[Advanced tests]${NC}
	@$(T4C_F)
	@$(T4C_S)
	@$(T4C_E)

testerror: $(NAME)
	@echo ${CYAN}[Error management]${NC}

testbonus: $(NAME)
	@echo ${CYAN}[Bonus parts]${NC}

testall: $(NAME)
	@clear
	@make test8
	@make test16
	@make test4
	@make testerror
	@make testbonus

test_gans:
	@$(AT8C_F)
	@$(AT8C_S)
	@$(AT16C_F)
	@$(AT16C_S)
	@$(AT4C_F)
	@$(AT4C_S)
	@$(AT4C_E)

tclean:
	find . -name "*_ans" -delete

aclean:
	find . -name "*_cor" -delete