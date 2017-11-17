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

#include <stdio.h>

static char	*list_to_string(t_list *t)
{
	char	*ans;
	char	*str;
	int		i;
	int		j;
	t_list	*l;

	l = t;
	i = 0;
	while (l)
	{
		i += ft_strlen((char*)l->content);
		l = l->next;
	}
	ans = ft_strnew(i);
	l = t;
	i = -1;
	while (l)
	{
		j = -1;
		str = (char*)l->content;
		if (str)
			while (str[++j])
				ans[++i] = str[j];
		l = l->next;
	}
	return (ans);
}

int			get_next_line(const int fd, char **line)
{
	static char	*ostatok = NULL;
	char		*temp;
	char		*cont;
	char		buf[BUFF_SIZE + 1];
	int			ret;
	int			new_str_size;
	t_list		*readlist;

	if (BUFF_SIZE <= 0 || fd < 0 || line == NULL || read(fd, buf, 0) < 0)
		return (-1);
	//printf("Ostatok 2 \"%s\"\n", ostatok);
	if (ostatok && (cont = ft_memchr(ostatok, '\n', ft_strlen(ostatok))))
	{
		temp = ft_strdupab(ostatok, ft_strlen(ostatok) - ft_strlen(cont) + 1, ft_strlen(ostatok) - 1);
		*line = ft_strdupab(ostatok, 0, ft_strlen(ostatok) - ft_strlen(cont) - 1);
		free(ostatok);
		//printf("Second half : \"%s\"\n", temp);
		ostatok = temp[0] == '\0' ? NULL : ft_strdup(temp);
		free(temp);
		//printf("Res ostatok : \"%s\"\n", ostatok);
		return (1);
	}
	readlist = ft_lstnew(ostatok, ft_strlen(ostatok) + 1);
	//printf("Ostatok 3 \"%s\"\n", (char*)readlist->content);
	while ((ret = read(fd, buf, BUFF_SIZE)))
	{
		buf[ret] = '\0';
		new_str_size = ret - ft_strlen((char*)ft_memchr(buf, '\n', BUFF_SIZE));
		buf[new_str_size] = '\0';
		ft_lstpushback(&readlist, ft_lstnew(&buf, new_str_size + 1));
		if (ret != new_str_size)
			break ;
	}
	*line = list_to_string(readlist);
	ft_lstdel(&readlist, NULL);
	if (ostatok)
		free(ostatok);
	if (ret == 0 && (*line)[0] == '\0')
	{
		//printf("Ostatok 1 \"%s\"\n", ostatok);
		return (0);
	}
	ostatok = new_str_size == ret ? NULL : ft_strdup(&buf[new_str_size + 1]);
	//printf("Ostatok 1 \"%s\"\n", ostatok);
	return (1);
}
