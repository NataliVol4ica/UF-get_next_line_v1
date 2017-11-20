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

t_list	*get_list_elem(t_list **l, const int fd)
{
	t_list	*t;

	t = *l;
	while (t)
	{
		if (t->content_size == (size_t)fd)
		{
			/*printf("Try free\n");
			ft_memdel(&t->content);
			printf("Free succ\n");*/
			return (t);
		
		}
		t = t->next;
	}
	if ((t = ft_lstnew(NULL, 0)))
	{
		t->content_size = (size_t)fd;
		ft_lstpushback(l, t);
		return (t);
	}
	return (NULL);
}

int			get_next_line(const int fd, char **line)
{
	static t_list	*fd_list = NULL;
	t_list			*fd_elem;
	char			*ostatok;
	//static char		*ostatok = NULL;
	char			*temp;
	char			*cont;
	char			buf[BUFF_SIZE + 1];
	int				ret;
	int				new_str_size;
	t_list			*readlist;

	if (BUFF_SIZE <= 0 || fd < 0 || line == NULL || read(fd, buf, 0) < 0)
		return (-1);
	new_str_size = 0;
	fd_elem = get_list_elem(&fd_list, fd);
	/*printf("Try free\n");
	ft_memdel(&fd_elem->content);
	printf("Free succ\n");*/
	ostatok = ft_strdup((char*)fd_elem->content);
	//printf("Ostatok at the beginning = \"%s\"\n             In list it is \"%s\"\n", ostatok, (char*)fd_elem->content);
	if (ostatok && (cont = ft_memchr(ostatok, '\n', ft_strlen(ostatok))))
	{
		temp = ft_strdupab(ostatok, ft_strlen(ostatok) - ft_strlen(cont) + 1, ft_strlen(ostatok) - 1);
		*line = ft_strdupab(ostatok, 0, ft_strlen(ostatok) - ft_strlen(cont) - 1);
		free(ostatok);
		//printf("Second half : \"%s\"\n", temp);
		ft_memdel(&fd_elem->content);
		fd_elem->content = temp[0] == '\0' ? NULL : (void*)ft_strdup(temp);
		free(temp);
		//printf("Res ostatok : \"%s\"\n", ostatok);
		//printf("Returning 1 after nonempty ostatok\n");
		//printf("Ostatok in the end = \"%s\"\n       In list it is \"%s\"\n", ostatok, (char*)fd_elem->content);
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
	*line = ft_list_to_string(readlist);
	ft_lstdel(&readlist, NULL);
	if (ostatok)
		free(ostatok);
	if (ret == 0 && (*line)[0] == '\0')
		return (0);
	//printf("Ostatok in list before free \"%s\"\n", (char*)fd_elem->content);
	ft_memdel(&fd_elem->content);
	//printf("Free succ\n");
	fd_elem->content = (new_str_size == ret || ret == 0)? NULL : (void*)ft_strdup(&buf[new_str_size + 1]);
	//printf("Ostatok in the end \"%s\"\n", (char*)fd_elem->content);
	return (1);
}
