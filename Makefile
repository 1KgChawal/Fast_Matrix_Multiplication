NVCC=nvcc

FLAG=-g

EXECUTABLE=matrix_multiply.out

SOURCE=Matrix.cu main.cu

OBJECTS=main.o Matrix.o

Matrix.o: Matrix.cu Matrix.h cudaFunction.cu
	$(NVCC) $(FLAG) -c -o $@ $<

main.o: main.cu Matrix.h
	$(NVCC) $(FLAG) -c -o $@ $<

$(EXECUTABLE): $(OBJECTS)
	$(NVCC) $(FLAG) -o $@ $^

clean:
	rm -rf *.o *.out
