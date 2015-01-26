funkcje: każda w jednym pliku
można mieć 3 buffory
dodawanie 2 długich liczb
I/O w C

DUŻA LICZBA MA NP 2kB

1. Kod w C implementacje funkcje w C
2. zamieniać funkcje napisane w C na kod ASM
3. Aplication Binary Interface- rozdz 3 pkt 2 jak przekazywać parametry (do funkcji) [funkcja zawsze nadpisuje niektóre rejestry]
4. eax = wynik fuunkcji
5. używanie gcc -S (wyrzuca etap pośrdni, kod asemblerowy napisany w C) - wyłuskać naszą funkcję z tego co zrobi GCC -v       =? 
6. kompilacja: gcc -o nazwa programu pliki źródłowe np.: plik.c plik2.s
7. w C inicjalizacja procedury a w ASM deklaracja procedury

adresowanie względem RIP - instruction pointer
