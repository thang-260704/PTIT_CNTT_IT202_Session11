use social_network_pro;

delimiter $$
drop procedure if exists CalculateUserActivityScore$$
create procedure CalculateUserActivityScore(in p_user_id int, out activity_score int, out activity_level varchar(50))
begin
    declare posts_count int default 0;
    declare comments_count int default 0;
    declare likes_count int default 0;

    select count(*) into posts_count from posts
    where user_id = p_user_id;

    select count(*) into comments_count from comments
    where user_id = p_user_id;

    select count(*) into likes_count from likes l
    join posts p on p.post_id = l.post_id
    where p.user_id = p_user_id;

    set activity_score = posts_count * 10 + comments_count * 5 + likes_count * 3;
    set activity_level = case
        when activity_score >= 500 then "Rất tích cực"
        when activity_score between 200 and 500 then "Tích cực"
        else "Bình thường"
    end;
end$$
delimiter ;

set @score = 0;
set @level = '';
call CalculateUserActivityScore(7, @score, @level);
select @score as activity_score, @level as activity_level;
