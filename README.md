[![MIT License](https://raw.githubusercontent.com/Jakuje/check-ansible-action/main/.github/license.svg?sanitize=true)](https://github.com/Jakuje/check-ansible-action/blob/main/LICENSE)

# Check Ansible Action

This action allows you to test your ansible role or your playbook in specific Container Image.

## Usage

To use the action simply create an `ansible-check.yml` _(or choose custom `\*.yml` name)_ in the `.github/workflows/` directory.

For example:

```yaml
name: Check Ansible on latest Fedora

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      # Important: This sets up your GITHUB_WORKSPACE environment variable
      - uses: actions/checkout@v6

      - name: Run checks
        # replace "main" with any valid ref
        uses: Jakuje/check-ansible-action@main
        with:
          image: "fedora:latest"
          #  [required]
          #   The container image to use
          #   Some Examples:
          #   image: "fedora:rawhide"
          #   image: "ubuntu:noble"
          #
          targets: "./"
          #  [required]
          #   Paths to your ansible role or playboox.yml you want to test
          #   Some Examples:
          #   targets: "role/my_role/"
          #   targets: "site.yml"
          #
          # group: ""
          #  [optional]
          #   When testing playbooks you have to tell ansible
          #   the group you that we write in our hosts file.
          #   example:
          #   group: 'servers'
          #
          # hosts: ""
          #  [optional]
          #   When testing playbooks you have to give one example
          #   host this action should use to test your playbook.
          #   > We only spawn one docker container that mean
          #   > we can only test one host at the time. Sorry
          #   some examples:
          #   hosts: 'localhost'
          #   hosts: 'srv01.example.com'
          #
          # requirements: ""
          #  [optional]
          #   When testing playbooks and you are using ansible galaxy,
          #   you may be interested in installing your requirements
          #   from ansible galaxy.
          #   To do this please provide us either the role name directly
          #   requirements: 'do1jlr.ansible_version'
          #   or your requiements.yml file.
          #   requirements: 'requirements.yml'
```

Alternatively, you can run the ansible check only on certain branches:

```yaml
on:
  push:
    branches:
      - stable
      - release/v*
```

or on various [events](https://help.github.com/en/articles/events-that-trigger-workflows)

<br/>

## Contributing

If you are missing a feature or see a bug. Please report it. Or - if you like - open a pull-request.

## License

The Dockerfile and associated scripts and documentation in this project are released under the [MIT License](LICENSE).

## Credits

The initial GitHub action has been created by [Stefan Stölzle](https://github.com/stoe) at
[stoe/actions](https://github.com/stoe/actions).<br/>
It was used by ansible for lint checks at [ansible/ansible-lint-action](https://github.com/ansible/ansible-lint-action.git)<br/>
It was modified from [L3D](https://github.com/do1jlr) to check ansible roles and playbooks.<br/>
And then generalized by [Jakub Jelen](https://github.com/Jakuje) to be more generic in regards to the container images.
