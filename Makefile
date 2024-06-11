NVCC = nvcc

FLAG = -g

EXECUTABLE = matrix_multiply.out

OBJECTS = main.o Matrix.o cudaFunction.o Error.o

all: $(EXECUTABLE)

cudaFunction.o: cudaFunction.cu cudaFunction.h.cu Error.cu
	$(NVCC) $(FLAG) -c -o $@ $<

Matrix.o: Matrix.cu Matrix.h cudaFunction.h.cu
	$(NVCC) $(FLAG) -c -o $@ $<

main.o: main.cu Matrix.h
	$(NVCC) $(FLAG) -c -o $@ $<

Error.o: Error.cu
	$(NVCC) $(FLAG) -c -o $@ $<

$(EXECUTABLE): $(OBJECTS)
	$(NVCC) $(FLAG) -o $@ $^

clean:
	rm -rf *.o *.out
