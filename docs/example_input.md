---
---


## This is a test notebook Hello

This is a shell command:


```bash
echo "hello world"
```

    hello world


We are writing a python script to disk:


```py title="myflow.py"
from metaflow import FlowSpec, step

class MyFlow(FlowSpec):
    
    @step
    def start(self):
        print('this is the start')
        self.next(self.end)
    
    @step
    def end(self):
        print('this is the end')

if __name__ == '__main__':
    MyFlow()
```

Another shell command where we run a flow:


```bash
python myflow.py run
```

    

This is a normal python cell:




    2



The next cell has a cell tag of `remove_input`, so you should only see the output of the cell:

    hello, you should not see the print statement that produced me

