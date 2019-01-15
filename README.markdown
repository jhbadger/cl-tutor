# cl-tutor

![cl-tutor](screenshot/img02.png)　　

Common Lisp Learning System on lem

## Platform

MacOS, Linux

## Installation

1. install roswell and add `./roswell/bin` to PATH.

[Roswell Installation Guide](https://github.com/roswell/roswell/wiki/Installation)

2. install lem

```
$ ros install cxxxr/lem
```

3. install cl-tutor

```
$ ros install t-cool/cl-tutor
```

## Usage

Please watch the screencast:

[![screencast](https://img.youtube.com/vi/1Ymuet3Q6ic/0.jpg)](https://www.youtube.com/watch?v=1Ymuet3Q6ic)

1. start cl-tutor

If you add `.roswell/bin` to PATH, you can use `cl-tutor` command.

```
$ cl-tutor
```

You can also load cl-tutor by roswell REPL.

```
$ ros run
? (ql:quickload :cl-tutor)
? (cl-tutor:start)
```

2. choose the chapter

3. answer the questions on the editor

4. type F5(Function5) to check your answer 

## Copyright

Copyright (c) tcool 2019

## License

Licensed under the LLGPL License.
