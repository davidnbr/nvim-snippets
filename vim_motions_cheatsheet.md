# Vim Motions Cheatsheet

## Basic Navigation

| Motion | Description |
|--------|-------------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |

## Word Navigation

| Motion | Description |
|--------|-------------|
| `w` | Move to start of next word |
| `e` | Move to end of current/next word |
| `b` | Move to beginning of current/previous word |
| `W` | Move to next WORD (space-separated) |
| `E` | Move to end of WORD |
| `B` | Move to beginning of previous WORD |

## Line Navigation

| Motion | Description |
|--------|-------------|
| `0` | Move to start of line (first column) |
| `^` | Move to first non-blank character of line |
| `$` | Move to end of line |

## Vertical Movement

| Motion | Description |
|--------|-------------|
| `gg` | Move to first line of document |
| `G` | Move to last line of document |
| `:{number}` | Move to specific line number |
| `{number}G` | Move to specific line number |
| `Ctrl+u` | Move half page up |
| `Ctrl+d` | Move half page down |
| `Ctrl+b` | Move full page up (back) |
| `Ctrl+f` | Move full page down (forward) |

## Character Search Within Line

| Motion | Description |
|--------|-------------|
| `f{char}` | Move to next occurrence of character |
| `F{char}` | Move to previous occurrence of character |
| `t{char}` | Move to before next occurrence of character |
| `T{char}` | Move to after previous occurrence of character |
| `;` | Repeat last f, F, t, or T motion |
| `,` | Repeat last f, F, t, or T motion in opposite direction |

## Text Objects

| Object | Description |
|--------|-------------|
| `iw` | Inner word |
| `aw` | A word (includes trailing space) |
| `is` | Inner sentence |
| `as` | A sentence |
| `ip` | Inner paragraph |
| `ap` | A paragraph |
| `i"` | Inside double quotes |
| `a"` | A double-quoted string |
| `i'` | Inside single quotes |
| `a'` | A single-quoted string |
| `i(` or `i)` | Inside parentheses |
| `a(` or `a)` | A pair of parentheses |
| `i[` or `i]` | Inside brackets |
| `a[` or `a]` | A pair of brackets |
| `i{` or `i}` | Inside braces |
| `a{` or `a}` | A pair of braces |
| `it` | Inside XML/HTML tags |
| `at` | A XML/HTML tag block |

## Operators

| Operator | Description |
|----------|-------------|
| `d` | Delete (cut) |
| `c` | Change (delete and enter insert mode) |
| `y` | Yank (copy) |
| `>` | Indent |
| `<` | Outdent |
| `=` | Auto-format |
| `~` | Toggle case |
| `!` | Filter through external command |

## Operator + Motion Examples

| Command | Description |
|---------|-------------|
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `dd` | Delete current line |
| `cw` | Change word |
| `cc` | Change entire line |
| `yy` | Yank entire line |
| `ci"` | Change inside double quotes |
| `di{` | Delete inside curly braces |
| `ya(` | Yank a pair of parentheses (including parentheses) |
| `dt.` | Delete until dot |

## Jump Motions

| Motion | Description |
|--------|-------------|
| `%` | Jump to matching bracket/parenthesis |
| `[[` | Jump to previous function/section start |
| `]]` | Jump to next function/section start |
| `{` | Jump to previous empty line |
| `}` | Jump to next empty line |

## Search-based Movement

| Motion | Description |
|--------|-------------|
| `/{pattern}` | Search forward for pattern |
| `?{pattern}` | Search backward for pattern |
| `n` | Repeat search in same direction |
| `N` | Repeat search in opposite direction |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |

## Marks

| Command | Description |
|---------|-------------|
| `m{a-zA-Z}` | Set mark at current position |
| `'{a-z}` | Jump to line of mark |
| ``{a-z}` | Jump to position (line and column) of mark |
| `:marks` | List all marks |

## Advanced Techniques

| Command | Description |
|---------|-------------|
| `3w` | Move forward 3 words |
| `5j` | Move down 5 lines |
| `d2}` | Delete 2 paragraphs |
| `y3f.` | Yank from cursor to 3rd occurrence of . |
| `ci(` | Change the contents inside parentheses |
| `.` | Repeat last change |
| `@:` | Repeat last command |
| `zz` | Center cursor on screen |
| `zt` | Move cursor to top of screen |
| `zb` | Move cursor to bottom of screen |

## Mode Switching

| Command | Description |
|---------|-------------|
| `i` | Enter insert mode before cursor |
| `I` | Enter insert mode at beginning of line |
| `a` | Enter insert mode after cursor |
| `A` | Enter insert mode at end of line |
| `o` | Open new line below and enter insert mode |
| `O` | Open new line above and enter insert mode |
| `v` | Enter visual mode |
| `V` | Enter visual line mode |
| `Ctrl+v` | Enter visual block mode |
| `Esc` | Return to normal mode |

## Practice Progression

1. Master `h`, `j`, `k`, `l` for basic movement
2. Learn word motions with `w`, `e`, `b`
3. Practice line navigation with `0`, `^`, `$`
4. Add vertical movement with `gg`, `G`, `Ctrl+u`, `Ctrl+d`
5. Incorporate character search with `f`, `t`
6. Learn text objects and operators
7. Master jump motions and search
8. Use marks for efficient navigation
9. Combine with counts and advanced techniques
