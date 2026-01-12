DROP DATABASE IF EXISTS SocialLab;
CREATE DATABASE SocialLab;
USE SocialLab;

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    content TEXT,
    author VARCHAR(100),
    likes_count INT DEFAULT 0
);

DELIMITER //
CREATE PROCEDURE sp_CreatePost(
    IN p_content TEXT,
    IN p_author VARCHAR(100),
    OUT p_post_id INT
)
BEGIN
    INSERT INTO posts (content, author) 
    VALUES (p_content, p_author);
    
    SET p_post_id = LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_SearchPost(
    IN p_keyword VARCHAR(255)
)
BEGIN
    SELECT * FROM posts 
    WHERE content LIKE CONCAT('%', p_keyword, '%');
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_IncreaseLike(
    IN p_post_id INT,
    INOUT p_likes_count INT
)
BEGIN
    UPDATE posts 
    SET likes_count = likes_count + 1 
    WHERE post_id = p_post_id;
    
    SELECT likes_count INTO p_likes_count 
    FROM posts 
    WHERE post_id = p_post_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_DeletePost(
    IN p_post_id INT
)
BEGIN
    DELETE FROM posts WHERE post_id = p_post_id;
END //
DELIMITER ;

CALL sp_CreatePost('Hello world from MySQL!', 'Alice', @id1);
SELECT @id1 AS 'Post ID 1';

CALL sp_CreatePost('Learning stored procedures', 'Bob', @id2);
SELECT @id2 AS 'Post ID 2';

CALL sp_SearchPost('hello');

SET @current_likes = 0;
CALL sp_IncreaseLike(@id1, @current_likes);
SELECT @current_likes AS 'Likes sau khi tăng';

CALL sp_DeletePost(@id2);

SELECT * FROM posts;


DROP PROCEDURE IF EXISTS sp_CreatePost;
DROP PROCEDURE IF EXISTS sp_SearchPost;
DROP PROCEDURE IF EXISTS sp_IncreaseLike;
DROP PROCEDURE IF EXISTS sp_DeletePost;