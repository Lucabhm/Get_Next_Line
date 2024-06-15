NAME = get_next_line.a
NAMEB = get_next_line_bonus.a
CFLAGS = -Wall -Wextra -Werror

SRC = get_next_line.c \
	get_next_line_utils.c
SRCB = get_next_line_bonus.c \
	get_next_line_utils_bonus.c

OBJ = $(SRC:.c=.o)
OBJB = $(SRCB:.c=.o)
OBJDIR = objs/
OBJDIRB = objsb/
OBJS_PATH = $(addprefix $(OBJDIR), $(OBJ))
OBJS_PATHB = $(addprefix $(OBJDIRB), $(OBJB))

all:			$(NAME)

$(NAME):		$(OBJS_PATH)
				ar rc $(NAME) $(OBJS_PATH)

bonus:			$(OBJS_PATHB)
				ar rc $(NAMEB) $(OBJS_PATHB)

$(OBJDIR)%.o: %.c
				@mkdir -p $(dir $@)
				@cc -c $< -o $@ $(CFLAGS)

$(OBJDIRB)%.o: %.c
				@mkdir -p $(dir $@)
				@cc -c $< -o $@ $(CFLAGS)

clean:
				@rm -rf $(OBJDIR)
				@rm -rf $(OBJDIRB)

fclean:			clean
				@rm -f $(NAME)
				@rm -f $(NAMEB)