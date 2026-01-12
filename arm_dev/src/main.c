#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <switch.h>

int main(int argc, char *argv[]) {
    // Simple hello world with minimal dependencies
    // This avoids runtime issues on actual Switch hardware
    
    printf("========================================\n");
    printf("Nintendo Switch Hello World\n");
    printf("========================================\n\n");
    
    printf("✓ Program compiled successfully!\n");
    printf("✓ Running on Nintendo Switch\n");
    printf("✓ This is a basic test program\n\n");
    
    printf("Build timestamp: %s %s\n", __DATE__, __TIME__);
    printf("Arguments: %d\n\n", argc);
    
    printf("Program completed successfully!\n");
    printf("========================================\n");
    
    return 0;
}
