/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_count_digits.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nkolosov <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/11/01 16:59:28 by nkolosov          #+#    #+#             */
/*   Updated: 2017/11/01 16:59:28 by nkolosov         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int		ft_count_digits(int value, int base)
{
	int ans;

	ans = 0;
	if (value == 0)
		return (1);
	while (value != 0)
	{
		ans++;
		value /= base;
	}
	return (ans);
}
