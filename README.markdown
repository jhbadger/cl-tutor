# cl-tutor

![cl-tutor](screenshot/img01.png)　　


![cl-tutor](screenshot/img02.png)　　


## You are the one.

Do you want some lisper's friends?

Then use **cl-tutor** and hold a seminar in your town.

We built a learning system to study Lisp using [Practical Common Lisp](http://www.gigamonkeys.com/book).

You can start to hold a CL seminar as soon as you install cl-tutor.

## Platform

- MacOS 10.13

- Linux

- Windows(WSL)

## Installation

Please install roswell at first.

[Roswell Installation Guide](https://github.com/roswell/roswell/wiki/Installation)

After that, please install lem and cl-tutor.

```
1. install lem
$ ros install cxxxr/lem

2. install cl-tutor
$ ros install t-cool/cl-tutor
```

## Usage

Please watch the screencast, in which we show you how to use cl-tutor:

[![screencast](https://img.youtube.com/vi/1Ymuet3Q6ic/0.jpg)](https://www.youtube.com/watch?v=1Ymuet3Q6ic)


1. start cl-tutor
```
$ ros run
? (ql:quickload :cl-tutor)
? (cl-tutor:start)
```

2. choose the chapter

3. answer the questions on the editor

4. type F5(Function5) to check your answer
 
5. see the test result on the REPL

6. If you answer all the questions, the chapter will get checked n the list.


## Copyright

Copyright (c) tcool 2018

## License

Licensed under the LLGPL License.
