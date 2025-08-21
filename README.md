# Devcontainer for Zephyr

## Prerequisites

- [docker](https://docker.com) can be used with user privileges. Test with `docker ps` and see if you observe an error.
- [Visual Studio Code](https://code.visualstudio.com/download) with [devcontainer extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

> :warning: **Do not install the Snap variant as hardware access can be limited**

## Usage

This repo will live next to your `zephyr` repository in your workspace. Therefore you need to create your workspace folder first and then clone this repository into it.

```
workspace
└── zephyr-school-devcontainer
```

1. Create a folder to be your zephyr workspace `mkdir workspace`
2. Switch to that folder `cd workspace`
3. Clone this repository `git clone ...`
4. Open the just cloned folder with VS Code
5. If not prompted select `Reopen in Container` from the command palette
6. Wait for the container to be pulled and created

From the `devcontainer.json` file the workspace is automatically setup with a Zephyr SDK container, additional tools and some useful extensions to work with Zephyr. The Zephyr SDK container version is provided as a build argument for the `Dockerfile`. After the container is built the`post-create.sh` is executed automatically to pull the given Zephyr upstream version and setup some paths.

The setup process will take some time as a few GBs are fetched from remote locations so the time is highly dpendend on your internet connection speed. For example with a `50 MBit/s` connection the download of the `6 GB` container will take around **15 mins** and pulling all the Zephyr sources also **5 mins**. So time for a good coffee break. Also this is a one-time effort so the next time you start your workspace it shouldn't take a noticeable time compared to other applications.

After all the setup is done your folder structure should look liked

```
workspace
├── .venv
├── .west
├── bootloader
├── modules
├── tools
├── zephyr
├── zephyr-school-devcontainer
├── .clang-format
└── .clangd
```

## Test the toolchain

Open a new terminal in VS Code. Make sure the *Python virtual environment* is activated (it is configured to do this automatically). This is indicated by a prepended `(.venv)` to your terminal prompt. The output looks like:

```
user@0356b1301ab4:/workspace$ source /workspace/.venv/bin/activate
(.venv) user@0356b1301ab4:/workspace$
```

On a fresh install this might not always be the case but reloading the window also restarts the  extensions and will apply the settings. This is done by using the `Developer: Reload Window` command from the *command palette*. The *command palette* can be accessed either with the default shortcut `Ctrl + Shift + p` or by usign the menu `View -> Command Palette`.

Select a board of your choice from all the boards Zephyr supports out of the box

```
west boards
```

Build the `hello-world` application for it. For example for a [Nordic nRF52840 DK](https://www.nordicsemi.com/Products/Development-hardware/nRF52840-DK):

```
west build -p auto -b nrf52840dk/nrf52840 zephyr/samples/hello_world
```

After the build is done (takes a few seconds on modern hardware) the output should look like:

```
-- west build: building application
[1/144] Preparing syscall dependency handling

[2/144] Generating include/generated/zephyr/version.h
-- Zephyr version: 4.2.0 (/workspace/zephyr), build: v4.2.0-26-g8b5e0388cf34
[144/144] Linking C executable zephyr/zephyr.elf
Memory region         Used Size  Region Size  %age Used
           FLASH:       18588 B         1 MB      1.77%
             RAM:        4480 B       256 KB      1.71%
        IDT_LIST:          0 GB        32 KB      0.00%
Generating files from /workspace/build/zephyr/zephyr.elf for board: nrf52840dk
(.venv) user@0356b1301ab4:/workspace$
```
