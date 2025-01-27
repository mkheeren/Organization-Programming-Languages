# Name: Mary Kait Heeren
# HW: HW 1
# Language: Python
# 3 methods: main, loadDiagnostics & checkPower
# Purpose: Must analyze a diagnostic report (list of binary numbers: Each line is one binary number and all binary numbers are the same length)
#          by loading the diagnostics, calculating the gamma rate, epsilon rate, and power consumption and return values


# Purpose: import file and get data
# Input: N/A
# Output: data from the file
def loadDiagnostics():
    while True:
        name = input()
        try:
            file = open(name, "r")
            data = [line.strip() for line in file.readlines()]
            file.close()
            print("Loading diagnostics...")
            #print(data)
            return data
        except FileNotFoundError:
            print("error: file not found")

# Purpose: find the gamma rate, epsilon rate, and power consumption
# Input: data gathered from loadDiagnostics
# Output: the calculated gamma rate, epsilon rate, and power consumption
def checkPower(data):
    numOfBits = len(data[0])
    #print(numOfBits)
    gammaBits = []
    epsBits = []
    for i in range(numOfBits):
        bits_now = [line[i] for line in data]
        countsOne = bits_now.count('1')
        countsZero = bits_now.count('0')
        if(countsOne >= countsZero):
            gammaBits.append('1')
            epsBits.append('0')
        else:
            gammaBits.append('0')
            epsBits.append('1')
    gamma = int(''.join(gammaBits), 2)
    print("Gamma rate computed...")
    #print(gamma)
    eps = int(''.join(epsBits), 2)
    print("Epsilon rate computed...")
    #print(eps)
    powerConsumption = gamma * eps
    return powerConsumption    
            

# Purpose: call loadDiagnostics and checkPower methods
# Input/Output: N/A (calls other two methods)
def main():
    data = loadDiagnostics()
    print("Power Consumption rate: ", checkPower(data))

#call main method
main()