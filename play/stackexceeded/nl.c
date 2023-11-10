/*
  convert every comma into comma-newline
  this is intended to make a Kinopio-generated JSON file
  readable in smaller chunks (line-by-line)
*/

#include <stdio.h>

int main (int argc, char **argv) {
  char c;
  for (;;) {
    c = getchar ();
    printf ("%c .. %x\n", c, c);
    if (c == EOF) break;
    if (c == ',') {
      putchar (',');
      putchar ('\n');
    } else {
      putchar (c);
    }
  }
}

  
