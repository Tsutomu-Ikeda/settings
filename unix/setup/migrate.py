import os
import re


def translate(command):
    def is_meta(ch):
        return ((ch > 0x83 and ch < 0x9e) or ch == 0xa0 or ch == 0x83 or ch == 0)

    def replace_operator(text):
        return text.replace('; and ', '&&').replace('; or ', '||')

    result = bytearray()
    for c in replace_operator(command).encode("utf-8"):
        if is_meta(c):
            d = 0x83
            result.append(d)
            d = c ^ 32
            result.append(d)
        else:
            result.append(c)
    return result


def generate_zsh_history():
    result = bytearray()
    with open(os.path.expanduser('~/.local/share/fish/fish_history')) as f:
        line = True
        while line:
            line = f.readline()
            if line and re.match('^- cmd:', line):
                meta, command = line.split('- cmd: ', 1)
                line = f.readline().strip()

                if line and re.match('^when:', line):
                    meta, when = line.split('when: ', 1)
                    result += translate(command)
    return bytes(result)


def write_history(history):
    with open(os.path.expanduser('~/.zsh_history'), 'bw') as o:
        o.write(history)


if __name__ == "__main__":
    write_history(generate_zsh_history())
