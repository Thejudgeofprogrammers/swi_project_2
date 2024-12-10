:- module(database, [
    load_database/0,
    save_database/0,
    view_database/0,
    add_record/0,
    delete_record/0,
    edit_record/0,
    employee/7  % Экспорт предиката employee
]).

:- dynamic employee/7.

% Предикат для загрузки базы данных
load_database :-
    (   exists_file('data/employees.pl') 
    ->  consult('data/employees.pl')
    ;   writeln('База данных не найдена. Создание новой базы данных...'),
        open('data/employees.pl', write, Stream),
        writeln(Stream, '% Database of employees'),
        close(Stream)
    ).

save_database :-
    absolute_file_name('data/employees.pl', FilePath),
    open(FilePath, write, Stream),
    forall(
        employee(FIO, DOB, Position, Rank, Experience, Stakes, Type),
        format(Stream, 'employee(~q, ~q, ~q, ~q, ~q, ~q, ~q).~n',
               [FIO, DOB, Position, Rank, Experience, Stakes, Type])
    ),
    close(Stream).

view_database :-
    writeln('--- Сотрудники ---'),
    writeln('ФИО | Дата рождения | Должность | Разряд | Стаж | Ставки | Вид найма'),
    forall(employee(FIO, DOB, Position, Rank, Experience, Stakes, Type),
           format('~w, ~w, ~w, ~w, ~w лет, ~w, ~w~n', [FIO, DOB, Position, Rank, Experience, Stakes, Type])).

add_record :-
    writeln('Введите ФИО:'), read(FIO),
    writeln('Введите дату рождения (формат dd-mm-yyyy):'), read(DOB),
    writeln('Введите должность:'), read(Position),
    writeln('Введите разряд ЕТС:'), read(Rank),
    writeln('Введите стаж работы (в годах):'), read(Experience),
    writeln('Введите количество ставок:'), read(Stakes),
    writeln('Введите вид найма (постоянный/совместитель):'), read(Type),
    assertz(employee(FIO, DOB, Position, Rank, Experience, Stakes, Type)),
    writeln('Запись добавлена!').

delete_record :-
    writeln('Введите ФИО сотрудника для удаления:'), read(FIO),
    retract(employee(FIO, _, _, _, _, _, _)), 
    writeln('Запись удалена!'), !.
delete_record :- writeln('Запись не найдена.').

edit_record :-
    writeln('Введите ФИО сотрудника для редактирования:'), read(FIO),
    retract(employee(FIO, _, _, _, _, _, _)), !,
    add_record.
edit_record :- writeln('Запись не найдена.').
