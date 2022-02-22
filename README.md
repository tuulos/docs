# Docusaurus + Notebooks

This project allows you to create rich, testable code documentation with notebooks.  Don't worry - You can still use markdown if you want to.


## Background: Literate Documentation

Writing technical documentation can be an ardous process.  Many projects have no documentation at all, and if they do they are often stale or out of date.  Our goal is to make writing documentation as easy as possible by providing the following:


- [x] **Authoring experience that encourages the creation** of quality documentation: (1) Write & run code in-situ - avoid copy & pasting code (2) WSYIWG or low-latency hot-reload experience so you can get immediate feedback on how your docs will look.
- [x] **Testing**: Automated testing of code snippets
- [x] **Unified Search**: Unified search across API docs, tutorials, how-to guides, user guides with a great user interface that helps users understand the source of each
- [x] Allow you to **highlight specific lines of code.**
- [x] Allow authors to **hide** cell inputs, outputs or both
- [ ] **Entity Linking**: Detect entities like modules and class names in backticks and automatically link those to the appropriate documentation.
- [ ] **Inline and side-by-side explanations** (pop-ups, two-column view, etc)
- [ ] Allow reader to **collapse/show** code and output

    
The unchecked items are a work in progress.  There are some tools that offer some of these features such as [Jupyter Book](https://jupyterbook.org/intro.html) and [Quarto](https://quarto.org/), but we wanted more flexibility with regards to the static site generator and desired additional features not available on those platforms.  We are currently using [nbdoc](https://github.com/outerbounds/nbdoc) and [Docusarus](https://docusaurus.io/) to compose our documentation system.

## Setup


1. First, create an isolated python environment using your favorite tool such as `conda`, `pipenv`, `poetry` etc.  Then, from the root of this repo run this command in the terminal:

    ```sh
    make install
    ```

2. Then you need to open 3 different terminal windows (I recommend using split panes), and run the following commands in three seperate windows:

    _Note: we tried to use docker-compose but had trouble getting some things to run on Apple Silicon, so this will have to do for now._

    Start the docs server:
    
    ```sh
    make docs
    ```

    Watch for changes to notebooks:
    
    ```sh
    make watch
    ```

    Start Jupyter Lab:
    
    ```sh
    make nb
    ```

3. Open a browser window for the docs [http://localhost:3000/](http://localhost:3000/).  You may have to hard-refresh the first time you make a change, but hot-reloading generally works.

## Start The Tutorial

To go through the tutorial, open the rendered docs in one window, and the notebook [intro.ipynb](docs/intro.ipynb) in another window.  Study the notebook cells and the corresponding rendered page carefully.

## Running Tests

To test the notebooks, run `make test` from the root of this repo.  This will execute all notebooks in parallel and report an error if there are any errors found:

### Skipping tests in cells

If you want to skip certain cells from running in tests because they take a really long time, you can place the comment `#notest` at the top of the cell.

## Setup Hotkeys For Jupyter

People complain about "state" in Jupyter.  This can be easily avoided by frequently restarting the kernel and running all cells from the top.  Thankfully, you can set a hotkey that allows you to do this effortlessly.  In Jupyter Lab, go to `Settings` then `Advanced Settings Editor`.  Copy and paste the below json into the `User Prefences` pane.  If you already have user-defined shortcuts, modify this appropriately.

```json
{
"shortcuts": [
{
    "command": "notebook:restart-run-all",
    "keys": [
        "Ctrl R",
        "R"
    ],
    "selector": "body",
},
{
    "command": "notebook:restart-and-run-to-selected",
    "keys": [
        "Ctrl R",
        "S"
    ],
    "selector": "body",
},
{
    "command": "notebook:move-cell-up",
    "keys": [
        "Ctrl Shift ArrowUp"
    ],
    "selector": ".jp-Notebook:focus"
},
{
    "command": "notebook:move-cell-down",
    "keys": [
        "Ctrl Shift ArrowDown"
    ],
    "selector": ".jp-Notebook:focus"
},
]
}
```
