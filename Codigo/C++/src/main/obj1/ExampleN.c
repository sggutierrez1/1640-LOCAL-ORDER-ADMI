// Codificado por Beastieux
// Ingreso de edades, cálculo del mayor, menor, promedio y número de edades leídas.
#include <iostream>
 
using namespace std;
 
void compara();
 
int main() {
    int i = 0, j, k, n[100];
    float prom, c = 0, sum = 0;
    char sn;
 
    cout << "Para terminar ingrese 'cero(0)'\n";
     
    do {
    inicio:
        cout << "Ingrese edad " << i + 1 << " : ";
        cin >> n[i];
         
        if (n[i] < 0) {
            system("cls");
            cout << "Edad inválida.\n";
            cout << "Para volver a intentar pulse s/S.\n";
            cout << "Para terminar de intentar pulse cualquier otro caracter.";
            cin >> sn;
            system("cls");
             
            if (sn == 's' || sn == 'S') {
                goto inicio;
            } else {
                n[i] = 0;
            }
        }
         
        sum = sum + n[i];
        i++;
        c++;
    } while (n[i - 1] != 0);
 
    prom = sum / (c - 1);
 
    // Ordenamiento de las edades de mayor a menor
    for (i = 1; i < c; i++) {
        for (j = 0; j < c - i; j++) {
            if (n[j] < n[j + 1]) {
                k = n[j];
                n[j] = n[j + 1];
                n[j + 1] = k;
            }
        }
    }
 
    // Mostrar edades ordenadas
    for (i = 0; i < c - 1; i++) {
        cout << n[i] << endl;
    }
 
    if (c != 1) {
        cout << "Mayor: " << n[0] << endl;
        cout << "Menor: " << n[c - 2] << endl;
        cout << "Promedio: " << prom << endl;
        cout << "Número de edades leídos: " << c - 1 << endl << endl;
    }
 
    return 0;
}