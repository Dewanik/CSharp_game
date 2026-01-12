#include <switch.h>
#include <stdio.h>

// Simple Hello World for Nintendo Switch using libnx
int main(int argc, char* argv[])
{
    // Initialize console
    consoleInit(NULL);
    
    // Print Hello World
    printf("Hello World!\n");
    printf("ARM Development Environment Ready\n");
    printf("Nintendo Switch Development\n");
    
    // Wait for user input
    printf("\nPress + to exit\n");
    
    while (appletMainLoopShouldExit() == false)
    {
        hidScanInput();
        u32 kDown = hidKeyboardDown(KBD_NONE);
        
        if (kDown & HidNpadButton_Plus)
            break;
        
        consoleUpdate(NULL);
    }
    
    // Close console
    consoleExit(NULL);
    
    return 0;
}
