from pathlib import Path
from venv import EnvBuilder

def build_env():
    print(Path.home().joinpath(".udevlab", "venv"))