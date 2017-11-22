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

# FOLDERS

FOLD = ./resources
TESTFOLD = $(FOLD)/tests
SHDIR = $(FOLD)/scripts
ERRDIR = ./03.error_tests

MAINDIR = $(FOLD)/mains

# MAIN FILES

MAIN1 = $(MAINDIR)/main
MAIN2 = $(MAINDIR)/main2
MAIN3 = $(MAINDIR)/main3

# BASH SCRIPTS

RUN_S = sh $(SHDIR)/run_s.sh
RUN_F = sh $(SHDIR)/run_f.sh
RUN_ERR = sh $(SHDIR)/run_err.sh

RUNANS_S = sh $(SHDIR)/runans_s.sh
RUNANS_F = sh $(SHDIR)/runans_f.sh
RUNANS_ERR = sh $(SHDIR)/runans_err.sh

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
			long1 \
			long2 \
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
	@make $(NAME)
	@make $(NAME2)
	@make $(NAME3)

libclean:
	make -C libft/ fclean && make -C libft/

$(NAME): get_next_line.o $(MAIN1).o
	clang -o $(NAME) $(MAIN1).o get_next_line.o -I libft/includes -L libft/ -lft

$(NAME2): get_next_line.o $(MAIN2).o
	clang -o $(NAME2) $(MAIN2).o get_next_line.o -I libft/includes -L libft/ -lft

$(NAME3): get_next_line.o $(MAIN3).o
	clang -o $(NAME3) $(MAIN3).o get_next_line.o -I libft/includes -L libft/ -lft

get_next_line.o: get_next_line.c
	clang -Wall -Wextra -Werror -I libft/includes -o get_next_line.o -c get_next_line.c

$(MAIN1).o: $(MAIN1).c
	clang -Wall -Wextra -Werror -I libft/includes -o $(MAIN1).o -c $(MAIN1).c

$(MAIN2).o: $(MAIN2).c
	clang -Wall -Wextra -Werror -I libft/includes -o $(MAIN2).o -c $(MAIN2).c

$(MAIN3).o: $(MAIN3).c
	clang -Wall -Wextra -Werror -I libft/includes -o $(MAIN3).o -c $(MAIN3).c

clean:
	@find $(FOLD)/ -name "*.o" -delete

fclean: clean
	@rm $(NAMES)

re: fclean all

norm:
	@clear
	@norminette get_next_line.c get_next_line.h

# TESTING COMMANDS

test_8: $(NAMES)
	@echo ${CYAN}[Basic tests]${NC}
	@$(T8C_S)
	@$(T8C_F)

test_16: $(NAMES)
	@echo ${CYAN}[Middle tests]${NC}
	@$(T16C_F)
	@$(T16C_S)	

test_4: $(NAMES)
	@echo ${CYAN}[Advanced tests]${NC}
	@$(T4C_F)
	@$(T4C_S)
	@$(T4C_E)

test_error: $(NAMES)
	@echo ${CYAN}[Error management]${NC}
	@$(RUN_ERR) $(NAME3) $(TESTFOLD)/$(ERRDIR)

test_bonus: $(NAMES)
	@echo ${CYAN}[Bonus part]${NC}

test_all: $(NAMES)
	@make test_8
	@make test_16
	@make test_4
	@make test_error
	@make test_bonus

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
	@find . -name "*_cor" -delete

aclean:
	@find . -name "*_ans" -delete

eval:
	@clear
	@echo ${CYAN}"Files in directory:"${NC}
	@ls
	@echo ${CYAN}"Author file:"${NC}
	@cat -e author
	@echo ${CYAN}"get_next_line.h:"${NC}
	@cat get_next_line.h
	@echo ${CYAN}"[NORM]:"${NC}
	@norminette get_next_line.c get_next_line.h
	@norminette ./libft/
	@echo ${CYAN}"Compiling lib:"${NC}
	@make libclean
	@echo ${CYAN}"Compiling GNL:"${NC}
	@make all
	@echo ${CYAN}"Testing:"${NC}
	@make test_all