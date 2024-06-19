// Codificado por: Beastieux
// Convierte a números a letras
#include <iostream>
using namespace std;
 
int main() {
    int x;
     
    cout << "Ingrese un numero: " << endl;
    cin >> x;
     
    if (x < 1 || x > 999) {
        cout << "INGRESA UN NUMERO DEL 1 AL 999" << endl;
    } else {
        if (x >= 900) {
            cout << "NOVECIENTOS ";
            x = x - 900;
        } else if (x >= 800) {
            cout << "OCHOCIENTOS ";
            x = x - 800;
        } else if (x >= 700) {
            cout << "SETECIENTOS ";
            x = x - 700;
        } else if (x >= 600) {
            cout << "SEISCIENTOS ";
            x = x - 600;
        } else if (x >= 500) {
            cout << "QUINIENTOS ";
            x = x - 500;
        } else if (x >= 400) {
            cout << "CUATROCIENTOS ";
            x = x - 400;
        } else if (x >= 300) {
            cout << "TRESCIENTOS ";
            x = x - 300;
        } else if (x >= 200) {
            cout << "DOSCIENTOS ";
            x = x - 200;
        } else if (x > 100) {
            cout << "CIENTO ";
            x = x - 100;
        } else if (x == 100) {
            cout << "CIEN";
            x = x - 100;
        }
 
        if (x > 90) {
            cout << "NOVENTA Y ";
            x = x - 90;
        } else if (x == 90) {
            cout << "NOVENTA";
            x = x - 90;
        }
        // Repite el patrón para otros números (80, 70, 60, etc.)
         
        if (x == 1) {
            cout << "UNO";
            x = x - 1;
        }
    }
     
    cout << endl;
    cin.ignore();
    return 0;
}