"""
Delete xonsh shell history by matching patterns
i.e. `python delete-history.py "^ping"` will delete every history command that starts with "ping"
"""
import json
from json import JSONDecodeError
from pathlib import Path

import click
import os
import re

from click import echo

HISTORY_DIR = Path('~/.local/share/xonsh').expanduser()


@click.command()
@click.argument('pattern')
@click.option('-y', '--yes', help='auto confirm', is_flag=True)
def main(pattern, yes):
    """Delete xonsh history entries that match a pattern"""
    pattern = re.compile(pattern)
    files = [file for file in os.listdir(HISTORY_DIR) if file.startswith('xonsh-')]
    deleted = []
    count = 0
    for file in files:
        filepath = HISTORY_DIR / file
        if not filepath.is_file():
            continue
        with open(filepath) as f:
            stream = f.read()
            if not stream:
                continue
            try:
                data = json.loads(stream)
            except JSONDecodeError:
                echo(f'could not read history file: {filepath}', err=True)
                continue
            cmds = []
            for cmd in data['data']['cmds']:
                if cmd['inp'] in deleted:
                    continue
                if pattern.search(cmd['inp']):
                    if yes or click.confirm(f'del "{cmd["inp"].strip()}"', default=True):
                        deleted.append(cmd['inp'])
                        count += 1
                        continue
                cmds.append(cmd)
            data['data']['cmds'] = cmds
            with open(filepath, 'w') as f:
                f.write(json.dumps(data))
    echo(f'deleted {count} history entries')



if __name__ == '__main__':
    main()
