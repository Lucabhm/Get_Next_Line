NAME = lib_get_next_line.a
NAMEB = lib_get_next_line_bonus.a
CFLAGS = -Wall -Werror -Wextra
SRC = get_next_line.c \
	get_next_line_utils.c
SRCBONUS = get_next_line_bonus.c \
	get_next_line_utils_bonus.c

OBJDIR = objs/
OBJ = $(SRC:.c=.o)
OBJBONUS = $(SRCBONUS:.c=.o)
OBJS_PATH = $(addprefix $(OBJDIR), $(OBJ))
OBJS_PATHB = $(addprefix $(OBJDIR), $(OBJBONUS))

$(NAME):	logo $(OBJS_PATH)
			@ar rc $(NAME) $(OBJS_PATH)

bonus:		logo $(OBJDIR) $(OBJS_PATHB)
			@ar rc $(NAME) $(OBJS_PATHB)

all:		$(OBJDIR) $(NAME)

$(OBJDIR)%.o: %.c | $(OBJDIR)
			@mkdir -p $(dir $@)
			@cc -c $< -o $@ $(CFLAGS)
			@if [ "$(filter $<,$(SRC))" ]; then $(MAKE) progress; fi
			@if [ "$(filter $<,$(SRCBONUS))" ]; then $(MAKE) progressb; fi

$(OBJDIR):
			@mkdir -p $(OBJDIR)

progress:
			@$(eval PROGRESS := $(shell echo $$(($(shell find $(SRC) -name '*.c' | wc -l) - $$(find $(OBJDIR) -name '*.o' | wc -l)))))
			@$(eval TOTAL := $(shell find $(SRC) -name '*.c' | wc -l))
			@$(eval PERCENT := $(shell echo "scale=2; (1 - $(PROGRESS) / $(TOTAL)) * 100" | bc))
			@$(eval BAR := $(shell printf '=%.0s' {1..$(shell echo "scale=0; $(PERCENT) / 2" | bc)}))
			@printf "\r[%-50s] %s%%" "$(BAR)" "$(PERCENT)"
			@if [ "$(PERCENT)" = "100.00" ]; then printf "\n"; fi
			@if [ "$(PERCENT)" = "100.00" ]; then printf "\033[0;32mget_next mandotory compiled\033[0m\n"; fi

progressb:
			@$(eval PROGRESSB := $(shell echo $$(($(shell find $(SRCBONUS) -name '*.c' | wc -l) - $$(find $(OBJDIR) -name '*bonus.o' | wc -l)))))
			@$(eval TOTALB := $(shell find $(SRCBONUS) -name '*.c' | wc -l))
			@$(eval PERCENTB := $(shell echo "scale=2; (1 - $(PROGRESSB) / $(TOTALB)) * 100" | bc))
			@$(eval BARB := $(shell printf '=%.0s' {1..$(shell echo "scale=0; $(PERCENTB) / 2" | bc)}))
			@printf "\r[%-50s] %s%%" "$(BARB)" "$(PERCENTB)"
			@if [ "$(PERCENTB)" = "100.00" ]; then printf "\n"; fi
			@if [ "$(PERCENTB)" = "100.00" ]; then printf "\033[0;32mget_next bonus compiled\033[0m\n"; fi

clean:
			@rm -rf $(OBJDIR)

fclean:		clean
			@rm -f $(NAME)

re: fclean all

logo:
			@echo "   ___ ___ _____   _  _ _____  _______ "
			@echo "  / __| __|_   _| | \| | __\ \/ /_   _|"
			@echo " | (_ | _|  | |   | .  | _| >  <  | |  "
			@echo "  \___|___| |_|   |_|\_|___/_/\_\ |_|  "
			@echo "                                       "

.PHONY: all clean fclean re bonus progress progressb logo