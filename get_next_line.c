/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nkolosov <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/11/16 15:31:39 by nkolosov          #+#    #+#             */
/*   Updated: 2017/11/16 15:31:39 by nkolosov         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include "libft.h"
#include "get_next_line.h"

static char	*list_to_string(t_list *t)
{
	char	*ans;
	int		len;
	t_list	*l;

	l = t;
	len = 0;
	while (l)
	{
		len += ft_strlen((char*)l->content);
		l = l->next;
	}
	ans = ft_strnew(len);
	l = t;
	while (l)
	{
		ft_strcat(ans, (char*)l->content);
		l = l->next;
	}
	return (ans);
}

int			get_next_line(const int fd, char **line)
{
	static int	curpos = 0;
	char		buf[BUFF_SIZE + 1];
	int			ret;
	int			new_str_size;
	t_list		*readlist;

	readlist = NULL;
	if (BUFF_SIZE <= 0 || fd < 0)
		return (-1);
	lseek(fd, curpos, 0);
	while ((ret = read(fd, buf, BUFF_SIZE)))
	{
		buf[ret] = '\0';
		new_str_size = ret - ft_strlen((char*)ft_memchr(buf, '\n', BUFF_SIZE));
		buf[new_str_size] = '\0';
		ft_lstpushback(&readlist, ft_lstnew(&buf, new_str_size + 1));
		curpos += ret != new_str_size ? new_str_size + 1 : ret;
		if (ret != new_str_size)
			break ;
	}
	*line = list_to_string(readlist);
	ft_lstdel(&readlist, NULL);
	if (ret == 0)
		return (0);
	return (1);
}
