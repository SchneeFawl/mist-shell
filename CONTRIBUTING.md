# Contributing to mist-shell

## How to Contribute

1. Fork the repo and clone it on your local machine
2. Run the `install-dev.sh` script (make sure to make it executable first). It will create symlinks in the `~/.config` directory and will backup the folders/files which will be modified.
3. Create a new branch from `main` using `git checkout -b fix/name`.Replace "fix" and "name" accordingly.
4. Make your changes and test it
5. Commit your changes with a clear message.
6. Push and open a pull request against the `main` branch.

---

## Development Setup

It is recommended to create a new user and install the shell to make changes but you can also use the `install-dev.sh` script creates backup of the files/folders which will be modified.

If your change requires a lot of new dependencies then note it down somewhere and mention it in the pull request. You can also add them to the `install.sh` script.

---

## Committing your Changes

- Be specific with your commit messages, don't put "fix bugs", "update code" or something similar.

- Make sure that the commit is in imperative mood, e.g: `fix: notification dismiss`.

---

## Branch Naming

- Feature: feat/short-description
- Bug fix: fix/short-description
- Refactor: refactor/short-description
