# latex-env

This is a Docker image for TeX Live.

## Table of Contents

- [Install](#install)
- [Usage](#usage)
- [VScode setting](#vscode-setting)

## Install

```bash
$ docker pull schnell3526/latex-env
```

## Usage

```bash
$ docker run --rm -v $PWD:/workdir schnell3526/latex-env latexmk sample.tex
```

or

```bash
$ docker run --rm -v $PWD:/workdir schnell3526/latex-env uplatex sample.tex
$ docker run --rm -v $PWD:/workdir schnell3526/latex-env dvipdfmk sample.dvi
```


## VScode setting

install latex-workshop

### for MacOS

add bellow sentences to setting.json ([ Ctrl+, ] → [open setting(json)])

```json
    "latex-workshop.latex.recipes": [
        {
            "name": "compile",
            "tools": [
                "latexmk"
            ]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%DIR%:/workdir",
                "schnell3526/latex-env",
                "latexmk",
                "/workdir/%DOCFILE_EXT%"
            ]
        }
    ],
    "latex-workshop.latex.autoBuild.run": "onFileChange",
    "latex-workshop.docker.enabled": false
```

### for Windows

add bellow sentences in setting.json([ Ctrl+, ] → [open setting(json)])

```json
    "latex-workshop.latex.recipes": [
        {
            "name": "compile",
            "tools": [
                "latexmk"
            ]
        }
    ],
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "docker",
            "args": [
                "run",
                "--rm",
                "-v",
                "%DIR_W32%:/workdir",
                "schnell3526/latex-env",
                "latexmk",
                "-l",
                "/workdir/%DOCFILE_EXT%"
            ]
        }
    ],
    "latex-workshop.latex.autoBuild.run": "onFileChange",
    "latex-workshop.docker.enabled": false
```