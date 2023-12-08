-- Mendetory Project --

use ig_clone;

-- 1. Create an ER diagram or draw a schema for the given database. --

-- screenshot will be attached --

-- now before going any further assign user_id to users first --

create temporary table user_dem
as
select * from users
order by created_at asc;
select * from user_dem;

alter table user_dem 
add column user_id int not null auto_increment primary key;

-- Now we can move on to the tasks -- 


-- 2. We want to reward the user who has been around the longest, Find the 5 oldest users. --

select * from users
order by date(created_at) asc
limit 5;

-- 3. To target inactive users in an email ad campaign, find the users who have never posted a photo. --

select username, u.user_id from user_dem as u
left join photos as p 
on u.user_id = p.user_id
where p.user_id is null;

-- 4. Suppose you are running a contest to find out who got the most likes on a photo. Find out who won? --

create temporary table u_n2
as
select distinct user_id, count(user_id) as No_of_picture from photos
group by user_id
order by No_of_picture desc
limit 1;

select * from u_n2;

select user_dem.username, u_n2.user_id, No_of_picture from user_dem
join u_n2 
on user_dem.user_id = u_n2.user_id;


-- 5. The investors want to know how many times does the average user post. --

create temporary table u_n3
as
select distinct user_id, count(id) as No_of_picture from photos
group by user_id;

select * from u_n3;

select avg(No_of_picture) from u_n3;


-- 6. A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags. --

create temporary table tag_group
as
select distinct tag_id as id, count(photo_id) as Tag_id_used_freq from photo_tags
group by id
order by Tag_id_used_freq desc
limit 5;

select * from tag_group;

select t1.tag_name, t2.Tag_id_used_freq from tags t1
left join tag_group t2
on t1.id = t2.id
where t2.id is not null;


-- 7. To find out if there are bots, find users who have liked every single photo on the site. --

select distinct l.user_id, u.username, count(l.photo_id) from likes as l
join user_dem as u 
on l.user_id = u.user_id
group by user_id
having count(l.photo_id) = (select count(id) as Total_no_photos from photos);

-- 8. Find the users who have created instagram id in may and select top 5 newest joinees from it? --

select username, created_at from users
where month(created_at) = 5
order by created_at desc
limit 5;

-- 9. Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?

create temporary table u_n
as
select distinct user_id from photos;

select * from u_n; -- this shows which user id posts a picture --

create temporary table u_l
as
select distinct user_id from likes;

select *  from u_l;  -- shows user id which likes any pictures --

select u.username, u.user_id from user_dem as u
inner join u_n 
on u.user_id = u_n.user_id
inner join u_l
on u_l.user_id = u_n.user_id
where u_n.user_id is not null and username regexp '^c.*[0-9]$';



-- 10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5. --

select * from u_n3;

select u.user_id, u.username, u_n3.No_of_picture from user_dem as u
inner join u_n3
on u.user_id = u_n3.user_id
where No_of_picture regexp '[3-5]'
order by No_of_picture desc
limit 30;