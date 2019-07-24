# make with make -f benacre_make.make

# COMPILER and LINKER MACROs
CC=g++
LD=g++

# COMPILER AND LINKER OPTION FLAGS MACRO
# -g option build tables for debugging
# -c option compile but do not try to link (yet)
# -Wall display all warning messages
# -pg is some sort of debugging option
# -O3 is an optimisation flag, not good for debugging
# -fopenmp is a flag for openmp directives
CFLAGS= -g -c -Wall -Werror -Wextra -pedantic -O3 $(INCDIR)
LDFLAGS= -g -Wall -O3

# SOURCE FILES MACROS IN DEPENDENCY ORDER? SHOULDNT MATTER THANKS TO HEADERS
SOURCES = ../RoBoCoP_CRN/RockyCoastCRN.cpp ../SeaLevel.cpp ../RPM.cpp ./RPM_CRN_Ensemble_Driver.cpp
ENSEMBLE_SOURCE =  ./RPM_CRN_Launch_Ensemble.cpp

# LIBRARIES MACRO
LIBS   = -lm -lstdc++ 

# OBJECT FILES SAME NAME AS SOURCES MACRO
OBJECTS=$(SOURCES:.cpp=.o)
ENSEMBLE_OBJECT = $(ENSEMBLE_SOURCE:.cpp=.o)

# EXECUTABLE MACRO
MODEL_EXECUTABLE = RPM_CRN.out
ENSEMBLE_EXECUTABLE = RPM_CRN_Ensemble.out

all: $(SOURCES) $(MODEL_EXECUTABLE)

$(MODEL_EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@

$(ENSEMBLE_EXECUTABLE): $(ENSEMBLE_OBJECT)
	$(CC) $(LDFLAGS) $(ENSEMBLE_OBJECT) $(LIBS) -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@

clean:
	rm -f ../*.o ../RoBoCoP_CRN/*.o *.o *.out *.xz *.xn 
