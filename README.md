---
slug: /
title: Authoring Guide
---


<!--- WARNING: THIS FILE WAS AUTOGENERATED! DO NOT EDIT! Instead, edit the notebook w/the location & name as this file.-->

# Beautiful Technical Documentation with nbdoc and Docusarus

> [nbdoc](https://github.com/outerbounds/nbdoc) is a lightweight version of [nbdev](https://github.com/fastai/nbdev) that allows you to create rich, testable content with notebooks.  [Docusarus](https://docusaurus.io/) is a beautiful static site generator for code documentation and blogging.  This project brings all of these together to give you a powerful documentation system.

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

    
The unchecked items are a work in progress.  There are some tools that offer some of these features such as [Jupyter Book](https://jupyterbook.org/intro.html) and [Quarto](https://quarto.org/), but we wanted more flexibility with regards to the static site generator and desired additional features not available on those platforms.

## Setup


1. First, create an isolated python environment using your favorite tool such as `conda`, `pipenv`, `poetry` etc.  Then, from the root of this repo run this command in the terminal:

    ```sh
    make install
    ```

2. Then you need to open 3 different terminal windows (I recommend using split panes), and run the following commands in three seperate windows:

    _Note: we tried to use docker-compose but had trouble getting some things to run on Apple Silicon, so this will have to do for now._

    Start the docs server:
    
    ```shell
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

3. Open a browser window for the docs [http://localhost:3000/](http://localhost:3000/).  In my experience, you may have to hard-refresh the first time you make a change, but hot-reloading generally works.

## Authoring In Notebooks

**For this tutorial to make the most sense, you should view this notebook and the rendered doc side-by-side.  This page is called "Authoring Guide" and is the default page at the root when you start the site.**  This tutorial assumes you have some familiarity with static site generators, if you do not, please visit the [Docusarus docs](https://docusaurus.io/docs).

### Create Pages With Notebooks

You can create a notebook in any directory.  When you do this, an associated markdown file is automatically generated with the same name in the same location.  For example `intro.ipynb` generates `intro.md`.  For pages that are created with a notebook, you should always edit them in a notebook.  The markdown that is generated can be useful for debugging, but should not be directly edited a warning message is present in auto-generated markdown files.

However, using notebooks in the first place is optional. You can create Markdown files as you normally would to create pages.  We recommend using notebooks whenever possible, as you can embed arbitrary Markdown in notebooks, and also use `raw cells` for things like front matter or MDX components. 

### Front Matter & MDX

The first cell of your notebook should be a `raw` cell with the appropriate front-matter.  For example, this notebook has the following front matter:

```
---
slug: /
title: Authoring Guide
---
```

### Python Scripts In Docs

If you use the `%%writefile` magic, the magic command will get stripped from the cell, and the cell will be annotated with the appropriate filename as a title to denote that the cell block is referencing a script.  Furthermore, any outputs are removed when you use this magic command.


```py title="myflow.py"
from metaflow import FlowSpec, step


class MyFlow(FlowSpec):

    @step
    def start(self):
        self.some_data = ['some', 'data']
        self.next(self.middle)
        

    @step
    def middle(self):
        self.next(self.end)

    @step
    def end(self):
        pass


if __name__ == '__main__':
    MyFlow()
```

### Running shell commands

You can use the `!` magic to run shell commands.  When you do this, the cell is marked with the appropriate language automatically.  For Metaflow output, the preamble of the logs are automatically removed.


```bash
python myflow.py run
```

    2022-02-16 22:57:03.655 Workflow starting (run-id 1645081023652490):
    2022-02-16 22:57:03.665 [1645081023652490/start/1 (pid 81206)] Task is starting.
    2022-02-16 22:57:04.456 [1645081023652490/start/1 (pid 81206)] Task finished successfully.
    2022-02-16 22:57:04.471 [1645081023652490/middle/2 (pid 81211)] Task is starting.
    2022-02-16 22:57:05.287 [1645081023652490/middle/2 (pid 81211)] Task finished successfully.
    2022-02-16 22:57:05.299 [1645081023652490/end/3 (pid 81226)] Task is starting.
    2022-02-16 22:57:06.099 [1645081023652490/end/3 (pid 81226)] Task finished successfully.
    2022-02-16 22:57:06.100 Done!


You may wish to only show logs from particular steps when executing a Flow.  You can accomplish this by using the `#cell_meta:show_steps=<step_name>` comment:


```bash
python myflow.py run
```

    2022-02-16 22:57:07.536 [1645081027525826/start/1 (pid 81238)] Task is starting.
    2022-02-16 22:57:08.359 [1645081027525826/start/1 (pid 81238)] Task finished successfully.
    ...

You can show multiple steps by seperating step names with commas:


```bash
python myflow.py run
```

    2022-02-16 22:57:11.464 [1645081031453011/start/1 (pid 81258)] Task is starting.
    2022-02-16 22:57:12.281 [1645081031453011/start/1 (pid 81258)] Task finished successfully.
    ...
    2022-02-16 22:57:13.098 [1645081031453011/end/3 (pid 81268)] Task is starting.
    2022-02-16 22:57:13.929 [1645081031453011/end/3 (pid 81268)] Task finished successfully.
    ...

### Writing Interactive Code & Toggling Visibility

It can be useful to write interactive code in notebooks as well.  If you want to interact with a Flow, we recommend using the `--run-id-file <filemame>` flag.

Note we are hiding both the input and output of the below cell (because it is a bit repetitive in this case) with the `#cell_meta:tag=remove_cell` comment:

Now, you can write and run your code as normal and this will show up in the docs:


```python
run_id = !cat run_id.txt
from metaflow import Run
run = Run(f'Myflow/{run_id[0]}')

run.data.some_data
```




    ['some', 'data']



It is often smart to run tests in your docs.  To do this, simply add assert statements.  These will get tested automatically when we run the test suite.


```python
assert run.data.some_data == ['some', 'data']
assert run.successful
```

But what if you only want to show the cell input, but not the output.  Perhaps the output is too long and not necesary.  You can do this with the `#cell_meta:tag=remove_output` comment.


```python
print(''.join(['This output would be really annoying if shown in the docs\n'] * 10))
```

You may want to just show the output and not the input.  You can do that with the `#cell_meta:tag=remove_input` comment:

    You can only see the output, but not the code that created me
    You can only see the output, but not the code that created me
    You can only see the output, but not the code that created me
    


## Running Tests

To test the notebooks, run `make test`.  This will execute all notebooks in parallel and report an error if there are any errors found:

### Skipping tests in cells

If you want to skip certain cells from running in tests because they take a really long time, you can place the comment `#notest` at the top of the cell.

## Docusaurus

All Docusarus features will work because notebook markdown just becomes regular markdown.  Furthermore, special things such as MDX, JSX, or Front Matter can be created with a raw cell. For more information, visit [the Docusarus docs](https://docusaurus.io/docs).

### Docusaurus Installation

```
$ yarn
```

### Docusaurus Local Development

```
$ yarn start
```

This command starts a local development server and opens up a browser window. Most changes are reflected live without having to restart the server.

### Docusaurus Build

```
$ yarn build
```

This command generates static content into the `build` directory and can be served using any static contents hosting service.

### Docusaurus Deployment

Using SSH:

```
$ USE_SSH=true yarn deploy
```

Not using SSH:

```
$ GIT_USER=<Your GitHub username> yarn deploy
```

If you are using GitHub pages for hosting, this command is a convenient way to build the website and push to the `gh-pages` branch.
