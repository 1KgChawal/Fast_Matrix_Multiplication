NVCC=nvcc

FLAG=-g

EXECUTABLE=matrix_multiply.out

OBJECTS=main.o Matrix.o cudaFunction.o

cudaFunction.o: cudaFunction.cu cudaFunction.h
	$(NVCC) $(FLAG) -c -o $@ cudaFunction.cu

Matrix.o: Matrix.cu Matrix.h cudaFunction.h
	$(NVCC) $(FLAG) -c -o $@ Matrix.cu

main.o: main.cu Matrix.h
	$(NVCC) $(FLAG) -c -o $@ main.cu

$(EXECUTABLE): $(OBJECTS)
	$(NVCC) $(FLAG) -o $@ $^

clean:
	rm -rf *.o *.out
