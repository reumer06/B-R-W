TARGET = main
SOURCE = main.c
CC = gcc

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(CC) $(SOURCE) -o $(TARGET) -lm

clean:
	rm -f $(TARGET)
