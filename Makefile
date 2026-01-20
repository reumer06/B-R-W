TARGET = main
SOURCE = main.cpp
CXX = g++
CXXFLAGS = -Wall -O2

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(CXX) $(CXXFLAGS) $(SOURCE) -o $(TARGET)

clean:
	rm -f $(TARGET)
