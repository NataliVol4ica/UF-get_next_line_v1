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

TESTNAMES = test0 \
			test1 \
			test2
RUN = sh run.sh
TESTCOMMANDS = $(patsubst %, $(RUN) % ;, $(TESTNAMES))
TOWRITE = $(patsubst %, > %_c;, $(TESTNAMES))
RED = '\033[0;31m'
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

test: $(NAME)
	$(TESTCOMMANDS)

tclean:
	rm -f *_t
