/*	-	Top 5 pieces of content from each content type 
		consumed this week by only active users (using 
		the above definition).   */
		
drop table if exists active_users_consumption
create temp table active_users_consumption
as 		
select Content_id, count(Session_id) as consumption
from Page_Impression 
where Timestamp bwtween '2021-8-16' and '2021-8-20'
and Ads_user_id in (select Ads_user_id
					from Ad_service_interaction_data 
					where Timestamp bwtween '2021-8-16' and '2021-8-20'
					group by Ads_user_id
					having sum(Dwell_time)>60)
group by Content_id;

select * 
from (
	select ROW_NUMBER() OVER(PARTITION BY Content_type 
							ORDER BY consumption DESC) as ROW_NUM,
			a.content_type as content_type,
			a.content_id as content_id,
			b.consumption as consumption
	from Content_Metadata a
	join active_users_consumption b
	on a.Content_id = b.Content_id
	)
where ROW_NUM<=5;
