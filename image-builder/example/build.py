#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
from pathlib import Path

from invoke import run, sudo
from openwrt_pybuilder.imagebuilder import Config, OpenwrtImageBuilder


def build(config: Config):
    builder = OpenwrtImageBuilder(config)
    bin_dir = f"{config.name}-bin"
    temp_dir = f"{config.name}-temp"

    sudo(f"rm -rf {bin_dir}")
    run("rm -rf %s/ && mkdir -p %s/files" % (temp_dir, temp_dir))
    run("rm -rf %s/ && mkdir -p %s/packages" % (temp_dir, temp_dir))
    builder.copy_files(temp_dir)
    builder.build_docker()
    builder.build_image()
    builder.remove_instance()
    sudo(f"chown -R $USER:$USER {bin_dir}")
    run(f"rm -rf {temp_dir}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Build script")
    parser.add_argument(
        "--config", type=str, required=True, help="Path to the config file"
    )
    args = parser.parse_args()

    build_config_path = args.config
    build_config = Config(Path(build_config_path))
    if build_config is not None:
        print(build_config.name)
        print(build_config.env_file)

    build(build_config)
