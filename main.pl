:- consult('database.pl'). % Подключение модуля для работы с базой данных
:- consult('search.pl').   % Подключение модуля для поиска
:- consult('salary.pl').   % Подключение модуля расчета зарплаты

:- initialization(load_database).
:- initialization(main_menu).

main_menu :-
    writeln('--- Кадровый учёт ---'),
    writeln('1. Просмотр базы данных'),
    writeln('2. Добавление записи'),
    writeln('3. Удаление записи'),
    writeln('4. Редактирование записи'),
    writeln('5. Поиск информации'),
    writeln('6. Сохранить и выйти'),
    read(Choice),
    handle_choice(Choice).

handle_choice(1) :- view_database, main_menu.
handle_choice(2) :- add_record, main_menu.
handle_choice(3) :- delete_record, main_menu.
handle_choice(4) :- edit_record, main_menu.
handle_choice(5) :- search_menu, main_menu.
handle_choice(6) :- save_database, writeln('База сохранена. Выход.'), halt.
handle_choice(_) :- writeln('Неверный выбор, попробуйте снова.'), main_menu.