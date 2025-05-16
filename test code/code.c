#include <stdio.h>
#include <stdlib.h>
#include <time.h>
 
// Function that simulates a random branching decision
int random_branch() {
    return rand() % 2;  // Return either 0 or 1 (mimic true/false or taken/not taken)
}
 
// Function that simulates complex branching
void complex_branching(int iterations) {
    int i, j;
    int decision;
    for (i = 0; i < iterations; i++) {
        // Outer loop branches based on a simple modulus pattern
        if (i % 5 == 0) {
            // First complex decision (based on i)
            decision = random_branch(); // Random decision
            if (decision) {
                printf("Iteration %d: Branch 1 taken\n", i);
            } else {
                printf("Iteration %d: Branch 1 not taken\n", i);
            }
        } else if (i % 5 == 1) {
            // Second complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 2 taken\n", i);
            } else {
                printf("Iteration %d: Branch 2 not taken\n", i);
            }
        } else if (i % 5 == 2) {
            // Third complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 3 taken\n", i);
            } else {
                printf("Iteration %d: Branch 3 not taken\n", i);
            }
        } else if (i % 5 == 3) {
            // Fourth complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 4 taken\n", i);
            } else {
                printf("Iteration %d: Branch 4 not taken\n", i);
            }
        } else {
            // Fifth complex decision
            decision = random_branch();
            if (decision) {
                printf("Iteration %d: Branch 5 taken\n", i);
            } else {
                printf("Iteration %d: Branch 5 not taken\n", i);
            }
        }
 
        // Nested loop with additional branching
        for (j = 0; j < 3; j++) {
            // Simulate some branching inside nested loop
            decision = random_branch();
            if (decision) {
                printf("   Inner Loop %d: Branch taken\n", j);
            } else {
                printf("   Inner Loop %d: Branch not taken\n", j);
            }
        }
    }
}
 
int main() {
    int iterations; // Declare variables at the beginning of the block
    
    // Initialize the random number generator
    srand(time(NULL));
 
    // Set the number of iterations for the complex branching test
    iterations = 100;  // You can change this for larger tests
 
    printf("Advanced Branch Prediction Test\n");
    printf("Simulating complex branching with random decisions...\n");
 
    // Call the function to simulate the complex branching behavior
    complex_branching(iterations);
 
    return 0;
}
 
