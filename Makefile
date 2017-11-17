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

RED = '\033[0;31m'
NC = '\033[0m' # No Color

all: $(NAME)

$(NAME):
	#make -C libft/ fclean && make -C libft/
	clang -Wall -Wextra -Werror -I libft/includes -o get_next_line.o -c get_next_line.c
	clang -Wall -Wextra -Werror -I libft/includes -o main.o -c main.c
	clang -o test_gnl main.o get_next_line.o -I libft/includes -L libft/ -lft
	clear

clean:
	/bin/rm get_next_line.o main.o

fclean: clean
	/bin/rm $(NAME)

re: fclean all

norm:
	clear
	norminette get_next_line.c

v2:
	clang -Wall -Wextra -Werror -I libft/includes -o get_next_line.o -c get_next_line.c
	clang -Wall -Wextra -Werror -I libft/includes -o gnl7_1.o -c gnl7_1.c
	clang -o test_gnl gnl7_1.o get_next_line.o -I libft/includes -L libft/ -lft
	clear

vre: 
	/bin/rm $(NAME)
	/bin/rm get_next_line.o gnl7_1.
	make v2
