use social_network_pro;

delimiter $$
drop procedure if exists CalculatePostLikes$$
create procedure CalculatePostLikes(in p_post_id int, out total_likes int)
begin
    select count(*) into total_likes from likes 
    where post_id = p_post_id;
end$$
delimiter ;

set @total_likes = 0;
call CalculatePostLikes(102, @total_likes);
select @total_likes as total_likes;
drop procedure if exists CalculatePostLikes;