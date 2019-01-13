#| =============================================================
レッスンを始める前に、cl-tutorの元になっているlemの操作方法をお伝えします。

# カーソル移動
 "C-a"というのは、Controlキーを押しながら、キーボードで"a"を押すという意味です。
 C-a : カーソルを行の先頭に移動する
 C-e : カーソルを行の末尾に移動する
 C-f : カーソルを右に移動する
 C-b : カーソルを左に移動する
 C-p : カーソルを上の行に移動する
 C-n : カーソルを下に移動する

# テキスト編集
 C-h : カーソル左の文字を消す
 C-d : カーソル上の文字を消す
 C-¥ : １つ前の操作を取り消す
 C-_ : １つ後の操作に戻る

# バッファ
cl-tutorの画面のそれぞれのセクションは、バッファと呼ばれます。
"C-x o"と打つことで、バッファー間でカーソルを移動できます。
"C-x o"は、"C-x"としたあと、一旦指を離してoを打つという意味です。

# ファイルの保存
C-x C-s : バッファーの状態をファイルに保存する
C-x C-c : ファイルを閉じる


# Searching (文字列検索)
C-s : 文字列を打ち込むと、対応するエリアがハイライトされます。
 ・ もう一度"C-s"をタイプすると、次の対応する文字列に移動します・
 ・ "C-r"とすると、前の対応する文字列に戻ります。
 ・ "C-f"とすると、そこでカーソルを抜けます。
 ・ "C-g"とすると、検索を終えます。

# 評価
"閉じ括弧から1つ右"にカーソルを移動し、C-x C-eとすると、計算結果が画面下に表示されます。
(+ 1 2 3)□ ←カーソルを左の□に合わせて、C-x C-eとしてください

# REPL
標準出力に値を出す関数を使うと、
値が右下のコンソール(REPL)に表示されます。
LispでコンソールはREPL(レプル)と呼ばれます。
 (print "Hello")
 (format t "Hi") 
右下のREPLに、"Hello" "Hi"と表示されます。

================================================================ |#

#| =============================================================
Before starting the lesson, let's see how to use cl-tutor.

# Cursor moving
"C-a" means that you need to type "a" pushing "Control" key. 
 C-a : Go to start of the line
 C-e : Go to end of the line
 C-f : Move cursor right one character
 C-b : Move cursor left one character
 C-p : Move the cursor to the previous line
 C-n : Move the cursor to the next line

# Editing the text
 C-h : Delete the letter before the cursor
 C-d : Delete the letter on the cursor
 C-¥ : Undo
 C-_ : Redo

# Buffur
You see three sections in the cl-tutor.
The sections are called "buffer".
You can move from one to another by "C-x o".
"C-x o" means that after pushing "C-x", you need to put off your fingers and then type "o".

# Saving a file
C-x C-s : Saving the buffer status in a file
C-x C-c : Close the file

# Searching
C-s : After typing the string, the coresponding area will get highlighted.
 ・ Typing "C-s" again, the cursor will move to the next one.
 ・ Typing "C-r", the cursor will get back to the previous one.
 ・ Typing "C-f", the cursor will stop at the point.
 ・ Typing "C-g", the seaching will end.

# Evaluation
"C-x C-e" : evaluate the S expression
 You need to type "C-x C-e" at the end of S-expression   
                               (+ 1 2 3)□ ← here!

# REPL
If you use the function that will send the result to *standard-output*, 
 the output was pronted on the console.
The console is called REPL /repl/ : Read, Evaluate, Print, and Loop. 
(print "Hello")
(format t "Hi") 
   "Hello" and "Hi" will be printed on the REPL.
============================================================= |#
