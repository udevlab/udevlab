from pip._internal.cli.main import main as cli_main # type: ignore
from pathlib import Path
from os import environ
import sys



def install_base_packages():
    print(sys.executable)
    scriptsPath = Path(Path(sys.executable).parent, "Scripts")
    environ["PATH"] += ":" + scriptsPath.as_posix()
    cli_main(['install', 'rich==10.7.0'])
