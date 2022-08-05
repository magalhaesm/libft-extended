NAME		= libft.a

SRCS		= ft_isalpha.c ft_toupper.c ft_isdigit.c ft_tolower.c ft_isalnum.c   \
				ft_isascii.c ft_isprint.c ft_strlen.c ft_strchr.c ft_strrchr.c   \
				ft_strncmp.c ft_strlcpy.c ft_strlcat.c ft_strnstr.c ft_memset.c  \
				ft_bzero.c ft_memcpy.c ft_memmove.c ft_memchr.c ft_memcmp.c      \
				ft_atoi.c ft_calloc.c ft_strdup.c ft_substr.c ft_strjoin.c       \
				ft_strtrim.c ft_split.c ft_itoa.c ft_strmapi.c ft_striteri.c     \
				ft_putchar_fd.c ft_putstr_fd.c ft_putendl_fd.c ft_putnbr_fd.c

BONUS		= ft_lstnew.c ft_lstadd_front.c ft_lstsize.c ft_lstlast.c            \
				ft_lstadd_back.c ft_lstdelone.c ft_lstclear.c ft_lstiter.c       \
				ft_lstmap.c

GNL			= gnl/get_next_line.c gnl/get_next_line_utils.c
GNL_OBJ	= $(GNL:.c=.o)
OPEN_MAX = $(shell getconf OPEN_MAX)

PRINTF		= ft_printf.c parser.c printer.c flags.c parse_utils.c types.c      \
				out_char.c out_string.c out_pointer.c out_signed.c              \
				out_unsigned.c out_percent.c print_utils.c
PRINTF_OBJ	= $(addprefix printf/obj/, $(PRINTF:.c=.o))

OBJDIR		= obj
OBJS		= $(addprefix $(OBJDIR)/, $(SRCS:.c=.o))
OBJS_BONUS	= $(addprefix $(OBJDIR)/, $(BONUS:.c=.o))

CFLAGS		= -Wall -Wextra -Werror
RM			= rm -f

all:		$(NAME)

$(NAME):	$(OBJDIR) $(OBJS) $(GNL_OBJ) $(PRINTF_OBJ)

bonus:		$(OBJDIR) $(OBJS) $(OBJS_BONUS) $(GNL_OBJ) $(PRINTF_OBJ)

$(OBJDIR):
		mkdir -p $(OBJDIR)

$(OBJDIR)/%.o:	%.c
		$(CC) $(CFLAGS) -c $< -o $@
		ar -rcs $(NAME) $@

gnl/%.o: gnl/%.c
		$(CC) $(CFLAGS) -D OPEN_MAX=$(OPEN_MAX) -c $< -o $@
		ar -rcs $(NAME) $@

$(PRINTF_OBJ):
		@make -C printf

clean:
		$(RM) $(OBJS)
		$(RM) $(OBJS_BONUS)
		$(RM) -r $(OBJDIR)
		$(RM) -r $(GNL_OBJ)
		@make fclean -C printf

fclean:		clean
		$(RM) $(NAME)

re:			fclean all

.PHONY:		all clean fclean re bonus gnl printf
