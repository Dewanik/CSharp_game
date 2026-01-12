#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <switch.h>

int main(int argc, char *argv[]) {
    (void)argc; (void)argv;

    gfxInitDefault();
    consoleInit(NULL);

    printf("========================================\n");
    printf("Graphics Hello World\n");
    printf("========================================\n\n");

    printf("This program uses libnx graphics + consoleInit.\n");
    printf("Press + (PLUS) to exit.\n\n");

    int boxW = 12;
    int boxH = 5;
    int maxX = 30;
    int x = 0;
    int dir = 1;

    while (appletMainLoop()) {
        hidScanInput();
        u64 kDown = hidKeysDown(CONTROLLER_P1_AUTO);
        if (kDown & KEY_PLUS) break;

        consoleClear();

        for (int y = 0; y < boxH; y++) {
            for (int s = 0; s < x; s++) printf(" ");
            for (int w = 0; w < boxW; w++) printf("#");
            printf("\n");
        }

        printf("\nUse + to exit. Moving ASCII box (graphical console).\n");
        consoleUpdate(NULL);

        x += dir;
        if (x <= 0 || x >= maxX) dir = -dir;

        gfxFlushBuffers();
        gfxSwapBuffers();
        gfxWaitForVblank();
    }

    gfxExit();
    return 0;
}
