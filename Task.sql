/* Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного)
пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно). */

create table users_old like users;

drop procedure if exists move_user;
delimiter //
create procedure move_user(in user_id int)
begin
    start transaction;
    insert into users_old
        select * from users where id = user_id;
    delete from users
        where id = user_id;

    if row_count() = 1 then
        commit;
        select 'OK';
    else
        rollback;
        select 'ERROR';
    end if;
end //
delimiter ;

call move_user(2);

select * from users_old;


/* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00
функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00
функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — 
"Добрый вечер", с 00:00 до 6:00 — "Доброй ночи". */

