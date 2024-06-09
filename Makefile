NVCC=nvcc

FLAG=-g

SOURCE=Matrix.cu main.cpp

OBJECTS=Matrix.o main.o

EXECUTABLE=matrix_multiply.out

%.o: %.c++ %.h
	$(NVCC) $(FLAG) -o $@ -c $<

%.o: %.cu %.h
	$(NVCC) $(FLAG) -o $@ -c $<

main.o: main.cpp
	$(NVCC) $(FLAG) -o main.o -c main.cpp

$(EXECUTABLE): $(OBJECTS)
	$(NVCC) $(FLAG) -o $@ $^