import sys
import json
import os
from pathlib import Path

INSTALL_EXTENSIONS = [
    "coenraads.bracket-pair-colorizer-2",
    "ms-python.python",
    "oderwat.indent-rainbow",
    "shardulm94.trailing-spaces"
]

def install_extensions():
    for extension_name in INSTALL_EXTENSIONS:
        cmd = f"code --install-extension {extension_name} > NUL 2> NUL"
        rc = os.system(cmd)
        if rc != 0:
            print(f"Error executing {cmd}", file=sys.stderr)
            exit(rc)


CUSTOM_SETTINGS = {
    "terminal.integrated.defaultProfile.windows": "Git Bash"
}

def apply_vscode_settings():

    APPDATA = os.getenv("APPDATA")
    code_settings = Path(APPDATA, "Code", "User", "settings.json")
    tmp_codes_setttings = Path(APPDATA, "Code", "User", "settings.json.tmp")
    if not code_settings.parent.exists():
        os.makedirs(code_settings.parent)

    config_json = {}
    try:
        with open(code_settings) as vscode_config:
            config_json = json.load(vscode_config)
    except FileNotFoundError:
        pass

    config_json.update(CUSTOM_SETTINGS)
    with open(tmp_codes_setttings, 'wt') as vscode_config:
        json.dump(config_json, vscode_config, indent=4)

    if code_settings.exists():
        os.unlink(code_settings)
    os.rename(tmp_codes_setttings, code_settings)

install_extensions()
apply_vscode_settings()
print("All good")
