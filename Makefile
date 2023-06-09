# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhendzel <dhendzel@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/12/21 20:12:24 by sbritani          #+#    #+#              #
#    Updated: 2023/04/10 02:38:17 by dhendzel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC		:= gcc
FLAGS	:= -Wall -Wextra -Werror -I lib/include/ -I lib/ -I src/
# FLAGS	:= -I lib/include/ -I lib/ -I src/
MLXLIB := libs/MLX42
# LDFLAGS	:= -L /home/linuxbrew/.linuxbrew/Cellar/glfw/3.3.8/lib/ -L $(MLXLIB)/include/MLX42 -L libs -lMLX42 -Iinclude -ldl -lglfw -pthread -lm
LDFLAGS	:= -L "$(shell brew --prefix glfw)/lib/" $(MLXLIB)/build/libmlx42.a -L libs -lglfw -lm -g
OBJ_DIR	:= obj/
SRC_DIR	:= src/
NAME	:= cub3d

SRC		:= checks.c \
			main.c \
			read_map.c \
			utils.c dict.c \
			textures.c \
			init.c \
			color.c \
			draw_wall.c \
			clean.c \
			create_map.c \
			move_rotate.c \
			map_check.c \
			math_utils.c \
			music.c
				
OBJS = $(FIL:.c=.o)
FIL =  $(addprefix src/, $(SRC)) 
libft_path=libs/libft/libft.a

all: libft libmlx $(NAME)

$(NAME): $(OBJ_DIR) $(OBJS) 
	$(CC) $(OBJS) $(libft_path) $(LDFLAGS) -o $(NAME)

$(OBJS): %.o : %.c
	gcc $(FLAGS) -c -o $@ $<


$(OBJ_DIR): 
	mkdir obj

libft:
	make --directory=./libs/libft

libmlx:
	cmake -B $(MLXLIB)/build $(MLXLIB)
	@$(MAKE) -C $(MLXLIB)/build
	
norm:
	norminette $(FIL) cub.h

clean:
	make clean --directory=libs/libft/
	rm -f $(OBJS)
	rm -rf obj

fclean: clean
	make fclean --directory=libs/libft/
	rm -rf $(MLXLIB)/build
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re libft libmlx

