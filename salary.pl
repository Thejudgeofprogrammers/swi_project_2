:- module(salary, [calculate_salary/0, find_min_max_stakes/0]).

calculate_salary :- 
    writeln('Введите базовую ставку:'), read(BaseSalary),
    forall(employee(FIO, _, _, Rank, Experience, Stakes, _),
           (Bonus is (Experience > 5 -> 0.07 * BaseSalary; 0),
            Salary is BaseSalary * Rank * Stakes + Bonus,
            format('~w: ~w руб.~n', [FIO, Salary]))).

find_min_max_stakes :-
    findall(Stakes, employee(_, _, _, _, _, Stakes, _), StakesList),
    min_member(Min, StakesList),
    max_member(Max, StakesList),
    format('Минимальное количество ставок: ~w~n', [Min]),
    format('Максимальное количество ставок: ~w~n', [Max]).
