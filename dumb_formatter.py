#!/usr/bin/env python3

def indent_str(level: int, indent_size: int) -> str:
    return " " * (level * indent_size)

def format_code_iterator(code: str, indent_size: int = 2):
    indent_level = 0
    previous_char = None

    for char in code:
        if char == " " and previous_char == " ":  # Reducir múltiples espacios a uno
            continue
        if char in "{[(":
            yield f"\n{indent_str(indent_level, indent_size)}{char}\n"
            indent_level += 1
            yield indent_str(indent_level, indent_size)
        elif char in "}])":
            yield "\n"
            indent_level -= 1
            yield f"{indent_str(indent_level, indent_size)}{char}"
        elif char == ",":
            yield f"\n{indent_str(indent_level, indent_size)}{char}"
        elif char != "\n":  # Ignorar saltos de línea adicionales
            yield char
        previous_char = char

def format_code(code: str):
    for part in format_code_iterator(code):
        print(part, end="")

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        input_code = sys.argv[1]
        format_code(input_code)
    else:
        try:
            while True:
                input_code = sys.stdin.read()
                if not input_code:
                    break
                format_code(input_code)
        except (EOFError, KeyboardInterrupt):
            pass

