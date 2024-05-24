#!/usr/bin/env python3

def check_duplicate_lines(file_path):
    lines_seen = set()
    duplicate_lines = []

    with open(file_path, 'r') as file:
        for line_num, line in enumerate(file, start=1):
            line = line.strip()  # Remove leading and trailing whitespaces
            if line in lines_seen:
                duplicate_lines.append((line_num, line))
            else:
                lines_seen.add(line)

    return duplicate_lines

if __name__ == "__main__":
    file_path = input("Enter the path to the text file: ")
    duplicates = check_duplicate_lines(file_path)

    if duplicates:
        print("Duplicate lines found:")
        for line_num, line in duplicates:
            print(f"Line {line_num}: {line}")
    else:
        print("No duplicate lines found in the file.")
