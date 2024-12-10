:- module(search, [search_menu/0]).

search_menu :-
    writeln('1. Поиск по ФИО (подстрока)'),
    writeln('2. Постоянные сотрудники по стажу (диапазон)'),
    writeln('3. Расчет зарплаты'),
    writeln('4. Минимальное и максимальное значение ставок'),
    read(Choice),
    handle_search_choice(Choice).

handle_search_choice(1) :-
    writeln('Введите подстроку для поиска:'), 
    read(Substr),
    (   forall(
            employee(FIO, DOB, Position, Rank, Experience, Stakes, Type),
            (   sub_string(FIO, _, _, _, Substr) ->
                format('~w, ~w, ~w, ~w, ~w лет, ~w, ~w~n', 
                       [FIO, DOB, Position, Rank, Experience, Stakes, Type])
            ;   true
            )
        )
    ->  true
    ;   writeln('Ошибка поиска.')
    ).

handle_search_choice(2) :-
    writeln('Введите минимальный стаж:'), 
    read(Min),
    writeln('Введите максимальный стаж:'), 
    read(Max),
    (   findall(
            employee(FIO, DOB, Position, Rank, Experience, Stakes, Type),
            (   employee(FIO, DOB, Position, Rank, Experience, Stakes, Type),
                Experience >= Min,
                Experience =< Max
            ),
            Results
        ),
        Results \= [] ->
        (   writeln('Сотрудники с подходящим стажем:'),
            forall(
                member(employee(FIO, DOB, Position, Rank, Experience, Stakes, Type), Results),
                format('~w, ~w, ~w, ~w, ~w лет, ~w, ~w~n', 
                       [FIO, DOB, Position, Rank, Experience, Stakes, Type])
            )
        )
    ;   writeln('Нет сотрудников, соответствующих заданным критериям.')
    ).

handle_search_choice(3) :- calculate_salary.
handle_search_choice(4) :- find_min_max_stakes.

calculate_salary :- 
    writeln('Введите базовую ставку:'), 
    read(BaseSalary),
    forall(
        employee(FIO, _, _, Rank, Experience, Stakes, _),
        (   (Experience > 5 -> Bonus = 0.07 * BaseSalary ; Bonus = 0),
            Salary is BaseSalary * Rank * Stakes + Bonus,
            format('~w: ~w руб.~n', [FIO, Salary])
        )
    ).

find_min_max_stakes :-
    findall(Stakes, employee(_, _, _, _, _, Stakes, _), StakesList),
    min_member(Min, StakesList),
    max_member(Max, StakesList),
    format('Минимальное количество ставок: ~w~n', [Min]),
    format('Максимальное количество ставок: ~w~n', [Max]).
