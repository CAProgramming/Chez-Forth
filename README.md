# Chez-Forth
A Forth interpreter written in Chez Scheme

- You can install Chez Scheme via brew like this:
```bash
$ brew install chezscheme
```
- And invoke it like this:
```bash
$ chez --script __filename__
```
- Given that a word is not found in the dictionary, 
- Or if a symbol is considered invalid, an error is reported

## For those new to Forth:
- A "word" (a function) is defined like this:
```forth
: my_word 2 3 4 + + . ;
```
- Whenever ```my_word``` is used, 2, 3, and 4 is pushed onto the stack, addition is applied twice, and the result is popped off and printed to stdout.
- All actions in forth are based on calling words, or just pushing and popping elements from the stack. You should get the hang of it pretty quickly!
