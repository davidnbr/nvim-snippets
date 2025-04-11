# nvim-snippets

# Vim Motion Practice Guide

This document outlines how to use the provided practice files to learn Vim motions effectively.

## Practice Files Overview

I've created 5 practice files, each focusing on different aspects of Vim motions:

1. **01_basic_movement.txt** - For practicing basic cursor movement (h, j, k, l)
2. **02_word_navigation.py** - For practicing word and line navigation (w, e, b, 0, ^, $)
3. **03_text_objects.tf** - For practicing text objects and operators (iw, aw, i", a", etc.)
4. **04_search_movements.sh** - For practicing jump motions and search-based movement
5. **05_marks_advanced.yaml** - For practicing marks and advanced techniques

Plus a comprehensive cheatsheet (`vim_motions_cheatsheet.md`) for reference.

## Recommended Practice Approach

### Session 1: Basic Movement (30 minutes)

1. Open `01_basic_movement.txt` in Vim: `vim 01_basic_movement.txt`
2. Disable arrow keys to force yourself to use h, j, k, l:

   ```
   :noremap <Up> <Nop>
   :noremap <Down> <Nop>
   :noremap <Left> <Nop>
   :noremap <Right> <Nop>
   ```

3. Practice moving your cursor to each of the X marks in the file using only h, j, k, l
4. Trace the path through the maze using only h, j, k, l
5. Exit Vim with `:q!` (quit without saving)

### Session 2: Word and Line Navigation (45 minutes)

1. Open `02_word_navigation.py`: `vim 02_word_navigation.py`
2. Practice these motions:
   - `w` to move forward word by word
   - `e` to move to the end of words
   - `b` to move backward word by word
   - `0` to jump to the start of a line
   - `^` to jump to the first non-whitespace character
   - `$` to jump to the end of a line
3. Exercises:
   - Move through the Python file using only `w`, `e`, and `b` to navigate between words
   - Jump to the beginning, first non-whitespace character, and end of several lines
   - Try to move to specific variables and function names quickly
   - Practice navigating through the docstrings and comments

### Session 3: Text Objects and Operators (60 minutes)

1. Open `03_text_objects.tf`: `vim 03_text_objects.tf`
2. Focus on these text objects and operators:
   - `iw` (inner word), `aw` (a word)
   - `i"` (inside quotes), `a"` (a quoted string)
   - `i{` (inside braces), `a{` (a block with braces)
   - `i(` (inside parentheses), `a(` (a block with parentheses)
   - Operators: `d` (delete), `c` (change), `y` (yank/copy)
3. Exercises:
   - Find a string in quotes (like `"us-west-2"`) and use `ci"` to change it
   - Find a block surrounded by `{}` (like in a resource definition) and use `ci{` to change its contents
   - Use `dw` to delete words, `cw` to change words
   - Find a list and use `di[` to delete its contents
   - Practice yanking with `yi{` to copy the contents of a block
4. Try combining operators with text objects:
   - `dit` to delete inside a tag
   - `ca{` to change a block including braces
   - `yi(` to yank inside parentheses

### Session 4: Jump Motions and Search (45 minutes)

1. Open `04_search_movements.sh`: `vim 04_search_movements.sh`
2. Practice these motions:
   - `%` to jump between matching brackets
   - `[[` and `]]` to jump between function definitions
   - `{` and `}` to jump between paragraphs
   - `/pattern` to search forward
   - `?pattern` to search backward
   - `n` and `N` to continue searching
   - `*` to search for the word under cursor
3. Exercises:
   - Use `%` to jump between matching `if` and `fi` statements in the script
   - Use `[[` and `]]` to jump between function definitions
   - Use `{` and `}` to navigate between the main sections of the script
   - Search for "ERROR" with `/ERROR` and navigate to each occurrence with `n`
   - Place your cursor on a variable name and use `*` to find all instances

### Session 5: Marks and Advanced Techniques (60 minutes)

1. Open `05_marks_advanced.yaml`: `vim 05_marks_advanced.yaml`
2. Practice setting and using marks:
   - `ma` to set mark 'a' at current position
   - `'a` to jump to the line of mark 'a'
   - `` `a `` to jump to the exact position of mark 'a'
3. Practice advanced techniques:
   - Using counts with motions: `3w`, `5j`, etc.
   - Combining operators, counts, and motions: `d2j`, `c3w`, etc.
4. Exercises:
   - Set marks at important sections of the file (e.g., `ma` at the "ORBS" section)
   - Navigate to other parts of the file, then use `'a` to return to your marks
   - Try `` `a `` to return to the exact position of a mark
   - Use `3w` to move forward 3 words at a time
   - Use `d2j` to delete 2 lines down
   - Use `c3w` to change 3 words

### Daily Practice (15-30 minutes)

1. Open any of the practice files or use your own code files
2. Set specific goals for each practice session:
   - "Today I will practice text objects with the change operator"
   - "Today I will focus on using marks to navigate efficiently"
3. Try to incorporate what you've learned into your actual work
4. Refer to the cheatsheet as needed, but try to rely on memory

## Tips for Effective Learning

1. **Focus on consistency**: Daily short practice is better than occasional long sessions
2. **Start small**: Master a few motions before adding new ones
3. **Use mnemonics**: For example, `w` is "word", `b` is "back", `f` is "find"
4. **Force yourself**: Temporarily disable arrow keys and other "crutches"
5. **Set specific challenges**: "Edit this file without using the arrow keys" or "Make these 10 edits using only text objects"

## Progression Path

1. **Basic Movement** (h, j, k, l)
2. **Word Navigation** (w, e, b)
3. **Line Navigation** (0, ^, $)
4. **Simple Editing** (dd, yy, p)
5. **Text Objects** (iw, aw, i", a")
6. **Operators with Motions** (dw, c$, yi{)
7. **Search and Replace** (/, ?, n, N, *)
8. **Marks** (m, ', `)
9. **Advanced Combinations** (counts, complex edits)

Remember, it's not about learning all motions at once, but building muscle memory for the ones you use most frequently in your workflow.

