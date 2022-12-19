#!/usr/bin/env python3
###
# Command line tool for managing Open Vault database
###
import click


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
    """Database CLI
    Management of Open Vault production databases
    """

    click.echo(f"context set to { context }")
    click.echo(f"deploying branch { branch }")


if __name__ == "__main__":
    deploy()
