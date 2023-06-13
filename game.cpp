#include <Windows.h>
#include <TlHelp32.h>
#include <iostream>
#include <fstream>
#include <map>

uintptr_t GetModuleBaseAddress(DWORD procId, const wchar_t* modName) {
    uintptr_t modBaseAddr = 0;
    HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE | TH32CS_SNAPMODULE32, procId);
    if (hSnap != INVALID_HANDLE_VALUE) {
        MODULEENTRY32 modEntry;
        modEntry.dwSize = sizeof(modEntry);
        if (Module32First(hSnap, &modEntry)) {
            do {
                if (!_wcsicmp(modEntry.szModule, modName)) {
                    modBaseAddr = (uintptr_t)modEntry.modBaseAddr;
                    break;
                }
            } while (Module32Next(hSnap, &modEntry));
        }
    }
    else {
        std::cerr << "Erreur lors de la création du snapshot de module : " << GetLastError() << std::endl;
    }
    CloseHandle(hSnap);
    return modBaseAddr;
}

struct Position {
    float x;
    float y;
    float z;
};

int main(int argc, char** argv) {

    SetConsoleOutputCP(CP_UTF8);

    // Trouve la fenêtre du jeu avec le nom "OnlyUP  " à l'aide de la fonction FindWindow.
    HWND game_window = FindWindow(NULL, L"OnlyUP  ");
    // Vérifie si la fenêtre du jeu a été trouvée. Si ce n'est pas le cas, affiche un message d'erreur et termine le programme.
    if (!game_window) {
        std::cerr << "Impossible de trouver la fenêtre du jeu : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }

    // Déclare une variable pour stocker l'ID du processus du jeu.
    DWORD process_id = 0;
    // Obtient l'ID du processus du jeu à partir de la fenêtre du jeu.
    GetWindowThreadProcessId(game_window, &process_id);
    if (!process_id) {
        std::cerr << "Impossible d'obtenir l'ID du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }

    // Ouvre le processus du jeu avec tous les droits d'accès.
    HANDLE game_process = OpenProcess(PROCESS_ALL_ACCESS, true, process_id);
    if (!game_process) {
        std::cerr << "Impossible d'ouvrir le processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }

    const wchar_t* modName = L"OnlyUP-Win64-Shipping.exe";
    uintptr_t base_address = GetModuleBaseAddress(process_id, modName);
    //std::cout << "base_address: " << std::hex << base_address << std::endl;

    // ------------------------------------------------------------------------------------------------------------------------------------------------- //

    // Déclare une variable pour stocker l'adresse actuelle + ajoutez l'offset au début de l'adresse.
    uintptr_t current_address = base_address + 0x07356580;

    // Lit la mémoire du processus du jeu à l'adresse actuelle pour obtenir la prochaine adresse.
    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;

    // Lit la mémoire du processus du jeu à l'adresse actuelle pour obtenir la prochaine adresse.
    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;

    // Ajoute l'offset à l'adresse actuelle.
    current_address += 0x30;

    // Répète ce processus pour chaque offset.
    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;
    current_address += 0xA8;

    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;
    current_address += 0x50;

    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;
    current_address += 0xA60;

    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;
    current_address += 0xB0;

    if (!ReadProcessMemory(game_process, (void*)current_address, &current_address, sizeof(current_address), nullptr)) {
        std::cerr << "Erreur lors de la lecture de la mémoire du processus : " << GetLastError() << std::endl;
        system("pause");
        return 1;
    }
    //std::cout << "current_address: " << std::hex << current_address << std::endl;
    current_address += 0x270;

    /*uintptr_t splineDistCoord{ current_address };*/

    uintptr_t zCoord{current_address};
    current_address -= 0x8;
    uintptr_t yCoord{current_address};
    current_address -= 0x8;
    uintptr_t xCoord{current_address};


    struct Position {
        double x;
        double y;
        double z;
    };

    Position playerPos{0.0f,0.0f,0.0f};

    std::map<std::string, Position> sphereCenters = {
    {"apple", {1001.7933211551763, 24729.26093091442, 244607.69815349023}},
    {"canon", {-1218.3144574347732, 9229.317166448602, 198855.00671699742}},
    {"elevator", {4267.579973106438, 12122.855579612497, 90037.78212685045}},
    {"en passant", {-2853.2770738054314, 3869.818164765743, 171992.63464377387}},
    {"hand", {1543.5945130107618, 3831.9043039188127, 156198.9751636368}},
    {"heaven", {571.2188667704247, 15262.324235236578, 138287.2210593967}},
    {"highway", {6201.0996801397605, 9793.744348573371, 84027.92284009617}},
    {"oil", {4708.938725560206, 5209.9866486507935, 33897.75182034847}},
    {"space", {2369.6913367920856, 16509.086511950478, 283581.3835529041}},
    {"station", {2944.743379317719, 16212.330863895946, 8622.992720833052}},
    {"subway", {2506.8457100204464, 18064.940977585622, 48138.856266733674}},
    };

    /*std::string lastSphere = "";*/

    double sphereRadius = 150.0;  // supposez que le rayon de toutes les sphères

    boolean running{ true };
    while (running) {
        system("CLS");
        // mettez à jour la position du joueur ici
        ReadProcessMemory(game_process, (void*)xCoord, &playerPos.x, sizeof(playerPos.x), nullptr);
        ReadProcessMemory(game_process, (void*)yCoord, &playerPos.y, sizeof(playerPos.y), nullptr);
        ReadProcessMemory(game_process, (void*)zCoord, &playerPos.z, sizeof(playerPos.z), nullptr);

        /*std::cout << playerPos.x << std::endl;*/

        std::string currentSphere = "";
        for (const auto& sphere : sphereCenters) {
            std::string sphereName = sphere.first;
            Position centerPos = sphere.second;
            double distance = std::sqrt(std::pow(playerPos.x - centerPos.x, 2) + std::pow(playerPos.y - centerPos.y, 2) + std::pow(playerPos.z - centerPos.z, 2));  // calcule la distance entre le joueur et le centre de la sphère

            if (distance <= sphereRadius) {
                currentSphere = sphereName;
                break;
            }
        }


        if (!currentSphere.empty()) {
            std::cout << "Player has entered the " << currentSphere << " sphere." << std::endl;
            // Appellez ici votre fonction
            /*lastSphere = currentSphere;*/
        }

        Sleep(100);  // Ajoute un délai pour ne pas surcharger le CPU
    }

    //system("pause");

    return 0;
}