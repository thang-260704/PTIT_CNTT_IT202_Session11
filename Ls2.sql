use social_network_pro;

delimiter $$
drop procedure if exists show_posts_user$$
create procedure show_posts_user (in p_user_id int)
begin
    select post_id, content, created_at from posts
    where user_id = p_user_id order by created_at desc;
end$$
delimiter ;

call show_posts_user(7);