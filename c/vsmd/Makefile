FLEX=flex
YACC=yacc -d

FLAGS=-Wall -W -O2

all :vsmd vsmctl #parser client server

vsmd: vsmd.c vsmd.h vsmsig.h
	$(CC) $(FLAGS) $^ -o $@ -ludev -lmodbus 

vsmclt: vsmctl.c vsmctl.h vsmsig.h
	$(CC) $(FLAGS) $^ -o $@

parser: parser.c parser_l parser_y
	$(CC) lex.yy.c y.tab.c $(FLAGS) -o $@

parser_l: parser.l
	$(FLEX) parser.l

parser_y: parser.y
	$(YACC) parser.y

client: client.c
	$(CC) $(FLAGS) $^ -o $@

server: server.c
	$(CC) $(FLAGS) $^ -o $@

clean: 
	rm -f vsmd vsmctl parser lex.yy.c y.tab.* base.tab.* client server *.o
