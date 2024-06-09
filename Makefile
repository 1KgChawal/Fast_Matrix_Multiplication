NVCC=nvcc

FLAG=-g

EXECUTABLE=matrix_multiply.out

SOURCE=Matrix.cu main.cpp

OBJECTS=Matrix.cu.o main.o Matrix.o

Matrix.cu.o: Matrix.cu
	$(NVCC) $(FLAG) -o $@ -c $^

Matrix.o: Matrix.h
	$(NVCC) $(FLAG) -o $@ -c $^

main.o: main.cpp
	$(NVCC) $(FLAG) -o main.o -c main.cpp

$(EXECUTABLE): $(OBJECTS)
	$(NVCC) $(FLAG) -o $@ $^

clean:
	rm -rf *.o *.out