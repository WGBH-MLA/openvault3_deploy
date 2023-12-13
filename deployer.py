#!/usr/bin/env python3
###
# Command line tool for managing AAPB and OpenVault deployments
###
from os.path import realpath
from subprocess import PIPE, STDOUT
from subprocess import run as sub_run

import click

GITHUB_URL = 'https://github.com/WGBH-MLA/'


def run_interactive(cmd: str):
    """Run a shell command in an interactive terminal"""
    return sub_run(cmd, shell=True, capture_output=True, check=True).stdout.decode()


@click.command()
@click.argument(
    "context",
    required=True,
    type=click.Choice(["aapb", "aapb-demo", "openvault", "openvault-demo"]),
)
@click.argument(
    "branch",
    required=True,
)
def deploy(context, branch):
    """Deploy AAPB or OpenVault instance"""

    click.echo(f"Deploying: { context }")
    click.echo(f"Branch: { branch }")
    cmd = f"""docker run -it -v {realpath('')}:/root/ aapb-deploy"""

    sub_run(cmd, stdin=PIPE, stdout=PIPE, stderr=STDOUT)


if __name__ == "__main__":
    deploy()
