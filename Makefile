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
NAME3 = test_gnl_error
NAME4 = test_gnl_DS

NAMES = $(NAME) $(NAME2) $(NAME3)

# BASH SCRIPTS

RUN_S = sh run_s.sh
RUN_F = sh run_f.sh
RUN_ERR = sh run_err.sh

RUNANS_S = sh runans_s.sh
RUNANS_F = sh runans_f.sh
RUNANS_ERR = sh runans_err.sh

# FOLDERS

TESTFOLD = ./tests
SHDIR = ./tests
ERRDIR = ./03.error_tests

MAINDIR = $(TESTFOLD)/MAINS

# MAIN FILES

MAINS =		main \
			main2 \
			main3
MAINF = $(patsubst %, $(MAINDIR)/%.c, $(MAINS))
MAINO = $(patsubst %, $(MAINDIR)/%.o, $(MAINS))

# BASIC TESTS

T8_S =		8_test0 \
			8_test1 \
			8_test2
T8_F =		8_test3 \
			8_test4 \
			8_test5
T8C_F = $(patsubst %, $(RUN_F) $(NAME) $(TESTFOLD)/00.basic_tests/% ;, $(T8_F))
T8C_S = $(patsubst %, $(RUN_S) $(NAME2) $(TESTFOLD)/00.basic_tests/% ;, $(T8_S))

# MIDDLE TESTS

T16_F =		16_test0 \
			16_test1 \
			16_test2 
T16_S =		16_test3 \
			16_test4 \
			16_test5 
T16C_F = $(patsubst %, $(RUN_F) $(NAME) $(TESTFOLD)/01.middle_tests/% ;, $(T16_F))
T16C_S = $(patsubst %, $(RUN_S) $(NAME2) $(TESTFOLD)/01.middle_tests/% ;, $(T16_S))

# ADVANCED TESTS

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
T4C_F = $(patsubst %, $(RUN_F) $(NAME) $(TESTFOLD)/02.advanced_tests/% ;, $(T4_F))
T4C_S = $(patsubst %, $(RUN_S) $(NAME2) $(TESTFOLD)/02.advanced_tests/% ;, $(T4_S))
T4C_E = $(patsubst %, $(RUN_F) $(NAME) $(TESTFOLD)/02.advanced_tests/% ;, $(T4_E))

# COMMANDS FOR GETTING CORRECT ANSWERS

AT8C_F = $(patsubst %, $(RUNANS_F) $(NAME) $(TESTFOLD)/00.basic_tests/% ;, $(T8_F))
AT8C_S = $(patsubst %, $(RUNANS_S) $(NAME2) $(TESTFOLD)/00.basic_tests/% ;, $(T8_S))
AT16C_F = $(patsubst %, $(RUNANS_F) $(NAME) $(TESTFOLD)/01.middle_tests/% ;, $(T16_F))
AT16C_S = $(patsubst %, $(RUNANS_S) $(NAME2) $(TESTFOLD)/01.middle_tests/% ;, $(T16_S))
AT4C_F = $(patsubst %, $(RUNANS_F) $(NAME) $(TESTFOLD)/02.advanced_tests/% ;, $(T4_F))
AT4C_S = $(patsubst %, $(RUNANS_S) $(NAME2) $(TESTFOLD)/02.advanced_tests/% ;, $(T4_S))
AT4C_E = $(patsubst %, $(RUNANS_F) $(NAME) $(TESTFOLD)/02.advanced_tests/% ;, $(T4_E))

# COLORS

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

# BUILD COMMANDS

all:
	#@make libclean
	@make $(NAME)
	@make $(NAME2)
	@make $(NAME3)

libclean:
	make -C libft/ fclean && make -C libft/

$(NAME): get_next_line.o main.o	
	clang -o $(NAME) main.o get_next_line.o -I libft/includes -L libft/ -lft

$(NAME2): get_next_line.o main2.o
	clang -o $(NAME2) main2.o get_next_line.o -I libft/includes -L libft/ -lft

$(NAME3): get_next_line.o main3.o
	clang -o $(NAME3) main3.o get_next_line.o -I libft/includes -L libft/ -lft

%.o: %.c
	clang -Wall -Wextra -Werror -I libft/includes -o $@ -c $<

clean:
	@rm *.o

fclean: clean
	@rm $(NAMES)

re: fclean all

norm:
	clear
	norminette get_next_line.c get_next_line.h

# TESTING COMMANDS

test8: $(NAMES)
	@echo ${CYAN}[Basic tests]${NC}
	@$(T8C_S)
	@$(T8C_F)

test16: $(NAMES)
	@echo ${CYAN}[Middle tests]${NC}
	@$(T16C_F)
	@$(T16C_S)	

test4: $(NAMES)
	@echo ${CYAN}[Advanced tests]${NC}
	@$(T4C_F)
	@$(T4C_S)
	@$(T4C_E)

testerror: $(NAMES)
	@echo ${CYAN}[Error management]${NC}
	@$(RUN_ERR) $(NAME3) $(TESTFOLD)/$(ERRDIR)

testbonus: $(NAMES)
	@echo ${CYAN}[Bonus parts]${NC}

testall: $(NAMES)
	@clear
	@make test8
	@make test16
	@make test4
	@make testerror
	@make testbonus

test_gans: $(NAMES)
	@$(AT8C_F)
	@$(AT8C_S)
	@$(AT16C_F)
	@$(AT16C_S)
	@$(AT4C_F)
	@$(AT4C_S)
	@$(AT4C_E)
	@$(RUNANS_ERR) $(NAME3) $(TESTFOLD)/$(ERRDIR)

tclean: aclean
	find . -name "*_cor" -delete

aclean:
	find . -name "*_ans" -delete