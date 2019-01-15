# cl-tutor

![cl-tutor](screenshot/img02.png)

Common Lisp Learning System on lem

## Platform

macOS, Linux

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

1. start cl-tutor

　　If you added `.roswell/bin` to PATH, you can use `cl-tutor` command.

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
![cl-tutor](screenshot/intro1.png)

3. answer the questions on the editor
![cl-tutor](screenshot/intro2.png)

4. type F5(Function5) to check your answer 
![cl-tutor](screenshot/intro3.png)

## Copyright

Copyright (c) tcool 2019

## License

Licensed under the LLGPL License.
