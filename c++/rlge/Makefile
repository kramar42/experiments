
INCLUDE=-Iinclude -I../libs/SDL-1.2.15/include/SDL -I../libs/SDL_ttf-2.0.10/include
LIBS=-L../libs/SDL-1.2.15/lib -L../libs/SDL_ttf-2.0.10/lib
LINKER=-lmingw32 -lSDLmain -lSDL -lSDL_ttf -mwindows

DIR=d:/code/the-game

rlg:
	g++ $(DIR)/src/*.cpp $(INCLUDE) $(LIBS) $(LINKER) -Wall -o the-game

tags:
	ctags -f $(DIR)/TAGS -e -R $(DIR)/include $(DIR)/src

clean:
	del the-game.exe
