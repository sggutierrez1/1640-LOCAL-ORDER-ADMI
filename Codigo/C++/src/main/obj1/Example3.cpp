// vulnerable_code.cpp
#include <iostream>
#include <cstring>
#include <string>
#include <vector>

using namespace std;

// Function declarations
void bufferOverflow(char* input);
void useAfterFree();
void uninitializedVariable();
void sqlInjection(string userInput);
void integerOverflow();
void nullPointerDereference();
void dangerousFunction();
void memoryLeak();
void improperErrorHandling(int* ptr);
void insecureRandom();
void hardcodedCredentials();
void outOfBoundsAccess();
void formatStringVulnerability(string userInput);
void doubleFree();
void raceCondition();
void stackOverflow();
void unvalidatedInput(string userInput);
void deprecatedFunctions();
void missingReturnValue();
void improperLocking();

int main() {
    char input[10];
    cout << "Enter input: ";
    cin >> input;
    bufferOverflow(input);
    useAfterFree();
    uninitializedVariable();
    sqlInjection("admin' OR '1'='1");
    integerOverflow();
    nullPointerDereference();
    dangerousFunction();
    memoryLeak();
    int* ptr = nullptr;
    improperErrorHandling(ptr);
    insecureRandom();
    hardcodedCredentials();
    outOfBoundsAccess();
    formatStringVulnerability("%x %x %x");
    doubleFree();
    raceCondition();
    stackOverflow();
    unvalidatedInput("<script>alert('XSS')</script>");
    deprecatedFunctions();
    missingReturnValue();
    improperLocking();

    return 0;
}

void bufferOverflow(char* input) {
    char buffer[10];
    strcpy(buffer, input); // Vulnerability: Buffer overflow
}

void useAfterFree() {
    int* ptr = new int(5);
    delete ptr;
    cout << *ptr << endl; // Vulnerability: Use after free
}

void uninitializedVariable() {
    int x;
    cout << x << endl; // Vulnerability: Uninitialized variable
}

void sqlInjection(string userInput) {
    string query = "SELECT * FROM users WHERE username = '" + userInput + "'"; // Vulnerability: SQL Injection
    cout << query << endl;
}

void integerOverflow() {
    int x = INT_MAX;
    x += 1; // Vulnerability: Integer overflow
    cout << x << endl;
}

void nullPointerDereference() {
    int* ptr = nullptr;
    cout << *ptr << endl; // Vulnerability: Null pointer dereference
}

void dangerousFunction() {
    char command[100];
    cout << "Enter command: ";
    cin >> command;
    system(command); // Vulnerability: Command injection
}

void memoryLeak() {
    int* ptr = new int[10];
    // No delete call, memory leak
}

void improperErrorHandling(int* ptr) {
    // Vulnerability: Improper error handling
    if (!ptr) {
        cout << "Error: null pointer" << endl;
    }
}

void insecureRandom() {
    int random = rand(); // Vulnerability: Insecure random number generation
    cout << "Random number: " << random << endl;
}

void hardcodedCredentials() {
    string username = "admin";
    string password = "password"; // Vulnerability: Hardcoded credentials
    cout << "Username: " << username << " Password: " << password << endl;
}

void outOfBoundsAccess() {
    vector<int> vec(5);
    cout << vec[10] << endl; // Vulnerability: Out of bounds access
}

void formatStringVulnerability(string userInput) {
    printf(userInput.c_str()); // Vulnerability: Format string
}

void doubleFree() {
    int* ptr = new int;
    delete ptr;
    delete ptr; // Vulnerability: Double free
}

void raceCondition() {
    static int counter = 0;
    for (int i = 0; i < 1000; ++i) {
        counter++; // Vulnerability: Race condition
    }
    cout << counter << endl;
}

void stackOverflow() {
    int arr[1000000]; // Vulnerability: Stack overflow
    arr[0] = 1;
    cout << arr[0] << endl;
}

void unvalidatedInput(string userInput) {
    cout << "User input: " << userInput << endl; // Vulnerability: Unvalidated input
}

void deprecatedFunctions() {
    char str[100];
    gets(str); // Vulnerability: Use of deprecated function
}

void missingReturnValue() {
    int func() { // Vulnerability: Missing return value
        int x = 5;
    }
    cout << func() << endl;
}

void improperLocking() {
    // Vulnerability: Improper locking
    static int counter = 0;
    counter++;
    cout << counter << endl;
}
