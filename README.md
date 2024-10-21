<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 3</b><br/>
"Конструктивний і деструктивний підходи до роботи зі списками"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: КВ-11 Гультяєв Дмитро</p>
<p align="right"><b>Рік</b>: 2024</p>

## Загальне завдання

Реалізуйте алгоритм сортування чисел у списку двома способами: функціонально і
імперативно.
1. Функціональний варіант реалізації має базуватись на використанні рекурсії і
конструюванні нових списків щоразу, коли необхідно виконати зміну вхідного
списку. Не допускається використання: деструктивних операцій, циклів, функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Також реалізована функція не має
бути функціоналом (тобто приймати на вхід функції в якості аргументів).

2. Імперативний варіант реалізації має базуватись на використанні циклів і
деструктивних функцій (псевдофункцій). Не допускається використання функцій
вищого порядку або функцій для роботи зі списками/послідовностями, що
використовуються як функції вищого порядку. Тим не менш, оригінальний список
цей варіант реалізації також не має змінювати, тому перед виконанням
деструктивних змін варто застосувати функцію copy-list (в разі необхідності).
Також реалізована функція не має бути функціоналом (тобто приймати на вхід
функції в якості аргументів).

## Варіант 5
Алгоритм сортування обміном №2 (із використанням прапорця) за незменшенням.

## Лістинг функції з використанням конструктивного підходу
```lisp
(defun swap (lst)
  (cond
    ((or (null lst) (null (rest lst)))
     (values lst nil))

    ((> (first lst) (second lst))
     (multiple-value-bind (rest-of-list new-flag) (swap (cons (first lst) (rest (rest lst))))
       (values (cons (second lst) rest-of-list) t)))

    (t (multiple-value-bind (rest-of-list new-flag) (swap (rest lst))
         (values (cons (first lst) rest-of-list) new-flag)))))

(defun sort-func (lst)
    (multiple-value-bind (new-list flag) (swap lst)
      (if flag
          (sort-func new-list)
          new-list)))
```
### Тестові набори
```lisp
(defun check-first-function (name input expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (sort-func input) expected)
        name))

(defun test-first-function ()
    (check-first-function "test 1" '(5 3 4 1 2) '(1 2 3 4 5))  
    (check-first-function "test 2" '(1 2 3 4 5) '(1 2 3 4 5)) 
    (check-first-function "test 3" '(1 1 1 1 1) '(1 1 1 1 1))
    (check-first-function "test 4" '(2 2 3 3 1) '(1 2 2 3 3))
    (check-first-function "test 5" nil nil))
```
### Тестування
```lisp
CL-USER> (test-first-function)
passed test 1
passed test 2
passed test 3
passed test 4
passed test 5
```
## Лістинг функції з використанням деструктивного підходу
```lisp
(defun sort-imper(lst)
    (let ((copy (copy-list lst)) (r (- (length lst) 1)) (flag t))
    
    (do () ((not flag))
      (setf flag nil)
      (dotimes (i r)
        (when (> (nth i copy) (nth (1+ i) copy))
          (let ((b (nth i copy)))
            (setf (nth i copy) (nth (1+ i) copy))
            (setf (nth (1+ i) copy) b)
            (setf flag t)))))
    
    copy    
)) 
```
### Тестові набори
```lisp
(defun check-second-function (name input expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (sort-imper input) expected)
        name))

(defun test-second-function ()
    (check-second-function "test 1" '(5 3 4 1 2) '(1 2 3 4 5))  
    (check-second-function "test 2" '(1 2 3 4 5) '(1 2 3 4 5)) 
    (check-second-function "test 3" '(1 1 1 1 1) '(1 1 1 1 1))
    (check-second-function "test 4" '(2 2 3 3 1) '(1 2 2 3 3))
    (check-second-function "test 5" nil nil))
```
### Тестування
```lisp
CL-USER> (test-second-function)
passed test 1
passed test 2
passed test 3
passed test 4
passed test 5
```
